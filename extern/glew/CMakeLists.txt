cm_printf(STATUS " Current CmakeLists.txt location : ${CMAKE_CURRENT_LIST_DIR} ")

# ----------------------------------------------------------------------------
# downdload and build
set(LIB_DOWNLOAD_DIR  ${CMAKE_CURRENT_LIST_DIR}/source) 
if(NOT EXISTS ${LIB_DOWNLOAD_DIR})
    execute_process(
        COMMAND bash ${CMAKE_CURRENT_LIST_DIR}/get_source_and_build.sh
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR} # where CMakeLists.txt is located
    )
endif()