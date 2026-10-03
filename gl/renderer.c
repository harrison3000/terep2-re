#include <stdint.h>
#include <stdio.h>
#include <windows.h>
#include "renderizeitor_plugin.h"


static RzPlugin p;
static RzContext* ctx;

struct carrodef_s{
    int32_t id;
    int16_t n_points;
    uint16_t points_loc2;
};

struct carrodef_s carros[5];

extern volatile uintptr_t all_segments[];
extern char track_path[];

static void loadCars();
static void updateCarVerts(int);

//TODO error checking

void doTheGLThing(HWND hwnd){
    static int inited = 0;
    if(!inited){
        int ok = rzPluginLoad(&p, "renderizeitor.dll");
        if(ok != RZ_PLUGIN_OK){
            return;
        }
        inited = 1;
        p.rzCreateWindow(hwnd, 0, 0, 1280, 720, &ctx);

        p.rzSetHeightmap(ctx, (uint8_t*)all_segments[1], 256,256 );

        char full_path[MAX_PATH];
        snprintf(full_path, MAX_PATH, "%s\\%s",track_path, "maptex.pcx");

        p.rzLoadTileAtlas(ctx, full_path);
        p.rzSetTileMap(ctx, (uint8_t*)all_segments[2], 256,256);

        loadCars();

        p.rzSetCameraTarget(ctx, carros[0].id, 1);//TODO actual id
    }

    for(int i=0;i<5;i++){
        int id = carros[i].id;
        if(id != -1){
            updateCarVerts(i);
        }
    }
    

    p.rzRender(ctx);
}

#define U_CAST(type, addr)({ \
    uintptr_t finalAddr = all_segments[0] + (addr); \
    (type *)finalAddr;       \
})

static void loadCars(){
    __auto_type ncars = U_CAST(uint16_t, 0x5bba)[0];

    __auto_type car_offs = U_CAST(uint16_t, 0x5bbc);

    for(int i=0;i<5;i++){
        carros[i].id = -1;
        if(i >= ncars){
            continue;
        }

        __auto_type c_offset = car_offs[i];

        //p.rzCreateObject(ctx)

        //see: https://github.com/Zi9/Deformerz/blob/master/docs/TEREP2_DAT_car_model_format.md
        __auto_type pointsloc = U_CAST(uint16_t, c_offset)[0] + c_offset;
        carros[i].n_points = U_CAST(uint16_t, pointsloc)[0];
        carros[i].points_loc2 = pointsloc + 2;

        p.rzCreateObject(ctx, carros[i].n_points, &carros[i].id);

        //variable length definitions chunk
        __auto_type vldc_loc = U_CAST(uint16_t, c_offset)[2];

        int error = 99;
        uint16_t vldc_off = vldc_loc + c_offset;
        while(vldc_off < 60000){
            __auto_type kind = U_CAST(uint8_t, vldc_off)[0];
            vldc_off++;
            
            if(kind == 1){ //camera
                vldc_off += 4;
                continue;
            }
            if(kind == 3){ //unknown
                vldc_off += 12;
                continue;
            }
            if(kind == 10){ //wheel
                vldc_off += 186;
                continue;
            }
            if(kind == 4){ //colored polygon
                int n = U_CAST(uint8_t, vldc_off)[0];
                n++; //the extra vertex
                vldc_off++;

                uint16_t idxs[99];

                for(int i =0; i < n;i++){
                    int v = U_CAST(uint16_t, vldc_off)[0];
                    vldc_off += 2;
                    v >>= 1; //TODO interpret the flag!
                    idxs[i] = v;
                }
                vldc_off += 2; //we just skip the palette for now

                p.rzAddObjectPolygon(ctx, carros[i].id, idxs, n);

                continue;
            }
            if(kind == 8){ //textured polygon
                int n = U_CAST(uint8_t, vldc_off)[0];
                n++; //the extra vertex
                vldc_off++;

                uint16_t idxs[99];

                for(int i =0; i < n;i++){
                    int v = U_CAST(uint16_t, vldc_off)[0];
                    v >>= 1; //TODO interpret the flag!
                    //TODO get the uv coords
                    vldc_off+= 6;
                    idxs[i] = v;
                }

                p.rzAddObjectPolygon(ctx, carros[i].id, idxs, n);

                continue;
            }
            if(kind == 0){
                break;
            }

            printf("Unknown kind: %x, at %x, car %d\n", kind, vldc_off, i);
            break;
        }
    }
}

static void updateCarVerts(int i){
    int n = carros[i].n_points;
    int pl2 = carros[i].points_loc2;

    uint32_t ptrs[512];

    for(int i =0; i<n;i++){
        __auto_type pdef = U_CAST(uint32_t, pl2);
        ptrs[i*3 + 0] = pdef[0];
        ptrs[i*3 + 1] = pdef[1];
        ptrs[i*3 + 2] = pdef[2];

        pl2+= 28;
    }

    p.rzUpdateObjectVertices(ctx, carros[i].id, ptrs);
}