# --------------------------------------------------------------------
# Created by Minkyeu Kim on 12/13/23.
#   - Cmake 안에서 사용할 헬퍼 함수들을 여기서 정의합니다.
#   - Reference : Blender cmake macro functions
#     - https://github.com/blender/blender/blob/9c0bffcc89f174f160805de042b00ae7c201c40b/build_files/cmake/macros.cmake#L415


# --------------------------------------------------------------------
# Colorized message function
#   - cm_printf(FATAL "foo")  --> 에러 메시지, 빨간색
#   - cm_printf(WARN "bar")   --> 경고성 메시지, 마젠타
#   - cm_printf(STATUS "baz")   --> 단순 로그 메시지, 초록색

if(NOT WIN32)
  string(ASCII 27 Esc)
  set(ColourReset "${Esc}[m")
  set(ColourBold  "${Esc}[1m")
  set(Red         "${Esc}[31m")
  set(Green       "${Esc}[32m")
  set(Yellow      "${Esc}[33m")
  set(Blue        "${Esc}[34m")
  set(Magenta     "${Esc}[35m")
  set(Cyan        "${Esc}[36m")
  set(White       "${Esc}[37m")
  set(BoldRed     "${Esc}[1;31m")
  set(BoldGreen   "${Esc}[1;32m")
  set(BoldYellow  "${Esc}[1;33m")
  set(BoldBlue    "${Esc}[1;34m")
  set(BoldMagenta "${Esc}[1;35m")
  set(BoldCyan    "${Esc}[1;36m")
  set(BoldWhite   "${Esc}[1;37m")
endif()

function(cm_printf)
  list(GET ARGV 0 MessageType)
  if(MessageType STREQUAL FATAL) # 심각한 CMAKE 에러
    list(REMOVE_AT ARGV 0)
    message("   ${BoldRed}${ARGV}${ColourReset}")
  elseif(MessageType STREQUAL WARN) # 경고성 메시지
    list(REMOVE_AT ARGV 0)
    message("   ${BoldYellow}${ARGV}${ColourReset}")
  elseif(MessageType STREQUAL STATUS) # 단순 정보 출력용 메시지
    list(REMOVE_AT ARGV 0)
    message("   ${BoldGreen}${ARGV}${ColourReset}")
  else()
    message("   ${ARGV}")
  endif()
endfunction()


# --------------------------------------------------------------------
# 
function(cm_printf_cmake_list_location)
  cm_printf(STATUS "Loading cmake lists... : ${CMAKE_CURRENT_LIST_DIR}")
endfunction()


# --------------------------------------------------------------------
# 
function(list_assert_duplicates
  list_id
  )
  # message(STATUS "list data: ${list_id}")
  list(REMOVE_ITEM list_id "PUBLIC" "PRIVATE" "INTERFACE")
  list(LENGTH list_id _len_before)
  list(REMOVE_DUPLICATES list_id)
  list(LENGTH list_id _len_after)
  # message(STATUS "list size ${_len_before} -> ${_len_after}")
  if(NOT _len_before EQUAL _len_after)
    cm_printf(FATAL "duplicate found in list which should not contain duplicates: ${list_id}")
  endif()
  unset(_len_before)
  unset(_len_after)
endfunction()


# --------------------------------------------------------------------
# 
function(cm_add_library
  name
  sources
  includes
  includes_sys
  library_deps
  )

  cm_add_library__impl(${name} "${sources}" "${includes}" "${includes_sys}" "${library_deps}")
endfunction()

function(cm_add_library__impl
  name
  sources
  includes
  includes_sys
  library_deps
  )

  # SHARED, STATIC, MODULE 명시는 하지 않았으나... SHARED로 처리할 수 있는 방법을 찾아서 적용할 예정
  add_library(${name} ${sources})
  # add include path to project
  target_include_directories(${name} PUBLIC ${includes}) 
  # add library source
  target_sources(${name} PUBLIC ${sources})
  # remove default library output file's prefix ( default prefix = "lib" )
  set_target_properties(${name} PROPERTIES PREFIX "")
  # link dependecy libraries
  if(library_deps)
   target_link_libraries(${name} ${library_deps})
  endif()

  # assert duplicates in function arguments
  list_assert_duplicates("${sources}")
  list_assert_duplicates("${includes}")

endfunction()