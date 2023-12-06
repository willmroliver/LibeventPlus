cmake_minimum_required(VERSION 3.26)
project(LibeventPlus VERSION 1.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED true)

find_package(Libevent REQUIRED)

add_library(
    LibeventPlus
        src/event-base.cpp
        src/event.cpp
)

target_include_directories(
    LibeventPlus
        PUBLIC
            include
)

target_link_libraries(
    LibeventPlus 
        PUBLIC
            libevent::core
)