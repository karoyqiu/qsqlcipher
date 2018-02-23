# - Enable folders.

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

function(enable_folder target)
    get_target_property(type ${target} TYPE)
    string(REGEX MATCH "STATIC_LIBRARY|MODULE_LIBRARY|SHARED_LIBRARY|OBJECT_LIBRARY|EXECUTABLE|UTILITY"
            have_source_dir ${type})
    if(have_source_dir)
        get_target_property(source_dir ${target} SOURCE_DIR)
        file(RELATIVE_PATH rel_path ${CMAKE_SOURCE_DIR} ${source_dir})
        set_target_properties(${target} PROPERTIES FOLDER ${rel_path})
    endif()
endfunction()

function(add_executable name)
    _add_executable(${name} ${ARGN})
    enable_folder(${name})
endfunction()

function(add_library name)
    _add_library(${name} ${ARGN})
    enable_folder(${name})
endfunction()

function(add_custom_target name)
    _add_custom_target(${name} ${ARGN})
    enable_folder(${name})
endfunction()
