add_library(sqlite STATIC sqlite3-all.c sqlite3.h sqlite3ext.h)
target_compile_definitions(sqlite PUBLIC
    SQLITE_ENABLE_COLUMN_METADATA
    SQLITE_OMIT_LOAD_EXTENSION
    SQLITE_OMIT_COMPLETE
    SQLITE_ENABLE_FTS3
    SQLITE_ENABLE_FTS3_PARENTHESIS
    SQLITE_ENABLE_FTS5
    SQLITE_ENABLE_RTREE
    SQLITE_HAS_CODEC
    SQLITE_TEMP_STORE=2
)
target_include_directories(sqlite INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}")
target_link_libraries(sqlite PUBLIC crypto)

if(WIN32)
    target_compile_definitions(sqlite PRIVATE WIN32_LEAN_AND_MEAN)
endif()
