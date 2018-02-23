# Check multiple C compiler flags.
include(CheckCCompilerFlag)
include(VariableNameForSymbol)

function(check_c_compiler_flags output_var)
    set(_existed)
    foreach(f ${ARGN})
        VARNAME_FOR_SYMBOL(${f} _NAME "HAVE_FLAG")
        check_c_compiler_flag(${f} ${_NAME})
        if(${_NAME})
            list(APPEND _existed ${f})
        endif()
    endforeach()

    set(${output_var} ${_existed} PARENT_SCOPE)
endfunction()

function(select_c_compiler_flags output_var)
    foreach(f ${ARGN})
        VARNAME_FOR_SYMBOL(${f} _NAME "HAVE_FLAG")
        check_c_compiler_flag(${f} ${_NAME})
        if(${_NAME})
            set(${output_var} ${f} PARENT_SCOPE)
            return()
        endif()
    endforeach()

    unset(${output_var} PARENT_SCOPE)
endfunction()
