#!/bin/bash

# Change current working directory to script's directory
cd $(dirname $(readlink -f $0))/../

# Find the (1st) magnolia-core jar
CLASS_FILE=$(find ./webapps -name "magnolia-core-*.jar" | head -n 1)

# Ensure the javap utility exists
JAVAP="$JAVA_HOME/bin/javap"
if [ ! -f "$JAVAP" ]; then
  >&2 echo "Warning: Unable to check Java compatibility."
  exit
fi

# Extract the major version from the class file
MAJOR_VERSION=$("$JAVAP" -verbose "jar:file:$CLASS_FILE!/info/magnolia/init/MagnoliaServletContextListener.class" | sed -n 's/[[:space:]]*major version: \([0-9]*\)/\1/p')
if [ -z "$MAJOR_VERSION" ]; then
  >&2 echo "Warning: Unable to check Java compatibility."
  exit
fi

# Get the current Java runtime version
CURRENT_JAVA_VERSION=$(java -version 2>&1 | sed -n 's/.* version "\(.*\)".*/\1/p')
FIRST_NUMBER=$(echo $CURRENT_JAVA_VERSION | cut -d. -f1)

# Convert the current Java version to major version
if [[ "$FIRST_NUMBER" -ge 11 ]]; then
  CURRENT_MAJOR_VERSION=$((44 + FIRST_NUMBER))
else
  case "$CURRENT_JAVA_VERSION" in
    1.8*) CURRENT_MAJOR_VERSION=52;;
    1.9*) CURRENT_MAJOR_VERSION=53;;
    1.10*) CURRENT_MAJOR_VERSION=54;;
    *) >&2 echo "Warning: Unable to check Java compatibility."; exit;;
  esac
fi

# Convert back to more readable output
if [[ "$MAJOR_VERSION" -ge 55 ]]; then
  REQUIRED_JAVA_VERSION=$((MAJOR_VERSION - 44))
else
  case "$MAJOR_VERSION" in
    52) REQUIRED_JAVA_VERSION="1.8";;
    53) REQUIRED_JAVA_VERSION="1.9";;
    54) REQUIRED_JAVA_VERSION="1.10";;
    *) >&2 echo "Warning: Unable to check Java compatibility."; exit;;
  esac
fi

# Compare the major version
if [ "$MAJOR_VERSION" -gt "$CURRENT_MAJOR_VERSION" ]; then
  >&2 echo "Error: Magnolia cannot start. This version of Magnolia requires Java version $REQUIRED_JAVA_VERSION but the installed Java version is $CURRENT_JAVA_VERSION."
  exit 1
fi
