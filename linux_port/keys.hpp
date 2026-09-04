
int8_t get_pc_scancode(const SDL_Event& event) {
    bool is_release = (event.type == SDL_EVENT_KEY_UP);
    uint8_t make_code = 0;

    switch (event.key.key) {
        case SDLK_F1:  make_code = 0x3B; break;
        case SDLK_F2:  make_code = 0x3C; break;
        case SDLK_F3:  make_code = 0x3D; break;
        case SDLK_F4:  make_code = 0x3E; break;
        case SDLK_F5:  make_code = 0x3F; break;
        case SDLK_F6:  make_code = 0x40; break;
        case SDLK_F7:  make_code = 0x41; break;
        case SDLK_F8:  make_code = 0x42; break;
        case SDLK_F9:  make_code = 0x43; break;
        case SDLK_F10: make_code = 0x44; break;
        case SDLK_F11: make_code = 0x57; break;
        case SDLK_F12: make_code = 0x58; break;

        case SDLK_TAB: make_code = 0x0F; break;
        case SDLK_Q:   make_code = 0x10; break;
        case SDLK_W:   make_code = 0x11; break;
        case SDLK_A:   make_code = 0x1E; break;
        case SDLK_D:   make_code = 0x20; break;

        case SDLK_UP:    make_code = 0x48; break;
        case SDLK_DOWN:  make_code = 0x50; break;
        case SDLK_LEFT:  make_code = 0x4B; break;
        case SDLK_RIGHT: make_code = 0x4D; break;

        default: return 0x00;
    }

    uint8_t final_code = is_release ? (make_code | 0x80) : make_code;
    return final_code;
}