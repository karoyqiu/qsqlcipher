﻿if(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
    set(CMAKE_C_FLAGS_INIT                  "/DWIN32 /D_WINDOWS /DNOMINMAX /D_WIN32_WINNT=0x0A00 /D_SCL_SECURE_NO_WARNINGS /D_CRT_SECURE_NO_WARNINGS")
    set(CMAKE_C_FLAGS_DEBUG_INIT            "/D_DEBUG /MDd /Zi /Ob0 /Od /RTC1")
    set(CMAKE_C_FLAGS_MINSIZEREL_INIT       "/MD /O1 /Ob1 /DNDEBUG")
    set(CMAKE_C_FLAGS_RELEASE_INIT          "/MD /O2 /Ob2 /DNDEBUG")
    set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT   "/MD /Zi /O2 /Ob1 /DNDEBUG")
    set(_linker_flags                       "/LARGEADDRESSAWARE")
    set(CMAKE_EXE_LINKER_FLAGS_INIT         "${_linker_flags}")
elseif(CMAKE_C_COMPILER_ID STREQUAL "GNU")
    set(CMAKE_C_FLAGS_INIT          "-pipe -fPIE -D_FILE_OFFSET_BITS=64")
    set(_linker_flags               "-Wl,-O1 -Wl,--no-undefined -Wl,--as-needed -Wl,--exclude-libs,ALL -Wl,-z,relro -Wl,-z,now -Wl,--discard-all")
    if(CMAKE_C_COMPILER_VERSION VERSION_LESS "4.9")
        set(CMAKE_C_FLAGS_INIT      "${CMAKE_C_FLAGS_INIT} -fstack-protector")
        set(_linker_flags           "${_linker_flags} -fstack-protector")
    else()
        set(CMAKE_C_FLAGS_INIT      "${CMAKE_C_FLAGS_INIT} -fstack-protector-strong -fdiagnostics-color")
        set(_linker_flags           "${_linker_flags} -fstack-protector-strong")
    endif()
    set(CMAKE_EXE_LINKER_FLAGS_INIT "${_linker_flags} -pie")
elseif(CMAKE_C_COMPILER_ID STREQUAL "Clang")
    set(CMAKE_C_FLAGS_INIT          "-pipe -fPIE -fcolor-diagnostics -fstack-protector-strong -D_FILE_OFFSET_BITS=64")
    set(_linker_flags               "-fstack-protector-strong -Wl,-O1 -Wl,--no-undefined -Wl,--as-needed -Wl,--exclude-libs,ALL -Wl,-z,relro -Wl,-z,now -Wl,--discard-all")
    set(CMAKE_EXE_LINKER_FLAGS_INIT "${_linker_flags} -pie")
endif()
set(CMAKE_SHARED_LINKER_FLAGS_INIT  "${_linker_flags}")
unset(_linker_flags)
