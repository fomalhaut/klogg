message("Version override ${BUILD_VERSION}")
message("Build ${BUILD_NUMBER}")

string (REGEX MATCHALL "[0-9]+" _versionComponents "${BUILD_VERSION}")
list (LENGTH _versionComponents _len)
if (${_len} GREATER 0)
    list(GET _versionComponents 0 PROJECT_VERSION_MAJOR)
endif()
if (${_len} GREATER 1)
    list(GET _versionComponents 1 PROJECT_VERSION_MINOR)
endif()
if (${_len} GREATER 2)
    list(GET _versionComponents 2 PROJECT_VERSION_PATCH)
endif()
if (${_len} GREATER 3)
    list(GET _versionComponents 3 PROJECT_VERSION_TWEAK)
endif()
set (PROJECT_VERSION_COUNT ${_len})

if (NOT PROJECT_VERSION_PATCH)
    set(PROJECT_VERSION_PATCH 0)
endif()

if (NOT ${BUILD_NUMBER} STREQUAL "")
    set(PROJECT_VERSION_TWEAK ${BUILD_NUMBER})
endif()

if (NOT PROJECT_VERSION_TWEAK)
    set(PROJECT_VERSION_TWEAK 0)
endif()

if (${PROJECT_VERSION_COUNT} GREATER 0)
    set (PROJECT_VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH})
endif()

message("Project version is ${PROJECT_VERSION}")
message("Project version tweak is ${PROJECT_VERSION_TWEAK}")

include_directories(${CMAKE_BINARY_DIR}/generated)

add_custom_target (generate_version ALL
    COMMAND ${CMAKE_COMMAND} -DBUILD_VERSION=${PROJECT_VERSION}.${PROJECT_VERSION_TWEAK} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/generate_version_h.cmake
    SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/cmake/generate_version_h.cmake
)

