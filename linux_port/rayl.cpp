#include "raylib.h"
#include <fcntl.h>
#include <stddef.h>
#include <sys/mman.h>
#include <cstdint>
#include <unistd.h>
#include "cardat.h"
#include "common.h"


void* shared_mem = 0;

struct trints {
    int a,b,c;
    Color color;
};

struct carroMesh {
    Vector3 loc;
    Vector3 vertices[128];

    int npoints;
    pointdef *points;

    Model modelo;

    int ntris;
    trints *trs;
    

    bool error;

    void update_vertices();
    void load_car(void *cardata, size_t size);
};



//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
int main(void)
{
    int fdshm = shm_open("/terep2re-shm", O_RDONLY, 0);
    shared_mem = mmap(0, 1 * 1024*1024, PROT_READ, MAP_SHARED, fdshm, 0);


    // Initialization
    //--------------------------------------------------------------------------------------
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera free");

    // Define the camera to look into our 3d world
    Camera3D camera = { 0 };
    camera.position = (Vector3){ 10.0f, 10.0f, 10.0f }; // Camera position
    camera.target = (Vector3){ 0.0f, 0.0f, 0.0f };      // Camera looking at point
    camera.up = (Vector3){ 0.0f, 1.0f, 0.0f };          // Camera up vector (rotation towards target)
    camera.fovy = 45.0f;                                // Camera field-of-view Y
    camera.projection = CAMERA_PERSPECTIVE;             // Camera projection type

    carroMesh carro;
    carro.load_car(shared_mem, 4630); //all cars seem to be this size
    carro.update_vertices();


    DisableCursor();                    // Limit cursor to relative movement inside the window

    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())        // Detect window close button or ESC key
    {
        carro.update_vertices();

        // Update
        //----------------------------------------------------------------------------------
        UpdateCamera(&camera, CAMERA_FREE);

        if (IsKeyPressed(KEY_Z)) camera.target = (Vector3){ 0.0f, 0.0f, 0.0f };
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            BeginMode3D(camera);

                for(int i =0; i<carro.ntris;i++){
                    auto t = carro.trs[i];

                    DrawTriangle3D(carro.vertices[t.a], carro.vertices[t.b], carro.vertices[t.c], t.color);
                    DrawTriangle3D(carro.vertices[t.a], carro.vertices[t.c], carro.vertices[t.b], t.color);
                }

                DrawGrid(10, 1.0f);

            EndMode3D();

            DrawRectangle( 10, 10, 320, 93, Fade(SKYBLUE, 0.5f));
            DrawRectangleLines( 10, 10, 320, 93, BLUE);

            DrawText("Free camera default controls:", 20, 20, 10, BLACK);
            DrawText("- Mouse Wheel to Zoom in-out", 40, 40, 10, DARKGRAY);
            DrawText("- Mouse Wheel Pressed to Pan", 40, 60, 10, DARKGRAY);
            DrawText("- Z to zoom to (0, 0, 0)", 40, 80, 10, DARKGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}

//see: https://github.com/Zi9/Deformerz/blob/master/docs/TEREP2_DAT_car_model_format.md
void carroMesh::load_car(void *cardata, size_t size){
    auto base_mem = cardata; //so the macro works
    auto pointsloc = MEM_WORD(0);
    npoints = MEM_WORD(pointsloc);
    points = (pointdef*)&MEM_WORD(pointsloc + 2);
    
    ntris = 0;
    trs = new trints[1024];
    

    auto vldfs = MEM_WORD(4);
    while(vldfs < size){
        auto typ = MEM_BYTE(vldfs);
        vldfs++;
        
        if(typ == tipos::CAMERA){
            vldfs += tipos::CAMERA_SKIP;
            continue;
        }
        if(typ == tipos::UNKNOWN){
            vldfs += tipos::UNKNOWN_SKIP;
            continue;
        }
        if(typ == tipos::WHEEL){
            vldfs += tipos::WHEEL_SKIP;
            continue;
        }
        if(typ == tipos::COLORED){
            auto n = MEM_BYTE(vldfs);
            n++; //the extra vertex
            vldfs++;

            int idxs[99];

            for(int i =0; i < n;i++){
                int v = MEM_WORD(vldfs);
                vldfs += 2;
                v >>= 1; //TODO interpret the flag!
                idxs[i] = v;
            }
            vldfs += 2; //skip the palette for now

            for(int i = 0 ; i < n-2;i++){
                trs[ntris] = {idxs[i], idxs[i+1], idxs[i+2]};
                trs[ntris].color = GREEN;
                ntris++;
            }

            continue;
        }
        if(typ == tipos::TEXTURED){
            auto n = MEM_BYTE(vldfs);
            n++; //the extra vertex
            vldfs++;

            int idxs[99];

            auto def = (textured*)&MEM_BYTE(vldfs);
            for(int i =0; i < n;i++){
                int v = def[i].p_index;
                v >>= 1; //TODO interpret the flag!
                vldfs+= 6;
                idxs[i] = v;
            }

            for(int i = 0 ; i < n-2;i++){
                trs[ntris] = {idxs[i], idxs[i+1], idxs[i+2]};
                trs[ntris].color = BLUE;
                ntris++;
            }

            continue;
        }
        if(typ == tipos::NULLENTRY){
            error = 0;
            return;
        }

        //unrecognized type
        break;
    }

    error=1;
}

//see: https://github.com/Zi9/Deformerz/blob/master/docs/TEREP2_DAT_car_model_format.md
void carroMesh::update_vertices(){
    const float scale = 1.0f / 16777216.0f;

    auto p0 = points[0];
    for(int i = 0; i < npoints; i++){            
        auto p  = points[i];

        vertices[i].x = (float)((int32_t)(p.x - p0.x)) * scale;
        vertices[i].y = (float)((int32_t)(p.y - p0.y)) * scale;
        vertices[i].z = (float)((int32_t)(p.z - p0.z)) * scale;
    }

    loc.x = (float)p0.x * scale;
    loc.y = (float)p0.y * scale;
    loc.z = (float)p0.z * scale;
}
