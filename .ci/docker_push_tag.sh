#!/bin/bash
docker tag gitpages craftingit/gitpages:$TRAVIS_TAG

if [ ! "$TRAVIS_TAG" == "dev" ];
then
    docker tag gitpages craftingit/gitpages:latest
fi

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push craftingit/gitpages