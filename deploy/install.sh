#!/usr/bin/env bash

# Set up parity
configure.sh

# Generate SuperPeer binary
./gradlew installDist

# Run SuperPeer
Superpeer
