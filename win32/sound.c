#include "common.h"

#include <mmsystem.h>
#include "opl3.h"

#define SOUND_SAMPLE_RATE       48000
#define SOUND_CHANNELS          2
#define SOUND_N_BUFFERS         2
#define SOUND_BUFFER_SIZE_CH    2048
#define SOUND_VOLUME_MAX        0xFFFFFFFF
#define SOUND_VOLUME_MIN        0x0

static opl3_chip chip;
HWAVEOUT hWaveOut;
WAVEHDR waveHeaders[SOUND_N_BUFFERS] = { 0 };
int16_t audioBuffers[SOUND_N_BUFFERS][SOUND_BUFFER_SIZE_CH] = { 0 };

static int shouldReset = 0;

static void CALLBACK waveOutProc(HWAVEOUT hwo, UINT uMsg, DWORD_PTR dwInstance, DWORD_PTR dwParam1, DWORD_PTR dwParam2) {
    if (uMsg == WOM_DONE) {
        WAVEHDR* pHeader = (WAVEHDR*)dwParam1;
        int16_t* samples = (int16_t*)pHeader->lpData;
        for (int i = 0; i < SOUND_BUFFER_SIZE_CH / 2; i++) {
            OPL3_GenerateResampled(&chip, &samples[i * 2]);
        }
        waveOutWrite(hwo, pHeader, sizeof(WAVEHDR));

        //done here to avoid the chip being reset right in the middle of a write
        //it was rare but when it happened it caused a crash
        //turns out this callback is called from another thread, the more you know
        if(shouldReset){
            OPL3_Reset(&chip, SOUND_SAMPLE_RATE);
            shouldReset = 0;
        }
    }
}

void sound_reset(void){
    shouldReset = 1;
}

BOOL sound_init(void){
    OPL3_Reset(&chip, SOUND_SAMPLE_RATE);

    WAVEFORMATEX wfx;
    wfx.wFormatTag = WAVE_FORMAT_PCM;
    wfx.nChannels = SOUND_CHANNELS;
    wfx.nSamplesPerSec = SOUND_SAMPLE_RATE;
    wfx.wBitsPerSample = 16;
    wfx.nBlockAlign = wfx.nChannels * (wfx.wBitsPerSample / 8);
    wfx.nAvgBytesPerSec = wfx.nSamplesPerSec * wfx.nBlockAlign;
    wfx.cbSize = 0;

    MMRESULT mmerr = waveOutOpen(&hWaveOut, WAVE_MAPPER, &wfx, (DWORD_PTR)waveOutProc, 0, CALLBACK_FUNCTION);
    if (mmerr != MMSYSERR_NOERROR) {
        return FALSE;
    }

    for (int i = 0; i < SOUND_N_BUFFERS; i++) {
        waveHeaders[i].lpData = (LPSTR)audioBuffers[i];
        waveHeaders[i].dwBufferLength = sizeof(audioBuffers[i]);
        waveHeaders[i].dwFlags = 0;
        waveHeaders[i].dwLoops = 0;

        waveOutPrepareHeader(hWaveOut, &waveHeaders[i], sizeof(WAVEHDR));
        waveOutWrite(hWaveOut, &waveHeaders[i], sizeof(WAVEHDR));
    }

    return TRUE;
}

void sound_deinit(void){
    waveOutReset(hWaveOut);
    for (int i = 0; i < SOUND_CHANNELS; i++) {
        waveOutUnprepareHeader(hWaveOut, &waveHeaders[i], sizeof(WAVEHDR));
    }
    waveOutClose(hWaveOut);
}

void sound_on(void) {
    waveOutSetVolume(hWaveOut, SOUND_VOLUME_MAX);
}

void sound_off(void){
    waveOutSetVolume(hWaveOut, SOUND_VOLUME_MIN);
}

void adlib_callback(uint16_t ax){
    uint8_t reg = ax >> 8;
    uint8_t val = ax & 0xFF;

    OPL3_WriteReg(&chip, reg, val);
}
