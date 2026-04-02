// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CommunicationCoach",
    platforms: [.iOS(.v17)],
    products: [
        .iOSApplication(
            name: "CommunicationCoach",
            targets: ["CommunicationCoach"],
            bundleIdentifier: "com.telecomcoach.communicationskills",
            teamIdentifier: "",
            displayVersion: "1.0.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .microphone),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [.phone, .pad],
            supportedInterfaceOrientations: [.portrait, .landscapeRight, .landscapeLeft],
            appCategory: .education
        )
    ],
    targets: [
        .executableTarget(
            name: "CommunicationCoach",
            path: "Sources"
        )
    ]
)
