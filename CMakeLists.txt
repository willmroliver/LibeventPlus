cmake_minimum_required(VERSION 3.26)
project(LibeventPlus VERSION 1.0 DESCRIPTION "A minimal C++ wrapper for core parts of the Libevent library")

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

install(TARGETS LibeventPlus DESTINATION bin)
install(FILES include/event-base.hpp include/event.hpp DESTINATION include)

include(InstallRequiredSystemLibraries)

set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/license.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${LibeventPlus_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${LibeventPlus_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")

include(CPack)