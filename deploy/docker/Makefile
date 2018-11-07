SUBDIRS = parity superPeer vizSuperPeer
APP_BIN_DIR=build/install/Superpeer/bin
DOCKER_DIR=deploy/docker
export DOCKER_TAG = 0.1

.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

gradleBinary:
	( cd ../.. && ./gradlew installDist && \
		echo $(DOCKER_DIR)/superPeer $(DOCKER_DIR)/vizSuperPeer | xargs -n 1 cp $(APP_BIN_DIR)/Superpeer )

$(SUBDIRS): gradleBinary
	$(MAKE) -C $@

saveImages: $(SUBDIRS)
	mkdir -p images
	docker save --output images/parity.tar parity:$(DOCKER_TAG)
	docker save --output images/superPeer.tar superpeer:$(DOCKER_TAG)

# Parity must be built before SP and vizSP
superPeer: parity
vizSuperPeer: parity