
#include <iostream>

#include "libcm_assert.h"
#include "libcm_sal.h"

namespace Cm
{

_Check_return_void_ void test_speak() noexcept
{
    std::cout << "Speak\n";
}

}