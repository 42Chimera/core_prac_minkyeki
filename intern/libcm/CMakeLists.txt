# Print current cmake list location (for debug purpose)
cm_printf_cmake_list_location()

# 라이브러리 빌드에 필요한 소스
set(SRC
    source/test_function/test_.cpp
)

# 라이브러리 빌드 Flag에 기입할 include path : #include " 경로/* "
set(INC
    ${CMAKE_CURRENT_LIST_DIR}/source/assert
    ${CMAKE_CURRENT_LIST_DIR}/source/noncopyable
    ${CMAKE_CURRENT_LIST_DIR}/source/sal
    ${CMAKE_CURRENT_LIST_DIR}/source/test_function
)

# 라이브러리 빌드 Flag에 기입할 include path : #include < 경로/* >
set(INC_SYS
)

# 라이브러리 빌드에 필요한 타 라이브러리
set(LIB
)

# 모든 설정들 모아서 라이브러리 생성.
cm_add_library(cm_intern_libcm "${SRC}" "${INC}" "${INC_SYS}" "${LIB}")