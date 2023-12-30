#
# Created by Minkyeu Kim on 12/13/23.
#

# Reference : Blender cmake macro functions
# --------------------------------------------------------------------
# https://github.com/blender/blender/blob/9c0bffcc89f174f160805de042b00ae7c201c40b/build_files/cmake/macros.cmake#L415
# Cmake 안에서 사용할 헬퍼 함수들을 여기서 정의합니다.


# Cmake Colorized message function
# --------------------------------------------------------------------
# https://stackoverflow.com/questions/18968979/how-to-make-colorized-message-with-cmake

# Add Library Macro : cm_printf(...)

# How to Use
# cm_printf(FATAL "foo") --> 에러 메시지, 빨간색
# cm_printf(WARN "bar") --> 경고성 메시지, 마젠타
# cm_printf(NOTE "baz") --> 단순 로그 메시지, 초록색

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
        message("${BoldRed}${ARGV}${ColourReset}")
    elseif(MessageType STREQUAL WARN) # 경고성 메시지
        list(REMOVE_AT ARGV 0)
        message("${BoldYellow}${ARGV}${ColourReset}")
    elseif(MessageType STREQUAL STATUS) # 단순 정보 출력용 메시지
        list(REMOVE_AT ARGV 0)
        message("${Green}${ARGV}${ColourReset}")
    else()
        message("${ARGV}")
    endif()
endfunction()



# --------------------------------------------------------------------
# Nicer makefiles with -I/1/foo/ instead of -I/1/2/3/../../foo/
# use it instead of include_directories()
function(absolute_include_dirs
  includes_absolute)

  set(_ALL_INCS "")
  foreach(_INC ${ARGN})
    # Pass any scoping keywords as is
    if(("${_INC}" STREQUAL "PUBLIC") OR
       ("${_INC}" STREQUAL "PRIVATE") OR
       ("${_INC}" STREQUAL "INTERFACE"))
      list(APPEND _ALL_INCS ${_INC})
    else()
      get_filename_component(_ABS_INC ${_INC} ABSOLUTE)
      list(APPEND _ALL_INCS ${_ABS_INC})
      # for checking for invalid includes, disable for regular use
      # if(NOT EXISTS "${_ABS_INC}/")
      #   message(FATAL_ERROR "Include not found: ${_ABS_INC}/")
      # endif()
    endif()
  endforeach()

  set(${includes_absolute} ${_ALL_INCS} PARENT_SCOPE)
endfunction()


function(blender_target_include_dirs_impl
        target
        system
        includes
)
    set(next_interface_mode "PRIVATE")
    foreach(_INC ${includes})
        if(("${_INC}" STREQUAL "PUBLIC") OR
        ("${_INC}" STREQUAL "PRIVATE") OR
        ("${_INC}" STREQUAL "INTERFACE"))
            set(next_interface_mode "${_INC}")
        else()
            if(system)
                target_include_directories(${target} SYSTEM ${next_interface_mode} ${_INC})
            else()
                target_include_directories(${target} ${next_interface_mode} ${_INC})
            endif()
            set(next_interface_mode "PRIVATE")
        endif()
    endforeach()
endfunction()

# Nicer makefiles with -I/1/foo/ instead of -I/1/2/3/../../foo/
# use it instead of target_include_directories()
function(blender_target_include_dirs
        target
)
    absolute_include_dirs(_ALL_INCS ${ARGN})
    blender_target_include_dirs_impl(${target} FALSE "${_ALL_INCS}")
endfunction()

function(blender_target_include_dirs_sys
        target
)
    absolute_include_dirs(_ALL_INCS ${ARGN})
    blender_target_include_dirs_impl(${target} TRUE "${_ALL_INCS}")
endfunction()

# -----------------------------------------------------------------------------
# Add Library Macro : cm_add_lib(...)

# only MSVC uses SOURCE_GROUP
function(blender_add_lib__impl
        name
        sources
        includes
        includes_sys
        library_deps
)
    # message(STATUS "Configuring library ${name}")
    add_library(${name} ${sources})

    blender_target_include_dirs(${name} ${includes})
    blender_target_include_dirs_sys(${name} ${includes_sys})

    if(library_deps)
        blender_link_libraries(${name} "${library_deps}")
    endif()

    # works fine without having the includes
    # listed is helpful for IDE's (QtCreator/MSVC)

    # blender_source_group("${name}" "${sources}")
    # blender_user_header_search_paths("${name}" "${includes}")

    # list_assert_duplicates("${sources}")
    # list_assert_duplicates("${includes}")
    
    # Not for system includes because they can resolve to the same path
    # list_assert_duplicates("${includes_sys}")
endfunction()

function(cm_add_lib
        name
        sources
        includes
        includes_sys
        library_deps
)
    blender_add_lib__impl(${name} "${sources}" "${includes}" "${includes_sys}" "${library_deps}")
    # https://cmake.org/cmake/help/latest/command/set_property.html
    set_property(GLOBAL APPEND PROPERTY CM_LINK_LIBS=${name})
endfunction()
