#!/usr/bin/env bash

DOCKER_DIR=deploy/docker
APP_BIN_DIR=build/install/Superpeer/bin

SUPERPEER_DOCKER_TAG=0.1
VIZ_SUPERPEER_DOCKER_TAG=0.1

line_separator() {
    echo -e "\n"
    echo "---------------------"
}

# Generate SuperPeer binary
generate_superpeer_binary() {
    line_separator
    echo "Generating Superpeer binary"
    ./gradlew installDist
    echo $DOCKER_DIR/superPeer $DOCKER_DIR/vizSuperPeer | xargs -n 1 cp $APP_BIN_DIR/Superpeer
}

build_parity() {
    line_separator
    echo "Building Parity image"
    cd parity
    ./build.sh
    cd ..
}

build_superpeer() {
    line_separator
    echo "Building Superpeer image"
    cd superPeer
    docker build -t "superpeer:$SUPERPEER_DOCKER_TAG" .
    rm Superpeer
    cd ..
}

build_viz_superpeer() {
    line_separator
    echo "Building Visualization Superpeer image"
    cd vizSuperPeer
    docker build -t "viz_superpeer:$VIZ_SUPERPEER_DOCKER_TAG" .
    rm Superpeer
    cd ..
}

# Main
generate_superpeer_binary

cd $DOCKER_DIR
build_parity
build_superpeer
build_viz_superpeer
cd ../..

echo -e "\n"
echo "Finished building images: "
docker images

