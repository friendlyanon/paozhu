# qrencode doesn't support CMake clients. Shame!
find_path(QRENCODE_INCLUDE_DIR qrencode.h)
find_library(QRENCODE_LIBRARY_RELEASE qrencode)
find_library(QRENCODE_LIBRARY_DEBUG qrencoded)

include(SelectLibraryConfigurations)
select_library_configurations(QRENCODE)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(qrencode DEFAULT_MSG QRENCODE_INCLUDE_DIR QRENCODE_LIBRARY)

if(qrencode_FOUND AND NOT TARGET qrencode::qrencode)
  add_library(qrencode::qrencode UNKNOWN IMPORTED)
  set_property(TARGET qrencode::qrencode PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${QRENCODE_INCLUDE_DIR})

  if(QRENCODE_LIBRARY_RELEASE)
    set_property(TARGET qrencode::qrencode APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
    set_property(TARGET qrencode::qrencode PROPERTY IMPORTED_LOCATION_RELEASE "${QRENCODE_LIBRARY_RELEASE}")
  endif()

  if(QRENCODE_LIBRARY_DEBUG)
    set_property(TARGET qrencode::qrencode APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
    set_property(TARGET qrencode::qrencode PROPERTY IMPORTED_LOCATION_DEBUG "${QRENCODE_LIBRARY_DEBUG}")
  endif()
endif()
