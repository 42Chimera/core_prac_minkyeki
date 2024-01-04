
# -----------------------------------------------------
# (1) Detect OS 
if(MSVC OR MSYS OR MINGW)
    # for Windows
    set(SKIA_OS_WINDOWS)
elseif(APPLE)
    # for MacOS X or iOS, watchOS, tvOS (since 3.10.3)
    set(SKIA_OS_APPLE)
elseif(UNIX AND NOT APPLE)
    # for Linux, BSD, Solaris, Minix
    set(SKIA_OS_LINUX)
else()
    cm_printf(FATAL "Which OS are you using? this is fatal error.")
endif()

# (2) Detect Architecture
if(CMAKE_SIZEOF_VOID_P EQUAL 8) # 64 bit
    set(SKIA_ARC_64)
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4) # 32 bit
    set(SKIA_ARC_32)
else()
    cm_printf(FATAL "Which Architecture are you using? this is fatal error.")
endif()

# (+) 
if(DEFINED SKIA_OS_APPLE AND CMAKE_APPLE_SILICON_PROCESSOR STREQUAL "arm64")
    set(SKIA_OS_APPLE_ARM)
endif()

# (3) Set Prebuilt version
if(DEFINED SKIA_OS_WINDOWS AND DEFINED SKIA_ARC_64)
    set(SKIA_FILE windows-Debug-x64.zip)
elseif(DEFINED SKIA_OS_LINUX AND DEFINED SKIA_ARC_64)
    set(SKIA_FILE linux-Debug-x64.zip)
elseif(DEFINED SKIA_OS_APPLE AND DEFINED SKIA_ARC_64)
    if(DEFINED SKIA_OS_APPLE_ARM)
        set(SKIA_FILE macos-Debug-arm64.zip)
    elseif()
        set(SKIA_FILE macos-Debug-x64.zip)
    endif()
else()
    cm_printf(FATAL "x32 currently not supported")
endif()








# https://github.com/HumbleUI/SkiaBuild/releases
set(SKIA_PREBUILT_PATH           ${CMAKE_CURRENT_LIST_DIR}/bin)
set(SKIA_PREBUILT_REPO_URL       https://github.com/HumbleUI/SkiaBuild/releases/download/m116-d2c211228d-${SKIA_FILE})


# -----------------------------------------------------
# (2) Download Skia prebuilt library
set(SKIA_PATH ${CMAKE_CURRENT_LIST_DIR}/bin)

file(DOWNLOAD ${LIBHELLO_URL} ${LIBHELLO_PATH} STATUS LIBHELLO_DOWNLOAD_STATUS)
list(GET LIBHELLO_DOWNLOAD_STATUS 0 LIBHELLO_DOWNLOAD_STATUS_NO)

if(LIBHELLO_DOWNLOAD_STATUS_NO)
    message(STATUS "Pre-built library not downloaded. Building from source. (${LIBHELLO_DOWNLOAD_STATUS})")
    file(REMOVE ${LIBHELLO_PATH})
else()
    message(STATUS "Linking downloaded pre-built library.")
endif()

if(EXISTS ${LIBHELLO_PATH})
    add_library(hello STATIC IMPORTED)
    set_target_properties(hello PROPERTIES
            IMPORTED_LOCATION ${LIBHELLO_PATH}
            INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_SOURCE_DIR}/include/libhello
            )
else()
    add_library(hello src/libhello/hello.cpp)
    target_include_directories(hello PUBLIC include/libhello)
endif()