# - Try to find JsonCpp
# Once done this will define
#  JSONCPP_FOUND - System has JsonCpp
#  JSONCPP_DEFINITIONS - Compiler switches required for using JsonCpp
#  JSONCPP_INCLUDE_DIRS - The JsonCpp include directories
#  JSONCPP_LIBRARIES - The libraries needed to use JsonCpp

find_package(PkgConfig)
pkg_check_modules(PC_JSONCPP QUIET jsoncpp)

set(JSONCPP_VERSION ${PC_JSONCPP_VERSION})

set(JSONCPP_DEFINITIONS ${PC_JSONCPP_CFLAGS_OTHER})

find_path(
    JSONCPP_INCLUDE_DIR json/json.h
    HINTS ${PC_JSONCPP_INCLUDEDIR} ${PC_JSONCPP_INCLUDE_DIRS})
set(JSONCPP_INCLUDE_DIRS ${JSONCPP_INCLUDE_DIR})

find_library(
    JSONCPP_LIBRARY NAMES jsoncpp
    HINTS ${PC_JSONCPP_LIBDIR} ${PC_JSONCPP_LIBRARY_DIRS})
set(JSONCPP_LIBRARIES ${JSONCPP_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Jsoncpp
    FOUND_VAR JSONCPP_FOUND
    REQUIRED_VARS JSONCPP_LIBRARY JSONCPP_INCLUDE_DIR
    VERSION_VAR JSONCPP_VERSION)
mark_as_advanced(JSONCPP_INCLUDE_DIR JSONCPP_LIBRARY)
