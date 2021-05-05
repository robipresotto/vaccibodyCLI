#
# VacciBody
# Dockerfile
#
# Builder image
#

FROM swift:5.3 as builder
LABEL Description = "VacciBody SwiftImage Builder"
MAINTAINER Robinson Presotto <rob@futureuniverse.com>

WORKDIR /app

RUN apt-get -qq update && apt-get install -y libsqlite3-dev \
&& rm -r /var/lib/apt/lists/*

# Copy the resources
COPY Resources/ ./Resources
COPY Sources/ ./Source
COPY Tests/ ./Tests
COPY Package.swift .

# Resolve dependencies
RUN swift package resolve

# Copy swift libs to local user lib
RUN mkdir -p /build/lib && cp -R /usr/lib/swift/linux/*.so* /build/lib

# Retrevies the build bin path
RUN swift build -c release -Xswiftc -g && mv `swift build -c release --show-bin-path` /build/bin
