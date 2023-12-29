#
# Created by Minkyeu Kim on 12/13/23.
# 

# Cmake 안에서 사용할 헬퍼 함수들을 여기서 정의합니다.

# Reference : Blender cmake macro functions
# --------------------------------------------------------------------
# https://github.com/blender/blender/blob/9c0bffcc89f174f160805de042b00ae7c201c40b/build_files/cmake/macros.cmake#L415

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


# Cmake Colorized message function
# --------------------------------------------------------------------
# https://stackoverflow.com/questions/18968979/how-to-make-colorized-message-with-cmake

# How to Use
    # cm_printf(FATAL "...") --> 에러 메시지
    # cm_printf(WARN "...") --> 경고성 메시지
    # cm_printf(NOTE "...") --> 단순 로그 메시지

function(cm_printf)
    list(GET ARGV 0 MessageType)
    if(MessageType STREQUAL FATAL) # 심각한 CMAKE 에러
        list(REMOVE_AT ARGV 0)
        message("${BoldRed}${ARGV}${ColourReset}")
    elseif(MessageType STREQUAL WARN) # 경고성 메시지
        list(REMOVE_AT ARGV 0)
        message("${BoldYellow}${ARGV}${ColourReset}")
    elseif(MessageType STREQUAL NOTE) # 단순 정보 출력용 메시지
        list(REMOVE_AT ARGV 0)
        message("${Green}${ARGV}${ColourReset}")
    else()
        message("${ARGV}")
    endif()
endfunction()