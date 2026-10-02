#include <windows.h>
#include "renderizeitor_plugin.h"


static RzPlugin p;
static RzContext* ctx;

extern volatile uintptr_t all_segments[];

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
        p.rzLoadTileAtlas(ctx, "D:\\Storm3000\\maptex.pcx");
        p.rzSetTileMap(ctx, (uint8_t*)all_segments[2], 256,256);
        
    }

    

    p.rzRender(ctx);
}
