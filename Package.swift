// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Idniecap",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Idniecap",
            targets: ["idniecapPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "idniecapPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/idniecapPlugin"),
        .testTarget(
            name: "idniecapPluginTests",
            dependencies: ["idniecapPlugin"],
            path: "ios/Tests/idniecapPluginTests")
    ]
)