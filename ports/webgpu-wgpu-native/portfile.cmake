vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO goopey7/webgpu-wgpu-native
    REF "d927a7e"
    SHA512 0
    HEAD_REF master
)

vcpkg_from_github(
	OUT_SOURCE_PATH WGPU_NATIVE_SOURCE_PATH
    REPO gfx-rs/wgpu-native
    REF "d89e5a9"
    SHA512 c1b43bef6c18f28d69a9e78e009259f7eaef10ba35615c102196c57075a68e816552a22541f274bae6591eee8419ecc388b3aaaa5fac37a547476dc106dc4f38
    HEAD_REF trunk
)
file(RENAME ${WGPU_NATIVE_SOURCE_PATH} ${SOURCE_PATH}/wgpu-native)

vcpkg_from_github(
	OUT_SOURCE_PATH WEBGPU_HEADERS_SOURCE_PATH
    REPO webgpu-native/webgpu-headers
    REF "d02fec1"
    SHA512 ad708213b1f1b2e1896dea6b3ace28b4cf5747bed21ab45d74da24d4475482dc00cdcc220c90176ab2cdf8434818746d8aff11dbb18b3278c3380be21b978eeb
    HEAD_REF main
)
# Move the webgpu-headers submodule into the ffi directory of wgpu-native
file(RENAME ${WEBGPU_HEADERS_SOURCE_PATH} ${SOURCE_PATH}/wgpu-native/ffi/webgpu-headers)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

#vcpkg_cmake_config_fixup(PACKAGE_NAME "webgpu-wgpu-native")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
