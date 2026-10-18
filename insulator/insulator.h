#pragma once

#include "stdint.h"

#ifdef __cplusplus
    #define EXTC extern "C"
    struct GameSession;
#else
    #define EXTC 
    typedef struct GameSession GameSession;
#endif


EXTC void new_session(GameSession **d);
EXTC bool init_game(GameSession *, const char*);
EXTC void finalize_game(GameSession *g);
EXTC void send_key_event(GameSession *g, uint8_t);
EXTC void calculate_physics(GameSession *g);
EXTC void render_frame(GameSession *g);

EXTC int n_loaded_cars(GameSession *g);
EXTC void *get_raw_fb(GameSession *g);
EXTC uint8_t *get_palette(GameSession *g);