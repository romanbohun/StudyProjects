cmake_minimum_required(VERSION 3.24)
project(ncursetest C)

set(CMAKE_C_STANDARD 11)

find_package(Curses REQUIRED)
include_directories(${CURSES_INCLUDE_DIR})

add_executable(ncursetest main.c)

target_link_libraries(ncursetest ${CURSES_LIBRARIES})