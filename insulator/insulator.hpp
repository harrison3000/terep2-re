#pragma once

#include <cstdint>

struct GameSession;

void new_session(GameSession **d);
bool init_game(GameSession *, const char*);
void finalize_game(GameSession *g);
void send_key_event(GameSession *g, uint8_t);
void calculate_physics(GameSession *g);
void render_frame(GameSession *g);

int n_loaded_cars(GameSession *g);
void *get_raw_fb(GameSession *g);