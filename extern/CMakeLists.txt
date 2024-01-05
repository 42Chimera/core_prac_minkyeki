cm_printf(STATUS " Current CmakeLists.txt location : ${CMAKE_CURRENT_LIST_DIR} ")

# Extern은 외부 라이브러리로, Cmake 모듈 구조로 작성되있지 않기 때문에
# extern에 한해 부모 CmakeLists.txt에서 모두 관리하도록 하였습니다....

# (1) 라이브러리 빌드 진행
# (2) 헤더 인클루드 경로 연결
# (3) 라이브러리 바이너리 링크 설정
# -------------------------------------------------------------------------------

add_subdirectory(glew)
add_subdirectory(glfw)
add_subdirectory(imgui)
add_subdirectory(spdlog)
add_subdirectory(glm)

# add_subdirectory(skia)
# add_subdirectory(stb_image)
# add_subdirectory(assimp)

