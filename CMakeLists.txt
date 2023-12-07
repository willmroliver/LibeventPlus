cmake_minimum_required(VERSION 3.26)
project(LibeventPlus VERSION 1.0 DESCRIPTION "A minimal C++ wrapper for core parts of the Libevent library")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED true)

if (WIN32)
    set(CMAKE_INSTALL_PREFIX "c:/Program Files/libeventplus")
endif (WIN32)

if (UNIX)
    set(CMAKE_INSTALL_PREFIX "/usr/local/libeventplus")
endif(UNIX)

find_package(Libevent REQUIRED)

add_library(
    LibeventPlus
        src/event-base.cpp
        src/event.cpp
)

target_include_directories(
    LibeventPlus
        PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
            $<INSTALL_INTERFACE:include>
)

target_link_libraries(
    LibeventPlus 
        PUBLIC
            libevent::core
)

include(InstallRequiredSystemLibraries)

set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/license.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${LibeventPlus_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${LibeventPlus_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")

include(CPack)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

set_target_properties(
    LibeventPlus 
        PROPERTIES
            POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS}
)

install(
    TARGETS LibeventPlus 
    EXPORT LibeventPlusTargets
    DESTINATION bin
)

install(
    FILES include/event-base.hpp include/event.hpp 
    DESTINATION include
)

install(
    EXPORT LibeventPlusTargets
    FILE LibeventPlusTargets.cmake
    DESTINATION lib/cmake/LibeventPlus
)

include(CMakePackageConfigHelpers)

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/LibeventPlusConfig.cmake"
    INSTALL_DESTINATION "libeventplus/lib/cmake/example"
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/LibeventPlusConfigVersion.cmake"
  VERSION "${LibeventPlus_VERSION_MAJOR}.${LibeventPlus_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)

install(
    FILES
        ${CMAKE_CURRENT_BINARY_DIR}/LibeventPlusConfig.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/LibeventPlusConfigVersion.cmake
    DESTINATION
        lib/cmake/LibeventPlus
)

export(
    EXPORT LibeventPlusTargets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/LibeventPlusTargets.cmake"
)