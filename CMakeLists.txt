# -----------------------------------------------------------------------------
# Early Initialization
cmake_minimum_required(VERSION 3.24)

# Avoid having an empty `CMAKE_BUILD_TYPE`.
# CMAKE_BUILD_TYPE= Release | Debug | etc...
if(NOT DEFINED CMAKE_BUILD_TYPE_INIT)
  set(CMAKE_BUILD_TYPE_INIT "Release")
  # Internal logic caches this variable, avoid showing it by default
  # since it's easy to accidentally set instead of the build type.
  mark_as_advanced(CMAKE_BUILD_TYPE_INIT)
endif()

# Disbale CMAKE DEPRECATION WARNING
set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE) 

# -----------------------------------------------------------------------------
# Load Chimera's Local cmake util functions
include(build_util/cmake/macros.cmake)

# -----------------------------------------------------------------------------
# Initialize Project
set( NAME chimera )                         # Executable name
set( CMAKE_CXX_STANDARD 20 )                # Cpp compiler version
set( CMAKE_CXX_STANDARD_REQUIRED True )

project( ${NAME} VERSION 0.1.0 LANGUAGES C CXX )

# -------------------------------------------------------------------------------
# Global Defines
add_definitions(-DPROJECT_ROOT_DIR="${CMAKE_SOURCE_DIR}") # 임시 방편입니다!
add_definitions(-DCM_DEBUG) # 임시 방편입니다!

# Print compile flags for cmake debug purpose. maybe removed later.
# cm_printf(NOTE "Using CFLAGS: ${CMAKE_C_FLAGS}")
# cm_printf(NOTE "Using CXXFLAGS: ${CMAKE_CXX_FLAGS}")

# -----------------------------------------------------------------------------
# Add Sub-Directories
cm_printf(STATUS " Current CmakeLists.txt location : ${CMAKE_CURRENT_LIST_DIR} ")
add_subdirectory(intern)
# add_subdirectory(extern) # --> extern은 좀 다르게 처리해야 함!

add_subdirectory(source)

# ----------------------------------------------------------------------------
# Add Custom makefile rule (ex make fclean, re)
ADD_CUSTOM_TARGET( re
        COMMENT "Re-building..."
        COMMAND make fclean && make all
        # ...
        )

ADD_CUSTOM_TARGET( fclean
        COMMENT "Cleaning executable and binaries..."
        COMMAND make clean
        )