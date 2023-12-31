//
// Created by Minkyeu Kim on 12/13/23.
//

#ifndef INTERN_LIBCM_SAL_H
#define INTERN_LIBCM_SAL_H

/*
		Visual Studio       _MSC_VER
		gcc                 __GNUC__
		clang               __clang__
		emscripten          __EMSCRIPTEN__ (for asm.js and webassembly)
		MinGW 32            __MINGW32__
		MinGW-w64 32bit     __MINGW32__
		MinGW-w64 64bit     __MINGW64__
*/

#if defined(__clang__)
    #define MK_COMPILER_CLANG
#elif defined(__GNUC__) || defined(__GNUG__)
    #define MK_COMPILER_GCC
#elif defined(_MSC_VER)
    #define MK_COMPILER_MSVC
#elif defined(__MINGW32__) || defined(__MINGW64__)
	// ...
#endif


// Microsoft source-code annotation language
// ------------------------------------------------
// MSVC를 쓰지 않아도 Microsoft source-code annotation language (SAL)를 활용하기 위한 헤더.
// https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/shared/sal.h
// https://learn.microsoft.com/en-us/archive/blogs/michael_howard/a-brief-introduction-to-the-standard-annotation-language-sal
// https://learn.microsoft.com/en-us/cpp/code-quality/understanding-sal?view=msvc-170

#if (defined(MK_COMPILER_MSVC)) || \
    (defined(__has_include) && __has_include(<sal.h>))
    #include <sal.h>
#else
    #include "empty_sal_def.h" // MS Sal과 동일하게 define 되어 있고, 구현은 안되어있는 대체 헤더.
#endif

// MS Sal에 없는 추가 Annotation 정의.
// https://en.cppreference.com/w/cpp/language/attributes

// ------------------------------------
#ifdef _Check_return_void_
#   undef _Check_return_void_
#endif
#define _Check_return_void_ 

// ------------------------------------
#ifdef _Deprecated_
#   undef _Deprecated_
#endif
#ifdef _Deprecated__
#   undef _Deprecated__
#endif
#if __has_attribute(deprecated)
#   define _Deprecated_                     [[deprecated]]
#   define _Deprecated__(reason_string)     [[deprecated(reason_string)]]
#else
#   define _Deprecated_
#   define _Deprecated__(reason_string)
#endif

// ------------------------------------
#ifdef _Fallthrough_
#   undef _Fallthrough_
#endif
#if (__has_cpp_attribute(fallthrough))
#   define _Fallthrough_                    [[fallthrough]]
#else
#   define _Fallthrough_
#endif

#endif //INTERN_LIBCM_SAL_H