//
// Created by Minkyeu Kim on 12/13/23.
//

#ifndef INTERN_LIBCM_ASSERT_H
#define INTERN_LIBCM_ASSERT_H

#include <cstdlib>
#include <cstdio>

#define CM_ASCII_RED     "\x1b[31m"
#define CM_ASCII_GREEN   "\x1b[32m"
#define CM_ASCII_YELLOW  "\x1b[33m"
#define CM_ASCII_BLUE    "\x1b[34m"
#define CM_ASCII_MAGENTA "\x1b[35m"
#define CM_ASCII_CYAN    "\x1b[36m"
#define CM_ASCII_RESET   "\x1b[0m"

// Compile time assertion.
// 타입 비교, 바이트패딩 체크 등 컴파일 타임에 체크해야 할 경우
#define CM_ASSERT_COMPILE(developer, expr, formatString)  static_assert(expr, CM_ASCII_RED developer ": " formatString CM_ASCII_RESET)

#define __CM_ASSERT_IMPLEMENT(developer, expr, formatString, abort)                                                                                                                                                          \
  if (false == static_cast<bool>(expr))                                                                                                                                                                                           \
  {                                                                                                                                                                                                                               \
    if constexpr (abort)                                                                                                                                                                                                          \
    {                                                                                                                                                                                                                             \
      fprintf(stderr, CM_ASCII_RED "Assertion failed: (%s), %s: %s\nAt function %s, file %s, line %d.\n" CM_ASCII_RESET, #expr, developer, formatString, __PRETTY_FUNCTION__, __FILE__, __LINE__);                                \
      abort();                                                                                                                                                                                                                    \
    }                                                                                                                                                                                                                             \
    else                                                                                                                                                                                                                          \
    {                                                                                                                                                                                                                             \
      fprintf(stderr, CM_ASCII_MAGENTA "Assertion failed: (%s), %s: %s\nAt function %s, file %s, line %d.\nPress any key to continue\n" CM_ASCII_RESET, #expr, developer, formatString, __PRETTY_FUNCTION__, __FILE__, __LINE__); \
      getchar();                                                                                                                                                                                                                  \
    }                                                                                                                                                                                                                             \
  }

 // Cmake에서 debug 모드로 빌드시, CM_DEBUG를 define합니다.
#if defined(CM_DEBUG)
# define CM_ASSERT_NOTE(developer, expr, formatString)    __CM_ASSERT_IMPLEMENT(developer, expr, formatString, 0)
# define CM_ASSERT_DEV(developer, expr, formatString)     __CM_ASSERT_IMPLEMENT(developer, expr, formatString, 1)
# define CM_ASSERT_MUST(developer, expr, formatString)    __CM_ASSERT_IMPLEMENT(developer, expr, formatString, 1)

 // Cmake에서 release 모드로 빌드시, CM_RELEASE를 define합니다.
#elif defined(CM_RELEASE)
# define CM_ASSERT_NOTE(developer, expr, formatString)    ((void)0)
# define CM_ASSERT_DEV(developer, expr, formatString)     ((void)0)
# define CM_ASSERT_MUST(developer, expr, formatString)    __CM_ASSERT_IMPLEMENT(developer, expr, formatString, 1)
#endif

// disable assert() function from <cassert>
#ifdef CM_RELEASE
#define NDEBUG
#endif

#endif // INTERN_LIBCM_ASSERT_H