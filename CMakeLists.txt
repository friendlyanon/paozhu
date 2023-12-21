cmake_minimum_required(VERSION 3.14)

project(Paozhu_web_framework CXX)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

function(paozhu_std name specifier)
  target_compile_features("${name}" "${specifier}" cxx_std_20)
endfunction()

option(PAOZHU_PRE_ONLY "Build paozhu_pre only" OFF)
if(PAOZHU_PRE_ONLY)
  # Generates sources into the source tree. Must be run as a separate build before main build.
  add_executable(paozhu_pre vendor/httpcli/autopickmethod.cpp vendor/httpserver/src/md5.cpp)
  paozhu_std(paozhu_pre PRIVATE)
  install(TARGETS paozhu_pre DESTINATION .)
  return()
endif()

add_executable(paozhu_cli vendor/httpcli/http_cli.cpp)
paozhu_std(paozhu_cli PRIVATE)

add_executable(paozhu "test/test\$<\$<CONFIG:Release>:daemon>.cpp" #[[sources go here, but without globbing! NO GLOBBING!]])

foreach(tgt paozhu_cli paozhu)
  paozhu_std("${tgt}" PRIVATE)
  target_include_directories("${tgt}" PRIVATE #[[all the include dirs, too lazy to list them all]])

  if(WIN32)
    target_link_libraries("${tgt}" PRIVATE ws2_32)
  endif()
endforeach()

foreach(dep asio OpenSSL ZLIB libmysql brotli)
  find_package("${dep}" REQUIRED)
endforeach()

target_link_libraries(paozhu PRIVATE ZLIB::ZLIB asio::asio OpenSSL::Crypto OpenSSL::SSL libmysql::libmysql brotli::brotlidec brotli::brotlienc)
target_link_libraries(paozhu_cli PRIVATE libmysql::libmysql)

option(PAOZHU_WITH_GD "" OFF)
if(PAOZHU_WITH_GD)
  pkg_check_modules(libgd REQUIRED IMPORTED_TARGET gdlib)
  foreach(dep qrencode PNG Freetype)
    find_package("${dep}" REQUIRED)
    target_link_libraries(paozhu PRIVATE "${dep}::${dep}")
  endforeach()
endif()

option(PAOZHU_WITH_BOOST "" OFF)
if(PAOZHU_WITH_BOOST)
  find_package(Boost REQUIRED)
  target_link_libraries(paozhu PRIVATE Boost::boost Boost::filesystem Boost::coroutine)
endif()
