cm_printf(STATUS " Current CmakeLists.txt location : ${CMAKE_CURRENT_LIST_DIR} ")

add_subdirectory(glew)
add_subdirectory(glfw)

add_subdirectory(imgui)
add_subdirectory(spdlog)
add_subdirectory(assimp)
add_subdirectory(glm)

# add_subdirectory(skia)
# add_subdirectory(stb_image)

