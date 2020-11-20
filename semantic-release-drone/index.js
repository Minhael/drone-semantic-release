module.exports = {
    plugins: [
        '@semantic-release/commit-analyzer',
        '@semantic-release/release-notes-generator',
        [
            '@semantic-release/changelog',
            {
                "changelogFile": "CHANGELOG.md"
            }
        ],
        [
            '@semantic-release/exec',
            {
                "prepareCmd": "echo -n \"${nextRelease.version}\" > .tags"
            }
        ],
        [
            '@semantic-release/git',
            {
                "assets": [
                    "CHANGELOG.md"
                ],
                "message": "chore(release): ${nextRelease.version} [ci skip]\n\n${nextRelease.notes}"
            }
        ]
    ]
}