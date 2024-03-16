cmake_minimum_required(VERSION 3.21)
project(Galaxy-Explorer
LANGUAGES C CXX
)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(${PROJECT_SOURCE_DIR}/project_options.cmake)
include(${PROJECT_SOURCE_DIR}/dependencies.cmake)

add_subdirectory(src)