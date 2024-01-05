# prints colored text
print_style () {
    if [ "$2" == "info" ] ; then
        COLOR="96m";
    elif [ "$2" == "success" ] ; then
        COLOR="92m";
    elif [ "$2" == "warning" ] ; then
        COLOR="93m";
    elif [ "$2" == "danger" ] ; then
        COLOR="91m";
    else #default color
        COLOR="0m";
    fi
    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";
    printf "$STARTCOLOR%b$ENDCOLOR" "$1";
}

print_dependency_header () {
  print_style "-------------------------------------------\n" "info";
  print_style "   Building $1 \n"                             "info";
  print_style "-------------------------------------------\n" "info";
}

# -----------------------------------------------------
# build GLFW      # https://github.com/glfw/glfw
print_dependency_header glfw
git clone https://github.com/42Chimera/glfw.git source
cmake -S ./GLFW -B ./GLFW/build && make -C ./GLFW/build -j4