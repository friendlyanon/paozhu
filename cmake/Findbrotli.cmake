# brotli doesn't support CMake clients despite being CMake managed. Extra shame!
find_package(PkgConfig)
set(dec "")
set(enc "")
if(PKGCONFIG_FOUND)
  foreach(type dec enc)
    pkg_check_modules(brotli${type} QUIET IMPORTED_TARGET libbrotli${type})
    if(brotli${type}_FOUND)
      set(${type} PkgConfig::brotli${type})
    endif()
  endforeach()
endif()

if(NOT dec or NOT enc)
  find_package(unofficial-brotli)
  if(unofficial-brotli_FOUND)
    set(dec unofficial::brotli::brotlidec)
    set(enc unofficial::brotli::brotlienc)
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(brotli DEFAULT_MSG enc dec)

if(brotli_FOUND)
  foreach(type dec enc)
    if(NOT TARGET brotli::brotli${type})
      add_library(brotli::brotli${type} INTERFACE)
      set_property(TARGET brotli::brotli${type} PROPERTY INTERFACE_LINK_LIBRARIES ${${type}})
    endif()
  endforeach()
endif()
