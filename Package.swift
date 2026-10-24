// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Idniecap",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Idniecap",
            targets: ["idniecapPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main"),
        .package(url: "https://github.com/diegocidm4/iDNIe.git", branch: "main"),
        .package(url: "https://github.com/krzyzanowskim/OpenSSL.git", exact: "1.1.2301"),

    ],
    targets: [
        .target(
            name: "idniecapPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm"),
                .product(name: "iDNIe", package: "iDNIe"),
                .product(name: "OpenSSL", package: "OpenSSL")
            ],
            path: "ios/Sources/idniecapPlugin"),
        .testTarget(
            name: "idniecapPluginTests",
            dependencies: ["idniecapPlugin"],
            path: "ios/Tests/idniecapPluginTests")
    ]
)