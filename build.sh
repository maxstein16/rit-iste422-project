#!/bin/sh

# Define the source and test directories
main="src/main/java"
test="src/test/java"
build="build"

echo "Cleaning existing classes..."
rm -rf "$build"  # Remove the build directory and its contents
mkdir -p "$build"  # Recreate the build directory

echo "Compiling source code and unit tests..."
javac -d "$build" -classpath "lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar" "$main"/*.java "$test"/*.java
if [ $? -ne 0 ] ; then echo BUILD FAILED!; exit 1; fi

echo "Running unit tests..."
java -cp "$build":"lib/junit-4.12.jar":"lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore EdgeConnectorTest
if [ $? -ne 0 ] ; then echo TESTS FAILED!; exit 1; fi

echo "Running application..."
java -cp "$build" RunEdgeConvert
