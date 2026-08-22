// swift-tools-version:5.9
//
// BluefinShieldconex SDK - SwiftPM manifest. The runtime itself is dependency-free
// (Foundation + the vendored Voxgig Struct port under
// Sources/ProjectNameSDK/Struct); declared feature/target deps (if any)
// appear below.
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
