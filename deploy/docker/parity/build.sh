#!/usr/bin/env bash

# --- Adapted from https://github.com/paritytech/scripts under Apache 2.0 license ---

## Update this with any new release!
VERSION_STABLE="1.8.6"
VERSION_BETA="1.8.6"
##

BETA="beta"
STABLE="stable"

RELEASE="$STABLE"
ARCH=$(uname -m)
VANITY_SERVICE_URL="https://vanity-service.parity.io/parity-binaries?architecture=$ARCH&format=markdown"
PKG="linux"
DOCKER_TAG=0.1


get_binary() {
	if [ "$RELEASE" = "$BETA" ]; then
		LOOKUP_URL="$VANITY_SERVICE_URL&os=$PKG&version=v$VERSION_BETA"
	elif [ "$RELEASE" = "$STABLE" ]; then
		LOOKUP_URL="$VANITY_SERVICE_URL&os=$PKG&version=v$VERSION_STABLE"
	else
		LOOKUP_URL="$VANITY_SERVICE_URL&os=$PKG&version=$RELEASE"
	fi

  MD=$(curl -Ss ${LOOKUP_URL} | grep -v sha256 | grep " \[parity\]")
  DOWNLOAD_FILE=$(echo $MD | grep -oE 'https://[^)]+')
  echo "Downloading: $DOWNLOAD_FILE"
  curl -Ss -O $DOWNLOAD_FILE
}

help() {
    echo "Usage: $0 [-r <$BETA|$STABLE>]" 1>&2;
    exit 1
}

## MAIN ##

## curl installed?
which curl &> /dev/null
if [[ $? -ne 0 ]] ; then
    echo '"curl" binary not found, please install and retry'
    exit 1
fi
##

while getopts ":r:" release; do
  case $release in
    r)
        if [[ "$OPTARG" != "$STABLE" ]] && [[ "$OPTARG" != "$BETA" ]]
        then
            help
        fi
        RELEASE=$OPTARG
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        help
        ;;
    :)
        echo "Option -$OPTARG requires an argument." >&2
        help
        ;;
  esac
done

echo "Release selected is: $RELEASE"

get_binary
docker build -t "parity:$DOCKER_TAG" .
rm parity