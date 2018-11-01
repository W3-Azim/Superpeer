#!/usr/bin/env bash

# --- Adapted from https://github.com/paritytech/scripts under Apache 2.0 license ---

## Update this with any new release!
VERSION_STABLE="1.8.6"
VERSION_BETA="1.8.6"
##

RELEASE="stable"
ARCH=$(uname -m)
VANITY_SERVICE_URL="https://vanity-service.parity.io/parity-binaries?architecture=$ARCH&format=markdown"
PKG="linux"
DOCKER_TAG=0.1


get_binary() {
	if [ "$RELEASE" = "beta" ]; then
		LOOKUP_URL="$VANITY_SERVICE_URL&os=$PKG&version=v$VERSION_BETA"
	elif [ "$RELEASE" = "stable" ]; then
		LOOKUP_URL="$VANITY_SERVICE_URL&os=$PKG&version=v$VERSION_STABLE"
	else
		LOOKUP_URL="$VANITY_SERVICE_URL&os=$PKG&version=$RELEASE"
	fi

  MD=$(curl -Ss ${LOOKUP_URL} | grep -v sha256 | grep " \[parity\]")
  DOWNLOAD_FILE=$(echo $MD | grep -oE 'https://[^)]+')
  echo "Downloading: $DOWNLOAD_FILE"
  curl -Ss -O $DOWNLOAD_FILE
}

## MAIN ##

## curl installed?
which curl &> /dev/null
if [[ $? -ne 0 ]] ; then
    echo '"curl" binary not found, please install and retry'
    exit 1
fi
##

while [ "$1" != "" ]; do
	case $1 in
	-r | --release )           shift
		RELEASE=$1
		;;
	* )  	help
		exit 1
		esac
	shift
	done

	echo "Release selected is: $RELEASE"

get_binary
docker build -t "parity:$DOCKER_TAG" .
rm parity