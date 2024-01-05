# Print current cmake list location (for debug purpose)
cm_printf_cmake_list_location()

# Source -------------------------------------------------------------
# Source to compile
set(SRC
        Main/main.cpp
)

# Directories for header include -------------------------------------
set(INC
  ${CMAKE_SOURCE_DIR}/extern/skia/source/skia
  ${CMAKE_SOURCE_DIR}/extern/spdlog/source/include
  ${CMAKE_SOURCE_DIR}/intern/libcm 
)

# 
set(INC_SYS
)

# Internal Libraries to link -----------------------------------------
set(LIB
  cm_intern_libcm # intern/libcm
)

# Set source to target
add_executable( ${NAME} ${SRC} )
# Set include directories to target
target_include_directories( ${NAME} PUBLIC ${INC} )
# Set libraries to link to target
target_link_libraries( ${NAME} PRIVATE ${LIB} )


# External Libraries to link -----------------------------------------

# link vulkan
# find_package(Vulkan REQUIRED)

# link openGL
find_package( OpenGL REQUIRED ) # stops processing with an error message if the package cannot be found.
set( OpenGL_GL_PREFERENCE LEGACY )
target_link_libraries( ${NAME} PRIVATE OpenGL::GL )

# link spdlog
set(spdlog_DIR ${CMAKE_SOURCE_DIR}/extern/spdlog/source/build)
find_package( spdlog CONFIG REQUIRED )
target_link_libraries( ${NAME} PRIVATE spdlog::spdlog $<$<BOOL:${MINGW}>:ws2_32> )

# link glm
set( glm_DIR ${CMAKE_SOURCE_DIR}/extern/glm/source/cmake/glm ) # if necessary
find_package( glm CONFIG REQUIRED )
target_link_libraries( ${NAME} PRIVATE glm::glm )