#include <iostream>

#include "libcm.h"

int main()
{
    CM_ASSERT_NOTE("김민규", true, "assert test입니다!");
    test_add();
    std::cout << "Hello, from chimera!\n";
}
