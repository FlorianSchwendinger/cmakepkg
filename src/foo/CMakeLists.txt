cmake_minimum_required(VERSION 3.5)
project(FOO VERSION 1.0 LANGUAGES CXX)

add_library(foo STATIC
    src/foo.cpp
)

include_directories(
    ${FOO_SOURCE_DIR}
)

install(TARGETS foo)
install(FILES ${FOO_SOURCE_DIR}/src/foo.h DESTINATION include)
