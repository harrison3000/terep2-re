#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "../insulator/insulator.h"



int main(int argc, char **argv){
    if(argc < 3){
        printf("I need your clothes, your boots and your motorcycle...\n");

        sleep(2);
        printf("nah, actually, I only need a track directory and a replay file\n");
        exit(1);
    }

    GameSession *g;

    new_session(&g);
    init_game(g, argv[1]);

    if(n_loaded_cars(g) <= 0){
        printf("didnt load any car");
        exit(1);
    }

    FILE *o = fopen(argv[2], "r");
    char l[1024];
    int ln = 0;
    int hashok = 0;
    int total = 0;
    float percent = 0;
    while(fgets(l, 1024, o)){
        ln++;
        if(l[0] == 0 || l[0] == '#'){
            //empty line or comment
            continue;
        }
        
        if(l[0] == 'P'){
            calculate_physics(g);
            continue;
        }
        if(l[0] == 'R'){
            render_frame(g);
            continue;
        }
        if(l[0] == 'K'){
            int k = 0;
            sscanf(l, "K: %i", &k);
            send_key_event(g, k);
            continue;
        }

        if(l[0] == 'i' && l[1] == 'n'){
            printf("Init!\n");
            continue;
        }
        uint64_t hash = 0;
        if(sscanf(l, "frame_fnv1a_64: %lx", &hash) == 1){
            auto fb = (uint8_t*)get_raw_fb(g);
            uint64_t fnv = 0xcbf29ce484222325ULL;

            for(uint16_t i = 0; i < 64000;i++){
                uint8_t c = fb[i];
                fnv ^= c;
                fnv *= 0x100000001b3ULL;
            }

            if(hash == fnv){
                hashok++;
            }
            total++;

            percent = (float)hashok/(float)total;
            percent *= 100.0f;

            printf("\r%d hashes (%.1f%%) match         ",hashok, percent);

            continue;
        }
        if(strcmp(l, "\r\n") == 0){
            continue;
        }
        if(l[0] == 'f' && l[5] == ':'){
            continue;
        }

        printf("unhandled line:%s\n", l);
        exit(2);
    }

    // some mismatches are to be expected specially when using the split screen,
    // we changed some things in renderer after all
    // however too many mismatches in the normal camera may mean that the physics
    // diverged, and that would be very bad

    char *ok = percent > 80.0f ? ":)" : ":(";

    printf("\n%s\n",ok);
}

