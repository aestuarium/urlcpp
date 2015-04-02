# Copyright (c) 2011 Stanford University. All rights reserved.
# Use of this source code is governed by a MIT-style license that can
# be found in the LICENSE file.

CMAKE_MINIMUM_REQUIRED(VERSION 2.4)
SET(CMAKE_VERBOSE_MAKEFILE OFF)
SET(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS TRUE)

IF(COMMAND CMAKE_POLICY)
  # Use new policy for absolute path libraries.  We have no reason to depend on the
  # old version which adds library search paths unnecessarily
  CMAKE_POLICY(SET CMP0003 NEW)
ENDIF(COMMAND CMAKE_POLICY)

IF(APPLE)
    IF(IS_DIRECTORY /Developer/SDKs/MacOSX10.5.sdk)
        SET(CMAKE_CXX_COMPILER g++-4.0)
        SET(CMAKE_C_COMPILER gcc-4.0)
    ELSE()
        IF(EXISTS /usr/bin/g++-4.2)
          SET(CMAKE_CXX_COMPILER g++-4.2)
          SET(CMAKE_C_COMPILER gcc-4.2)
        ELSE()
          # Don't try to override. This is probably a newer setup
          # using XCode 4.2+ which doesn't provide versioned gcc's
          # since it uses llvm.
          #SET(CMAKE_CXX_COMPILER g++)
          #SET(CMAKE_C_COMPILER gcc)
        ENDIF()
    ENDIF()
ENDIF()

FIND_PACKAGE(BOOST 1.53)

IF (BOOST_FOUND)
  MESSAGE(ERROR "BOOST REQUIRED")
ENDIF()

PROJECT(urlcpp CXX)
ENABLE_LANGUAGE(CXX)

# Disable some annoying, unnecessary Windows warnings. Enable unwinding for exception handlers.
IF(WIN32)
  ADD_DEFINITIONS(-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS -EHsc)
  SET(CMAKE_CXX_FLAGS "-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS")
ENDIF()

# Force a default build type
IF(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE Release CACHE STRING
    "Build types include: Default Debug Release None RelWithDebInfo." FORCE
    )
ENDIF()
MESSAGE(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

# Define a few helpful directories
MESSAGE(STATUS "Base directory: ${CMAKE_CURRENT_SOURCE_DIR}")
SET(URLCPP_INCLUDE ${CMAKE_CURRENT_SOURCE_DIR}/include)
SET(URLCPP_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src)

INCLUDE_DIRECTORIES(${URLCPP_INCLUDE} ${BOOST_INCLUDE_DIR})

# Handle configuration options from parent projects
IF(LIBUJSON4C_ADDED_DEFINITIONS)
  ADD_DEFINITIONS(${LIBUJSON4C_ADDED_DEFINITIONS})
ENDIF()

# The main library
SET(URLCPP_LIB_SOURCES
  ${URLCPP_SRC}/path.cpp
  ${URLCPP_SRC}/url.cpp
)

ADD_LIBRARY(urlcpp STATIC ${URLCPP_LIB_SOURCES})
