include_directories(../../include)

if(GO_EXECUTABLE)
  add_custom_command(
    OUTPUT err_data.c
    COMMAND ${GO_EXECUTABLE} run err_data_generate.go > ${CMAKE_CURRENT_BINARY_DIR}/err_data.c
    DEPENDS
    err_data_generate.go
    asn1.errordata
    bio.errordata
    bn.errordata
    cipher.errordata
    conf.errordata
    dh.errordata
    digest.errordata
    dsa.errordata
    ecdh.errordata
    ecdsa.errordata
    ec.errordata
    engine.errordata
    evp.errordata
    hkdf.errordata
    obj.errordata
    pem.errordata
    pkcs8.errordata
    rsa.errordata
    ssl.errordata
    x509.errordata
    x509v3.errordata
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  )
else()
  add_custom_command(
    OUTPUT err_data.c
    COMMAND ${CMAKE_COMMAND} ARGS -E copy "${CMAKE_CURRENT_SOURCE_DIR}/err_data.c" ${CMAKE_CURRENT_BINARY_DIR}/err_data.c
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/err_data.c"
  )
endif()

add_library(
  err

  OBJECT

  err.c
  err_data.c
)

#add_executable(
#  err_test

#  err_test.cc

#  $<TARGET_OBJECTS:test_support>
#)

#target_link_libraries(err_test crypto)
#add_dependencies(all_tests err_test)
