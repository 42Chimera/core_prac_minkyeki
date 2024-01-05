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

print_dependency_header spglog
git clone -b v1.11.0 https://github.com/gabime/spdlog.git source
cmake -S ./source -B ./source/build && make -C ./source/build -j4