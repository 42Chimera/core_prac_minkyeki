

# 일단 블렌더는 모듈마다 모두 cmake을 정의해주었다.
# 모듈을 어떤 식으로 정리할 것인가? 블렌더를 참고해 보니
# 장점: 모듈 디렉토리가 바뀌어도 인클루드 알아서 잘 되고, cmake 경로 수정할 필요가 없다.
# https://github.com/blender/blender/blob/9c0bffcc89f174f160805de042b00ae7c201c40b/intern/atomic/CMakeLists.txt

set(INC
  INTERFACE . # INTERFACE, PUBLIC, PRIVATE 을 이해해야할듯...
)

set(SRC
    UTIL_assert.h # 유저에게 노출시킬 헤더.
    # intern/assert_internal.h      # 그 외 구현에 필요한 추가 헤더...
    # ...
)

set(LIB
)

add_library(cm_intern_assert INTERFACE)
add_library(CM::intern::assert ALIAS cm_intern_assert)

target_include_directories(cm_intern_assert INTERFACE ${INC})
target_sources(cm_intern_assert PRIVATE ${SRC})
