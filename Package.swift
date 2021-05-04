// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "VacciBody",
  products: [
    .executable(
      name: "VacciBody",
      targets: ["VacciBody"]
    ),
    .library(
      name: "VacciBodyLib",
      targets: ["VacciBodyLib"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
    .package(url: "https://github.com/apple/swift-tools-support-core.git", from: "0.2.0")
  ],
  targets: [
    .target(
      name: "VacciBody",
      dependencies: ["VacciBodyLib"]),
    .target(
      name: "VacciBodyLib",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core")
      ]
    ),
    .testTarget(
      name: "VacciBodyTests",
      dependencies: ["VacciBodyLib"]),
  ]
)
