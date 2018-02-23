#.rst
# VariableNameForSymbol
# ---------------------
#
# 根据符号名称生成变量名称。
#
# VARNAME_FOR_SYMBOL(<symbol> <var> [<prefix>])
#
macro(VARNAME_FOR_SYMBOL _sym _var)
    if(${ARGC} GREATER 2)
        set(_prefix "${ARGV2}")
    else()
        set(_prefix "HAVE")
    endif()
    string(TOUPPER ${_sym} _upper)
    string(REPLACE "/" "_" _upper ${_upper})
    string(REPLACE "-" "_" _upper ${_upper})
    string(REPLACE "." "_" _upper ${_upper})
    string(REPLACE ":" "_" _upper ${_upper})
    string(REPLACE "=" "_" _upper ${_upper})
    string(REPLACE "+" "X" _upper ${_upper})
    string(REGEX REPLACE "^_+" "" _upper ${_upper})
    set(${_var} "${_prefix}_${_upper}")
endmacro()
