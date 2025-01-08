cmake_minimum_required(VERSION 3.20)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(GNUInstallDirs)
include(cmake/install-qml-module.cmake)

option(BUILD_TESTER "Build style tester" OFF)

# Get version
file(READ "${CMAKE_SOURCE_DIR}/VERSION" VER_RAW)
string(STRIP ${VER_RAW} VER)

project(hyprland-qt-support VERSION ${VER} LANGUAGES CXX)

find_package(Qt6 6.6 REQUIRED COMPONENTS Qml Quick QuickControls2)
find_package(PkgConfig REQUIRED)

pkg_check_modules(hyprlang REQUIRED IMPORTED_TARGET hyprlang>=0.6.0)

qt_standard_project_setup(REQUIRES 6.6)
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)

add_subdirectory(src)
