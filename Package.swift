// swift-tools-version: 6.2
import PackageDescription

let package = Package(
  name: "wuhu-json",
  platforms: [
    .macOS("14.0"),
    .iOS("17.0"),
  ],
  products: [
    .library(name: "JSONValue", targets: ["JSONValue"]),
  ],
  targets: [
    .target(name: "JSONValue"),
    .testTarget(
      name: "JSONValueTests",
      dependencies: ["JSONValue"],
    ),
  ]
)
