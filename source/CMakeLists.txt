cm_printf(STATUS " Current CmakeLists.txt location : ${CMAKE_CURRENT_LIST_DIR} ")

set(INC
  ${CMAKE_SOURCE_DIR}/intern/libcm
)

set(LIB
  cm::intern::libcm
)

set(SRC
  main.cpp
)

#
add_executable( ${NAME} ${SRC} )

#
target_include_directories( ${NAME} PUBLIC ${INC} )
#
target_link_libraries( ${NAME} PRIVATE ${LIB} )
