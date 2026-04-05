// swift-tools-version: 5.9
import PackageDescription
import AppleProductTypes

let package = Package(
    name: "TelecomWisdom",
    platforms: [.iOS("17.0")],
    products: [
        .iOSApplication(
            name: "TelecomWisdom",
            targets: ["TelecomWisdom"],
            bundleIdentifier: "com.telecomwisdom.fiveg6g",
            teamIdentifier: "",
            displayVersion: "1.0.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .antenna),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [.phone, .pad],
            supportedInterfaceOrientations: [.portrait, .landscapeRight, .landscapeLeft],
            appCategory: .education
        )
    ],
    targets: [
        .executableTarget(
            name: "TelecomWisdom",
            path: "Sources"
        )
    ]
)
