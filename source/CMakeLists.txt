# Print current cmake list location (for debug purpose)
cm_printf_cmake_list_location()

# 아래는 작동하지 않는다. 왜일까...
# find_library(
#   TEST
#   NAMES cm_intern_libcm
#   HINTS ${CMAKE_BINARY_DIR}/lib
#   REQUIRED)
# cm_printf(FATAL "TEST : ${TEST}")

# Source to compile
set(SRC
  main.cpp
)


# Directories for header include
set(INC
  ${CMAKE_SOURCE_DIR}/intern/libcm
)

# ?
set(INC_SYS
)

# Libraries to link
set(LIB
  cm_intern_libcm
)

# Set source to target
add_executable( ${NAME} ${SRC} )

# Set include directories to target
target_include_directories( ${NAME} PUBLIC ${INC} )
# Set libraries to link to target
target_link_libraries( ${NAME} PRIVATE ${LIB} )
