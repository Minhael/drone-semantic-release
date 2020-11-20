#! /bin/sh

# Semantic-release CI Configuration
# https://github.com/entwico/semantic-release-drone/blob/master/release.sh
export GH_TOKEN=${PLUGIN_GITHUB_TOKEN:-}
export GL_TOKEN=${PLUGIN_GITLAB_TOKEN:-}
export BB_TOKEN=${PLUGIN_BITBUCKET_TOKEN:-}
export GIT_CREDENTIALS=$(node /opt/create-credentials.js)

# Set GIT credentials
# https://github.com/cenk1cenk2/drone-semantic-release/blob/master/release.sh
git config --global credential.helper "!f() { echo 'username=${PLUGIN_GIT_LOGIN}'; echo 'password=${PLUGIN_GIT_PASSWORD}'; }; f"

# Run with supplied arguments
semantic-release "$@"