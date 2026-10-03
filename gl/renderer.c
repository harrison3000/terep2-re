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

#define U_CAST(type, addr)({ \
    uintptr_t finalAddr = all_segments[0] + (addr); \
    (type const*)finalAddr;       \
})

//TODO error checking

void doTheGLThing(HWND hwnd){
    static int inited = 0;
    char full_path[MAX_PATH];

    if(!inited){
        int ok = rzPluginLoad(&p, "renderizeitor.dll");
        if(ok != RZ_PLUGIN_OK){
            return;
        }
        inited = 1;
        p.rzCreateWindow(hwnd, 0, 0, 1280, 720, &ctx);

        p.rzSetHeightmap(ctx, (uint8_t*)all_segments[1], 256,256 );

        snprintf(full_path, MAX_PATH, "%s\\maptex.pcx",track_path);

        p.rzLoadTileAtlas(ctx, full_path);
        p.rzSetTileMap(ctx, (uint8_t*)all_segments[2], 256,256);

        snprintf(full_path, MAX_PATH, "%s\\textures.pcx",track_path);
        p.rzLoadFallbackTexture(ctx,full_path);

        loadCars();

        p.rzSetCameraTarget(ctx, carros[0].id, 1);//TODO actual id
        
        for(int i=0;i<5;i++){
            int id = carros[i].id;
            if(id == -1) continue;
            snprintf(full_path, MAX_PATH, "%s\\car%d.pcx", track_path, i+1);
            p.rzLoadObjectTexture(ctx, id, full_path);
        }

        __auto_type bgc = U_CAST(uint8_t, 0x1a4d + 3*255);
        p.rzSetBackgroundColor(ctx, bgc[0], bgc[1],bgc[2]);
    }

    for(int i=0;i<5;i++){
        int id = carros[i].id;
        if(id != -1){
            updateCarVerts(i);
        }
    }
    

    p.rzRender(ctx);
}


static void loadCars(){
    __auto_type ncars = U_CAST(uint16_t, 0x5bba)[0];

    __auto_type car_offs = U_CAST(uint16_t, 0x5bbc);

    for(int i=0;i<5;i++){
        carros[i].id = -1;
        if(i >= ncars){
            continue;
        }

        __auto_type car_offset = car_offs[i];
        __auto_type next_car_offset = car_offs[i+1];

        __auto_type chunks_offsets = U_CAST(uint16_t, car_offset);

        //see: https://github.com/Zi9/Deformerz/blob/master/docs/TEREP2_DAT_car_model_format.md
        __auto_type pointsloc = chunks_offsets[0] + car_offset;
        carros[i].n_points = U_CAST(uint16_t, pointsloc)[0];
        carros[i].points_loc2 = pointsloc + 2;

        p.rzCreateObject(ctx, carros[i].n_points, &carros[i].id);

        //variable length definitions chunk
        __auto_type vldc_loc = chunks_offsets[2];

        int error = 99;
        uint16_t vldc_off = vldc_loc + car_offset;
        while(vldc_off < next_car_offset){
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

                uint16_t idxs[20];
                int flag = 0;

                for(int i =0; i < n;i++){
                    int v = U_CAST(uint16_t, vldc_off)[0];
                    flag |= v & 1;
                    idxs[i] = v >> 1;
                    vldc_off += 2;
                }
                int p1 = U_CAST(uint8_t, vldc_off)[0];
                int p2 = U_CAST(uint8_t, vldc_off)[1];
                vldc_off += 2;

                if(flag){
                    //shadow polygon, we dont need that
                    continue;
                }

                if(p1 == 240){
                    //TODO see if there is a single tone or various
                    p.rzAddObjectTranslucentPolygon(ctx, carros[i].id, idxs, n, 8);
                }else{
                    p.rzAddObjectPolygon(ctx, carros[i].id, idxs, n, p1);
                }

                continue;
            }
            if(kind == 8){ //textured polygon
                int n = U_CAST(uint8_t, vldc_off)[0];
                n++; //the extra vertex
                vldc_off++;

                uint16_t idxs[20];
                float uvs[30];

                for(int i =0; i < n;i++){
                    __auto_type parr = U_CAST(uint16_t, vldc_off);
                    int v = parr[0];
                    uvs[i*2 + 0] = (float)parr[1] / 65535.0f;
                    uvs[i*2 + 1] = (float)parr[2] / 65535.0f;

                    idxs[i] = v >> 1;
                    vldc_off+= 6;
                }
                
                p.rzAddObjectTexturedPolygon(ctx, carros[i].id, idxs, uvs, n);

                continue;
            }
            if(kind == 0){
                continue;
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