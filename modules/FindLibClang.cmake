# - Try to find LibClang
# Once done this will define
#  LIBCLANG_FOUND - System has LibClang
#  LIBCLANG_VERSION - LibClang version
#  LIBCLANG_DEFINITIONS - Compiler switches required for using LibClang
#  LIBCLANG_INCLUDE_DIRS - The LibClang include directories
#  LIBCLANG_LIBRARIES - The libraries needed to use LibClang

find_program(LLVM_CONFIG
    NAMES llvm-config-3.8 llvm-config-3.7 llvm-config-3.6 llvm-config
    PATHS ENV LLVM_PATH)

if(NOT LLVM_CONFIG)
    message(FATAL_ERROR "Cannot find program: llvm-config")
endif()

execute_process(
    COMMAND ${LLVM_CONFIG} --version
    OUTPUT_VARIABLE LLVM_CONFIG_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE)
set(LIBCLANG_VERSION ${LLVM_CONFIG_VERSION})

set(LIBCLANG_DEFINITIONS "")

execute_process(
    COMMAND ${LLVM_CONFIG} --includedir
    OUTPUT_VARIABLE LLVM_CONFIG_INCLUDEDIR
    OUTPUT_STRIP_TRAILING_WHITESPACE)
find_path(LIBCLANG_INCLUDE_DIR clang-c/Index.h HINTS ${LLVM_CONFIG_INCLUDEDIR})
set(LIBCLANG_INCLUDE_DIRS ${LIBCLANG_INCLUDE_DIR})

execute_process(
    COMMAND ${LLVM_CONFIG} --libdir
    OUTPUT_VARIABLE LLVM_CONFIG_LIBDIR
    OUTPUT_STRIP_TRAILING_WHITESPACE)
find_library(LIBCLANG_LIBRARY NAMES clang HINTS ${LLVM_CONFIG_LIBDIR})
set(LIBCLANG_LIBRARIES ${LIBCLANG_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibClang
    FOUND_VAR LIBCLANG_FOUND
    REQUIRED_VARS LIBCLANG_LIBRARY LIBCLANG_INCLUDE_DIR
    VERSION_VAR LIBCLANG_VERSION)
mark_as_advanced(LIBCLANG_INCLUDE_DIR LIBCLANG_LIBRARY)
