# MySQL doesn't support CMake clients. Shame!
find_package(PkgConfig)
if(PKGCONFIG_FOUND)
  pkg_check_modules(libmysqlclient QUIET IMPORTED_TARGET mysqlclient)
endif()

set(mysql "")
if(libmysqlclient_FOUND)
  set(mysql PkgConfig::libmysqlclient)
else()
  find_package(unofficial-libmysql)
  if(TARGET unofficial::libmysql::libmysql)
    set(mysql unofficial::libmysql::libmysql)
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libmysql DEFAULT_MSG mysql)

if(libmysql_FOUND AND NOT TARGET libmysql::libmysql)
  add_library(libmysql::libmysql INTERFACE)
  set_property(TARGET libmysql::libmysql PROPERTY INTERFACE_LINK_LIBRARIES ${mysql})
endif()
