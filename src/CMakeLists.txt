add_library(qsqlcipher SHARED
    qsqlcipherplugin.h qsqlcipherplugin.cpp
    qsql_sqlcipher_p.h qsql_sqlcipher.cpp
    sqlcipher.json
)
target_compile_definitions(qsqlcipher PRIVATE QT_PLUGIN)

# Qt5
find_package(Qt5Sql REQUIRED COMPONENTS Private)
target_link_libraries(qsqlcipher PRIVATE Qt5::Sql Qt5::SqlPrivate sqlite)
