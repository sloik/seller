#!/bin/bash

# Identify all local Swift packages in the current directory and its subdirectories
# by looking for Package.swift files just one level below the current directory
packages=$(find . -mindepth 2 -maxdepth 2 -name Package.swift -exec dirname {} \;)

echo "Found Swift packages: $packages"

# For each package, run the `swift test` command to execute its unit tests
for package in $packages; do
  echo "Running tests for $package"

  cd "$package" || exit
  swift test  2>&1 | xcpretty

  cd - || exit
done
