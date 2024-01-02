//
// Created by Minkyeu Kim on 12/13/23.
//

#ifndef INTERN_LIBCM_ASSERT_H
#define INTERN_LIBCM_ASSERT_H

#include <cstdlib>
#include <cstdio>

/*
 * ASSERT Macro
 * 
 * ------------------------------------------------------
 * |     CM_ASSERT_COMPILE("이름", expr, "메시지");      |
 * ------------------------------------------------------
 *   타입 비교, 바이트패딩 체크 등 컴파일 타임에 값을 검증해야 할 경우 사용합니다.
 * 
 * ------------------------------------------------------
 * |     CM_ASSERT_NOTE("이름", expr, "메시지");         |
 * ------------------------------------------------------
 *   런타임 Assert가 발생해도 프로그램이 종료되지 않아야 할 경우 사용합니다. (가벼운 로그/알림용) 
 * 
 * ------------------------------------------------------
 * |     CM_ASSERT_DEV("이름", expr, "메시지");          |    -------->>>  주로 사용할 매크로입니다!
 * ------------------------------------------------------
 *   런타임 Assert가 발생하면 메시지와 함께 프로그램이 종료됩니다.
 *   릴리즈 모드에선 매크로가 비활성화됩니다.
 * 
 * ------------------------------------------------------
 * |     CM_ASSERT_MUST("이름", expr, "메시지");         |
 * ------------------------------------------------------
 *   런타임 Assert가 발생하면 메시지와 함께 프로그램이 종료됩니다. 
 *   릴리즈 모드에서도 매크로가 활성 상태를 유지합니다.
*/

#define _CM_ASCII_RED     "\x1b[31m"
#define _CM_ASCII_GREEN   "\x1b[32m"
#define _CM_ASCII_YELLOW  "\x1b[33m"
#define _CM_ASCII_BLUE    "\x1b[34m"
#define _CM_ASCII_MAGENTA "\x1b[35m"
#define _CM_ASCII_CYAN    "\x1b[36m"
#define _CM_ASCII_RESET   "\x1b[0m"

#define CM_ASSERT_COMPILE(developer, expr, formatString)  static_assert(expr, developer ": " formatString)

/* TODO: doAbort로 가르지 말고, Assert UI창을 따로 띄우고 [계속(continue)] [중지(pause)] [종료(abort)] 3가지 버튼 제공 + CallStack도 같이 보여주면 좋을 듯?   */
#define __CM_ASSERT_IMPLEMENT(developer, expr, formatString, doAbort)                                                                                                                                                                    \
  if (false == static_cast<bool>(expr))                                                                                                                                                                                                  \
  {                                                                                                                                                                                                                                      \
    if constexpr (doAbort)                                                                                                                                                                                                               \
    {                                                                                                                                                                                                                                    \
      fprintf(stderr, _CM_ASCII_RED "Assertion failed: (%s), %s: %s\nAt function %s, file %s, line %d.\n" _CM_ASCII_RESET, #expr, developer, formatString, __PRETTY_FUNCTION__, __FILE__, __LINE__);                                     \
      abort();                                                                                                                                                                                                                           \
    }                                                                                                                                                                                                                                    \
    else                                                                                                                                                                                                                                 \
    {                                                                                                                                                                                                                                    \
      fprintf(stderr, _CM_ASCII_MAGENTA "Assertion failed: (%s), %s: %s\nAt function %s, file %s, line %d.\n\nPress any key to continue...\n" _CM_ASCII_RESET, #expr, developer, formatString, __PRETTY_FUNCTION__, __FILE__, __LINE__); \
      getchar();                                                                                                                                                                                                                         \
    }                                                                                                                                                                                                                                    \
  }

#if defined(CM_DEBUG)
# define CM_ASSERT_NOTE(developer, expr, formatString)    __CM_ASSERT_IMPLEMENT(developer, expr, formatString, 0)
# define CM_ASSERT_DEV(developer, expr, formatString)     __CM_ASSERT_IMPLEMENT(developer, expr, formatString, 1)
# define CM_ASSERT_MUST(developer, expr, formatString)    __CM_ASSERT_IMPLEMENT(developer, expr, formatString, 1)

#elif defined(CM_RELEASE)
# define CM_ASSERT_NOTE(developer, expr, formatString)    ((void)0)
# define CM_ASSERT_DEV(developer, expr, formatString)     ((void)0)
# define CM_ASSERT_MUST(developer, expr, formatString)    __CM_ASSERT_IMPLEMENT(developer, expr, formatString, 1)
#endif

// CMAKE에서 릴리즈 모드는 자동으로 해주나보다..
// #ifdef CM_RELEASE
// #define NDEBUG
// #endif

#endif // INTERN_LIBCM_ASSERT_H