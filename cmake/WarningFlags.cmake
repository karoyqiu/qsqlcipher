macro(CHECK_WARNING_FLAGS WARNING_FLAGS)
    if(CMAKE_C_COMPILER_ID STREQUAL "GNU" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
        set(CANDIDATE_FLAGS
            "-Wall"
            "-Wextra"
            "-Wpedantic"
            "-pedantic"
            "-Wformat=2"
            "-Werror=return-type"
            "-Werror=vexing-parse"
            "-Wno-unknown-pragmas"
            "-Wno-unused-local-typedefs"
        )
    elseif(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
        set(CANDIDATE_FLAGS "/W4"
            "/wd4127"       # C4127: 条件表达式是常量
            "/wd4503"       # C4503: 超出修饰名的长度，名称被截断
            "/wd4512"       # C4512: 未能生成赋值运算符
            "/wd4996"       # C4996: The POSIX name for this item is deprecated.
        )
    endif()

    include(CheckCCompilerFlags)
    CHECK_C_COMPILER_FLAGS(${WARNING_FLAGS} ${CANDIDATE_FLAGS})
endmacro()
