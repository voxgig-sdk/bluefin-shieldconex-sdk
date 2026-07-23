// swift-tools-version:5.9
//
// BluefinShieldconex SDK - SwiftPM manifest. Zero runtime dependencies (Foundation +
// the vendored Voxgig Struct port under Sources/ProjectNameSDK/Struct).
import PackageDescription

let package = Package(
    name: "BluefinShieldconexSdk",
    products: [
        .library(name: "BluefinShieldconexSdk", targets: ["BluefinShieldconexSdk"]),
    ],
    targets: [
        .target(
            name: "BluefinShieldconexSdk",
            path: "Sources/ProjectNameSDK"),
        .testTarget(
            name: "BluefinShieldconexSdkTests",
            dependencies: ["BluefinShieldconexSdk"],
            path: "Tests/ProjectNameSDKTests"),
    ]
)
