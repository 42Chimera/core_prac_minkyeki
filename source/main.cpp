#include <iostream>

#include "INTERN_libcm.h"

namespace CM
{
class _Deprecated__("Test2 class를 사용해주세요") Test : public CM::NonCopyable
{
private: int32_t _data;
};
}

int main()
{
    // CM_ASSERT_COMPILE("김민규", sizeof(int) == 4, "compile assert test입니다!");
    CM_ASSERT_NOTE("김민규", false, "assert test입니다!");
    // CM::test_speak();

    std::cout << "Hello, from chimera!\n";

}
