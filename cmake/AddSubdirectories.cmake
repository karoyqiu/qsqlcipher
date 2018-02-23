# - Add subdirectories.
# add_subdirectories(sub_dir)

macro(add_subdirectories sub_dir)
    file(GLOB subdirs RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${sub_dir}/*")
    foreach(subdir ${subdirs})
        if(IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/${subdir}")
            add_subdirectory(${subdir})
        endif()
    endforeach()
endmacro()
