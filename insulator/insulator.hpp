#pragma once

#include <cstdint>

struct GameSession;

void new_session(GameSession **d);
bool init_game(GameSession *, const char*);
void finalize_game(GameSession *g);
void send_key_event(GameSession *g, uint8_t);
void calculate_physics(GameSession *g);
void render_frame(GameSession *g);


//these will be deleted ASAP!
uintptr_t get_memory(GameSession *g, uintptr_t offset);
uintptr_t get_segment(GameSession *g, uintptr_t seletor);