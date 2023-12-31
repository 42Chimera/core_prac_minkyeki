# Print current cmake list location (for debug purpose)
cm_printf_cmake_list_location()

# https://github.com/blender/blender/blob/9c0bffcc89f174f160805de042b00ae7c201c40b/intern/atomic/CMakeLists.txt

# CMAKE으로 라이브러리 만드는 방법
# https://tttsss77.tistory.com/219

# 라이브러리 빌드 Flag에 기입할 include path : #include " 경로/* "
set(INC
    source/assert
    source/noncopyable
    source/sal
)

# 라이브러리 빌드에 필요한 소스
set(SRC
    source/test_function/test_.cpp
)

# 라이브러리 빌드 Flag에 기입할 include path : #include < 경로/* >
set(INC_SYS
)

# 라이브러리 빌드에 필요한 타 라이브러리
set(LIB
)

# cm_add_lib(cm_intern_libcm "${SRC}" "${INC}" "${INC_SYS}" "${LIB}")
add_library(cm_intern_libcm SHARED ${SRC})
add_library(cm::intern::libcm ALIAS cm_intern_libcm) # What is ALIAS ??

# add include path to project
target_include_directories(cm_intern_libcm PUBLIC ${INC}) # 엥 PUBLIC으로 안하면 test_test.cpp 에서 include_directories가 적용이 안되네.
target_sources(cm_intern_libcm PUBLIC ${SRC})

# remove default library output file's prefix ( default prefix = "lib" )
set_target_properties(cm_intern_libcm PROPERTIES PREFIX "")
