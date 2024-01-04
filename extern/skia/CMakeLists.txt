cm_printf(STATUS " Current CmakeLists.txt location : ${CMAKE_CURRENT_LIST_DIR} ")

# -----------------------------------------------------
# (1) Detect OS 
if(MSVC OR MSYS OR MINGW)
    # for Windows
    set(SKIA_OS "windows")
elseif(APPLE)
    # for MacOS X or iOS
    set(SKIA_OS "macos")
elseif(UNIX AND NOT APPLE)
    # for Linux, BSD, Solaris, Minix
    set(SKIA_OS "linux")
else()
    cm_printf(FATAL "Which OS are you using? this is fatal error.")
endif()

# (2) Detect Architecture
if(CMAKE_SIZEOF_VOID_P EQUAL 8) # 64 bit
    if(SKIA_OS STREQUAL "macos" AND CMAKE_APPLE_SILICON_PROCESSOR STREQUAL "arm64")
        set(SKIA_CPU arm64)
    else()
        set(SKIA_CPU x64)
    endif()
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4) # 32 bit
    set(SKIA_CPU x86)
else()
    cm_printf(FATAL "Which Architecture are you using? this is fatal error.")
endif()


# ----------------------------------------------------------------------
# Download Skia prebuilt library
#     - https://github.com/HumbleUI/SkiaBuild/releases
set(SKIA_BUILD_TYPE              ${CMAKE_BUILD_TYPE}) 
set(SKIA_PREBUILT_TAG            m116-d2c211228d)
set(SKIA_FILE                    "${SKIA_OS}-${SKIA_BUILD_TYPE}-${SKIA_CPU}.zip")
set(SKIA_PREBUILT_ZIP_PATH       "${CMAKE_CURRENT_LIST_DIR}/${SKIA_FILE}")
set(SKIA_PREBUILT_REPO_URL       https://github.com/HumbleUI/SkiaBuild/releases/download/${SKIA_PREBUILT_TAG}/Skia-${SKIA_PREBUILT_TAG}-${SKIA_FILE})
 

if(NOT EXISTS ${SKIA_PREBUILT_ZIP_PATH})
    file(DOWNLOAD ${SKIA_PREBUILT_REPO_URL} ${SKIA_PREBUILT_ZIP_PATH} STATUS SKIA_DOWNLOAD_STATUS)
    list(GET SKIA_DOWNLOAD_STATUS 0 SKIA_DOWNLOAD_STATUS_NO)

    if(SKIA_DOWNLOAD_STATUS_NO)
        cm_printf(STATUS " == Pre-built library not downloaded. Building from source. (${SKIA_DOWNLOAD_STATUS})")
        file(REMOVE ${SKIA_PREBUILT_ZIP_PATH})
    else()
        cm_printf(STATUS " == Pre-built library download complete.")
        execute_process(
          COMMAND ${CMAKE_COMMAND} -E tar -xvf ${SKIA_PREBUILT_ZIP_PATH} 
          WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        )
        # file(REMOVE ${SKIA_PREBUILT_ZIP_PATH})
    endif()
endif()

file(GLOB_RECURSE SKIA_LIB_FILES CONFIGURE_DEPENDS "*.a"
)
# cm_printf(STATUS "${SKIA_LIB_FILES}")







# set(SRC)
# # 라이브러리 빌드에 필요한 소스 (.a)
# file(GLOB_RECURSE SRC CONFIGURE_DEPENDS
#     "*.a"
# )

# # 라이브러리 빌드 Flag에 기입할 include path : #include " 경로/* "
# set(INC
#     ${CMAKE_CURRENT_LIST_DIR}/include
# )

# # 라이브러리 빌드 Flag에 기입할 include path : #include < 경로/* >
# set(INC_SYS
# )

# # 라이브러리 빌드에 필요한 타 라이브러리
# set(LIB
# )

# # 모든 설정들 모아서 라이브러리 생성.
# cm_add_library(cm_extern_skia "${SRC}" "${INC}" "${INC_SYS}" "${LIB}")