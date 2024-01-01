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
    source/assert/libcm_assert.h
)

# 라이브러리 빌드 Flag에 기입할 include path : #include < 경로/* >
set(INC_SYS
)

# 라이브러리 빌드에 필요한 타 라이브러리
set(LIB
)

# cm_add_lib(cm_intern_libcm "${SRC}" "${INC}" "${INC_SYS}" "${LIB}")
add_library(cm_intern_libcm SHARED ${SRC})



# ============================================================
# ??
# add_custom_target( cm_intern_libcm.headers ${SRC} ${INC})

# ??
# ============================================================
# 헤더를 모아서 하나의 라이브러리 인클루드 헤더 생성하기...?

# 일단 헤더 온리 파일 하나만 생성하는 방법은 아래와 같다...
# Generate header.hpp from your template file header.hpp.in
# cm_printf(WARN " ============== >>> ${CMAKE_CURRENT_LIST_DIR}")

# configure_file(
#     ${CMAKE_CURRENT_LIST_DIR}/source/assert/libcm_assert.h # input
#     ${CMAKE_CURRENT_LIST_DIR}/INTERN_libcm.h # output
#     COPYONLY
# )

# execute_process(
#     COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/res" "${CMAKE_CURRENT_BINARY_DIR}/res"
#     )


# ============================================================
# https://stackoverflow.com/questions/60642137/generate-custom-header-file-with-cmake
# Read the entire CSV file.
# Split the CSV by new-lines.
# Loop through each line in the CSV file.
# ============================================================



# add include path to project
target_include_directories(cm_intern_libcm PUBLIC ${INC}) # 엥 PUBLIC으로 안하면 test_test.cpp 에서 include_directories가 적용이 안되네.
target_sources(cm_intern_libcm PUBLIC ${SRC})

# remove default library output file's prefix ( default prefix = "lib" )
set_target_properties(cm_intern_libcm PROPERTIES PREFIX "")

# ----------------------------------------------------------------------------
# Set CMAKE library output directory
# cm_printf(STATUS "-- cm_intern_lib : output path = ${CMAKE_BINARY_DIR}")
# set_target_properties( cm_intern_libcm
#   PROPERTIES
#   ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
#   LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
# )