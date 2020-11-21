# drone-semantic-release

[Drone plugin](https://docs.drone.io/pipeline/docker/syntax/plugins/) to mark release by tagging versions automatically using [Semantic Release](https://github.com/semantic-release/semantic-release).

This project focuses on minimal functions working on private Drone and generic GIT repository with flexibility to tune semantic-release in project-basis.

# Credits
This project references below projects. Thanks to lework, entwico and cenk1cenk2 for their works on making feature-rich plugins.

* [lework/drone-semantic-release](https://github.com/lework/drone-semantic-release)
* [entwico/semantic-release-drone](https://github.com/entwico/semantic-release-drone)
* [cenk1cenk2/drone-semantic-release](https://github.com/cenk1cenk2/drone-semantic-release)

# Usage
1. Set GIT user account with push permission of `HEAD` branches in Drone pipeline. 
2. Add below step to your Drone pipeline to tag next release version:
```
- name: versioning
  image: [REPO NAME]/drone-semantic-release
  settings:
    git_login:
      from_secret: git_user
    git_password:
      from_secret: git_password
```

# Work between plugins
Version string in [SemVer](https://semver.org/) format is echoed to `.tags` at root of cloned sources during build. For example, you may publish docker image with tagged version by:
```
- name: versioning
  image: [REPO NAME]/drone-semantic-release
  settings:
    git_login:
      from_secret: git_user
    git_password:
      from_secret: git_password

- name: publish
  image: plugins/docker
  settings:
    username:
      from_secret: nexus_user
    password:
      from_secret: nexus_password
    repo: [REPO NAME]/drone-semantic-release
```

# Customizations
To add or override semantic release default settings. Add `.releaserc` to your project root:
```
{
  "branches": [
    "master",
    {
      "name": "rc",
      "prerelease": true
    }
  ]
}
```
Or change commands arguments in the pipeline:
```
- name: versioning
  image: [REPO NAME]/drone-semantic-release
  command: [ "--tagFormat", "${version}", "--dry-run" ]
  settings:
    git_login:
      from_secret: git_user
    git_password:
      from_secret: git_password
```
Please check `index.js` for changes made by the plugin.