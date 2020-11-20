# Build Semantic Release plugin for Drone
FROM node:15.1.0-alpine3.12 as build-env
WORKDIR /semantic-release-drone
COPY ./semantic-release-drone ./
RUN npm pack

# Build Drone plugin running Semantic Release
FROM node:15.1.0-alpine3.12

# Where to store scripts
WORKDIR /opt

# Install git
RUN apk update && apk add git

# Install plugin for Drone with all Semantic Release dependencies
COPY --from=build-env /semantic-release-drone/semantic-release-drone-1.0.0.tgz .
RUN npm install --global semantic-release-drone-1.0.0.tgz
RUN rm -f semantic-release-drone-1.0.0.tgz

# Suppress NPM ERR when returning error exit code
RUN mkdir -p /usr/local/etc
RUN echo "loglevel=silent" > /usr/local/etc/npmrc

# Add entrypoint
COPY docker-entrypoint.sh create-credentials.js ./
RUN chmod +x docker-entrypoint.sh

# Mocking Drone mounting folder
WORKDIR /drone/src

ENTRYPOINT [ "/opt/docker-entrypoint.sh" ]
CMD [ "-e", "semantic-release-drone" ]