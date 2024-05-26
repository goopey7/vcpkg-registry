vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO goopey7/webgpu-wgpu-native
    REF "43177ee"
    SHA512 eb7d69d625b76a14896e9f81d2165f06e07a1ad2285989c3e00657ed10270ef0c6f348162737b541cd4edc7975a36f08b49b2eb37a004df2c68b6f8348e41190
    HEAD_REF master
)

vcpkg_from_github(
	OUT_SOURCE_PATH WGPU_NATIVE_SOURCE_PATH
    REPO gfx-rs/wgpu-native
    REF "d89e5a9"
    SHA512 0
    HEAD_REF trunk
)
file(RENAME ${WGPU_NATIVE_SOURCE_PATH} ${SOURCE_PATH}/wgpu-native)

vcpkg_from_github(
	OUT_SOURCE_PATH WEBGPU_HEADERS_SOURCE_PATH
    REPO webgpu-native/webgpu-headers
    REF "d02fec1"
    SHA512 0
    HEAD_REF main
)
# Move the webgpu-headers submodule into the ffi directory of wgpu-native
file(RENAME ${WEBGPU_HEADERS_SOURCE_PATH} ${SOURCE_PATH}/wgpu-native/ffi/webgpu-headers)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME "webgpu-wgpu-native")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
