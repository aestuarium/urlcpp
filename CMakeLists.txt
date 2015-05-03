cmake_minimum_required (VERSION 2.8)

option(URLCPP_BUILD_TESTS "Build the tests utility." ON)

project(URLCPP)

find_package(Boost 1.53 REQUIRED)
include_directories(include ${Boost_INCLUDE_DIRS})
link_directories(${Boost_LIBRARY_DIRS})

if (MSVC)
  # Disable some annoying, unnecessary Windows warnings. Enable unwinding for exception handlers.
  add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS -EHsc)
  set(CMAKE_CXX_FLAGS "-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS")
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fpic")
endif(MSVC)

add_library(urlcpp STATIC
  src/path.cpp
  src/url.cpp
)

if(${URLCPP_BUILD_TESTS})
find_package (Boost COMPONENTS unit_test_framework REQUIRED)
add_executable(urlcpp_test Url_test.cpp)
target_compile_definitions(urlcpp_test PUBLIC BOOST_TEST_MAIN=1 BOOST_TEST_DYN_LINK=1)
target_link_libraries(urlcpp_test urlcpp boost_unit_test_framework)
add_dependencies(urlcpp_test urlcpp)
endif()