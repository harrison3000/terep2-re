#pragma once

struct GameSession;

void new_session(GameSession **d);
bool init_game(GameSession *, const char*);