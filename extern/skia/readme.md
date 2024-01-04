Skia : Chimera's GUI rendering engine
---
Cmake Configure 될때 빌드파일을 자동으로 다운로드 받습니다.
#### 직접 빌드하는건 너무 오래 걸려서...

### use prebuilt binaries. (static lib)
- https://github.com/JetBrains/skia-build/releases
- https://github.com/HumbleUI/SkiaBuild/releases

### cmake + skia
build_util/cmake/git.cmake 이용해서 cmake 실행될 때 git_clone() 실행하기.
```CMake
target_link_libraries(${TARGET} PRIVATE
  "${BOOST_PATH}/libboost_filesystem.a"
  "${BOOST_PATH}/libboost_system.a"
  "${BOOST_PATH}/libboost_chrono.a"
  # ...
)
```


