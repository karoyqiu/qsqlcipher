add_library(qsqlcipher SHARED
    qsqlcipherplugin.h qsqlcipherplugin.cpp
    qsql_sqlcipher_p.h qsql_sqlcipher.cpp
    sqlcipher.json
)
target_compile_definitions(qsqlcipher PRIVATE QT_PLUGIN)
set_target_properties(qsqlcipher PROPERTIES
    DEBUG_POSTFIX "d"
)

# Qt5
find_package(Qt5Sql REQUIRED COMPONENTS Private)
target_link_libraries(qsqlcipher PRIVATE Qt5::Sql Qt5::SqlPrivate sqlite)
