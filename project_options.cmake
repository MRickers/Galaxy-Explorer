include(${PROJECT_SOURCE_DIR}/cmake/warnings.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/sanitizers.cmake)


# the following function was taken from:
# https://github.com/cpp-best-practices/cmake_template/blob/main/ProjectOptions.cmake
macro(check_sanitizer_support)
    if ((CMAKE_CXX_COMPILER_ID MATCHES ".*Clang.*" OR CMAKE_CXX_COMPILER_ID MATCHES ".*GNU.*") AND NOT WIN32)
        set(supports_ubsan ON)
        set(supports_thread_sanitizer ON)
    else ()
        set(supports_ubsan OFF)
        set(supports_thread_sanitizer OFF)
    endif ()

    if ((CMAKE_CXX_COMPILER_ID MATCHES ".*Clang.*" OR CMAKE_CXX_COMPILER_ID MATCHES ".*GNU.*") AND WIN32)
        set(supports_asan OFF)
        set(supports_thread_sanitizer OFF)
    else ()
        set(supports_asan ON)
        set(supports_thread_sanitizer OFF)
    endif ()
endmacro()

check_sanitizer_support()

if (PROJECT_IS_TOP_LEVEL)
    option(ge_warnings_as_errors "Treat warnings as errors" ON)
    option(ge_enable_undefined_behavior_sanitizer "Enable undefined behavior sanitizer" ${supports_ubsan})
    option(ge_enable_address_sanitizer "Enable address sanitizer" ${supports_asan})
    option(ge_enable_thread_sanitizer "Enable thread sanitizer" ${supports_thread_sanitizer})
else ()
    option(ge_warnings_as_errors "Treat warnings as errors" OFF)
    option(ge_enable_undefined_behavior_sanitizer "Enable undefined behavior sanitizer" OFF)
    option(ge_enable_address_sanitizer "Enable address sanitizer" OFF)
    option(ge_enable_thread_sanitizer "Enable thread sanitizer" OFF)
endif ()

add_library(ge_warnings INTERFACE)
set_warnings(ge_warnings ${ge_warnings_as_errors})

add_library(ge_sanitizers INTERFACE)
enable_sanitizers(
        ge_sanitizers
        ${ge_enable_address_sanitizer}
        ${ge_enable_undefined_behavior_sanitizer}
        ${ge_enable_thread_sanitizer}
)

add_library(ge_options INTERFACE)
target_link_libraries(ge_options
        INTERFACE ge_warnings
        INTERFACE ge_sanitizers
)