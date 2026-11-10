# Building instructions for terep2-re

## Windows 32 bit

+ Download and install [MSYS2](https://www.msys2.org/).

+ Open `MSYS2 MINGW32`.

+ Install the required tools:
```bash
pacman -S --needed \
  mingw-w64-i686-toolchain \
  mingw-w64-i686-binutils \
  base-devel \
  git
```

+ Fix path:
```bash
cd /mingw32/bin
ln -sf windres.exe i686-w64-mingw32-windres.exe
ln -sf strip.exe i686-w64-mingw32-strip.exe
cd
```

+ Clone the repository:
```bash
git clone --depth=1 https://github.com/harrison3000/terep2-re.git
cd terep2-re
git submodule update --init --recursive
```

+ Compile the project:
```bash
./build_windows.sh
```

The compiled executable (`terep2re32.exe`) will be in *build/*.

> NOTE: You will see errors about `x86_64-w64-mingw32-gcc`, ignore them.

## Windows 64 bit

+ Download and install [MSYS2](https://www.msys2.org/).

+ Open `MSYS2 MINGW64`.

+ Install the required tools:
```bash
pacman -S --needed \
  mingw-w64-x86_64-toolchain \
  mingw-w64-x86_64-binutils \
  base-devel \
  git
```

+ Fix path:
```bash
cd /mingw64/bin
ln -sf windres.exe x86_64-w64-mingw32-windres.exe
ln -sf strip.exe x86_64-w64-mingw32-strip.exe
cd
```

+ Clone the repository:
```bash
git clone --depth=1 https://github.com/harrison3000/terep2-re.git
cd terep2-re
git submodule update --init --recursive
```

+ Compile the project:
```bash
./build_windows.sh
```

The compiled executable (`terep2re64.exe`) will be in *build/*.

> NOTE: You will see errors about `i686-w64-mingw32-gcc`, ignore them.
