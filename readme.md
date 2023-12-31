### Cmake command
```bash
cmake -B build --> defaults to Debug build.
cmake -DCMAKE_BUILD_TYPE=Debug
cmake -DCMAKE_BUILD_TYPE=Release
```

### Full commmand for Debug build + execute program
```bash
rm -rf build && cmake -DCMAKE_BUILD_TYPE=Debug -B build && make -C build -j4 && ./build/chimera
```

### TODO
0. SHARED LIB 링크하는 걸로 했지만, makefile 보니 링크하는게 없네...? 이거 동적 라이브러리 링킹이 아닌가?
0. UTIL_assert.h 인클루드 안되는 이유 찾아내서 고치기. 
 --> 1. PRIVATE, INTERFACE, PUBLIC 이해하기
1. 각 모듈들 인클루드 규칙 정하기 + prefix 이름 규칙. -> 헤더 인클루드시 
2. CM_DEBUG 같은 매크로 빌드 모드에 따라 다르게 해주기.

### Header Predix Rule (추후 추가 예정)
ITERN_* : chimera internal library. ex. "INTERN_libcm.h"