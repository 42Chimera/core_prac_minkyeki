# Print current cmake list location (for debug purpose)
cm_printf_cmake_list_location()

# 라이브러리 빌드에 필요한 소스
set(SRC
    source/test_function/test_.cpp
    source/assert/libcm_assert.h
)

# 라이브러리 빌드 Flag에 기입할 include path : #include " 경로/* "
set(INC
    source/assert
    source/noncopyable
    source/sal
)

# 라이브러리 빌드 Flag에 기입할 include path : #include < 경로/* >
set(INC_SYS
)

# 라이브러리 빌드에 필요한 타 라이브러리
set(LIB
)

cm_add_library(cm_intern_libcm "${SRC}" "${INC}" "${INC_SYS}" "${LIB}")