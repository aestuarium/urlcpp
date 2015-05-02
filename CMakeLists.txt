cmake_minimum_required (VERSION 2.8)
project(URLCPP)

find_package(Boost 1.53 REQUIRED regex unit_test_framework)
include_directories(include ${Boost_INCLUDE_DIRS})
link_directories(${Boost_LIBRARY_DIRS})

if (MSVC)
  # Disable some annoying, unnecessary Windows warnings. Enable unwinding for exception handlers.
  add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS -EHsc)
  set(CMAKE_CXX_FLAGS "-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS")
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fpic")
endif(MSVC)

add_definitions(-DBOOST_TEST_MAIN)

add_library(urlcpp STATIC
  src/path.cpp
  src/url.cpp
)

add_executable(urlcpp_test Url_test.cpp)
target_link_libraries(urlcpp_test urlcpp ${Boost_LIBRARIES})
add_dependencies(urlcpp_test urlcpp)
