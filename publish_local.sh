#!/bin/bash

# Script to publish to the local ~/.m2 directory

publish_library() {
  echo "Publishing $1"
  ./gradlew --no-daemon :$1:publishToMavenLocal
}

./gradlew --no-daemon clean \
     :lib-exoplayer:assembleRelease \
        :lib-common:assembleRelease \
        :lib-exoplayer-dash:assembleRelease \
        :lib-exoplayer-hls:assembleRelease \
        :lib-exoplayer-ima:assembleRelease \
        :lib-exoplayer-smoothstreaming:assembleRelease \
        :lib-ui:assembleRelease \
        :lib-cast:assembleRelease \
        :lib-datasource:assembleRelease \
        :lib-datasource-okhttp:assembleRelease \
        :lib-session:assembleRelease \
        :lib-extractor:assembleRelease \
        :lib-transformer:assembleRelease \
        :lib-decoder:assembleRelease \
        :lib-database:assembleRelease \
        :lib-container:assembleRelease \
    || exit 1

publish_library "lib-exoplayer-hls"
publish_library "lib-exoplayer"
publish_library "lib-common"
publish_library "lib-exoplayer-dash"
publish_library "lib-exoplayer-ima"
publish_library "lib-exoplayer-smoothstreaming"
publish_library "lib-ui"
publish_library "lib-cast"
publish_library "lib-datasource"
publish_library "lib-datasource-okhttp"
publish_library "lib-database"
publish_library "lib-decoder"
publish_library "lib-container"
publish_library "lib-extractor"
