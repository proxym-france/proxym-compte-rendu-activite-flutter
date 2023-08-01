#!/usr/bin/env bash

fvm flutter packages get
echo "run analyzer in $1"
fvm flutter analyze
echo "run dartfmt in $1"
fvm flutter dartfmt -n --set-exit-if-changed ./
echo "running tests in $1"

fvm flutter test --coverage test/all_tests.dart || error=true

# Run test coverage check
flutter test --coverage

# Remove from created file (coverage/lcov.info) information about generated files and other unused files
lcov --ignore-errors unused
lcov --remove coverage/lcov.info '*.g.dart' '*.part.dart' '*/generated/*' -o coverage/lcov.info

# Generate HTML file for visualization of results
genhtml -o coverage coverage/lcov.info

# Open HTML file with results
open coverage/index.html
