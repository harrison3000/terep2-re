#pragma once

class tipos {
    public:
    static const int NULLENTRY = 0;
    static const int CAMERA = 1;
    static const int UNKNOWN = 3;
    static const int COLORED = 4;
    static const int TEXTURED = 8;
    static const int WHEEL = 10;

    static const int CAMERA_SKIP = 4;
    static const int UNKNOWN_SKIP = 12;
    static const int WHEEL_SKIP = 186;
};

struct textured {
    uint16_t p_index;
    uint16_t uv_x, uv_y;
};

struct pointdef {
    uint32_t x,y,z;
    uint32_t unk[3];
    uint16_t size;
    uint16_t designator;
};