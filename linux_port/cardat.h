#pragma once

class tipos {
    public:
    static const int NULLENTRY = 0;
    static const int CAMERA = 1;
    static const int UNKNOWN = 3;
    static const int COLORED = 4;
    static const int TEXTURED = 8;
    static const int WHEEL = 10;
};

class tipos_skip {
    public:
    static const int CAMERA = 4;
    static const int UNKNOWN = 12;
    static const int WHEEL = 186;
};

struct textured {
    uint16_t p_index;
    uint16_t uv_x, uv_y;
};

struct pointdef {
    uint32_t coord[3];
    uint32_t unk[3];
    uint16_t size;
    uint16_t designator;
};