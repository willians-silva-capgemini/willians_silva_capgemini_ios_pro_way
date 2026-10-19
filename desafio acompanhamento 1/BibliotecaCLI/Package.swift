// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "BibliotecaCLI",
    platforms: [.macOS(.v12)],
    targets: [
        .executableTarget(
            name: "BibliotecaCLI",
            path: "Sources/BibliotecaCLI"
        )
    ]
)
