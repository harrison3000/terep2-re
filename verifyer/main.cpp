#include <cstdlib>
#include <cstdio>
#include <string_view>
#include <unistd.h>

#include "../insulator/insulator.hpp"

#define W 320
#define H 200





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
        std::string_view linha(l);

        if(linha.starts_with("init")){
            printf("Init!\n");
            continue;
        }
        if(linha.starts_with("frame_fnv")){
            auto fb = (uint8_t*)get_raw_fb(g);
            uint64_t fnv = 0xcbf29ce484222325ULL;

            for(uint16_t i = 0; i < 64000;i++){
                uint8_t c = fb[i];
                fnv ^= c;
                fnv *= 0x100000001b3ULL;
            }

            uint64_t hash;
            sscanf(l, "frame_fnv1a_64: %lx", &hash);

            if(hash == fnv){
                hashok++;
            }else{
                printf("hash mismatch in line %d\n",ln-1);
            }

            continue;
        }
        if(linha == "\r\n"){
            continue;
        }
        if(linha.starts_with("frame:")){
            continue;
        }

        printf("unhandled line:%s\n", l);
        exit(2);
    }

    printf("%d hashes ok\n",hashok);

}

