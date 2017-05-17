# hubrel

Ruby gem and Chef cookbook for a highly-opinionated GitHub release workflow.

## Philosophy

### Versioning

We are following [Semantic Versioning](http://semver.org/) with the short git commit hash integrated in the build metadata.

If a version contains multiple releases, they shall be ordered by their short git commit hashes according to the `master` branch.

### Release

For every push to the master branch (usually after a pull request), a build will be executed. On every successful build of the master branch, a tag/release shall be created named `version+commit`. This release will be marked as `prerelease` in GitHub.

Once the developer is happy with a release, the `prerelease` tag may be lifted. It is highly advised to make sure all releases have different versions, and not rely on different commit hashes.

### Example

`master` branch (ordered from latest, descending):

| message               | hash    |
| --------------------- |-------- |
| Merge pull request #3 | 423hgj7 |
| commit                | vnsdh89 |
| commit                | asdflkj |
| Merge pull request #4 | 345ja87 |
| commit                | asdf345 |
| commit                | jlkj987 |

We will take the example of building on every merge to master. For a given version number `1.3.2`, there will be two tags/releases, both tagged as `prerelease`:
 - `1.3.2+423hgj7`
 - `1.3.2+345ja87`

In this case `1.3.2+423hgj7` will take precedence over `1.3.2+345ja87` since it is later in the `master` branch.

## Deployment

Latest `prerelase` should always be deployed to staging.
Latest `release` should always be deployed to production.

## Implementation

The Ruby gem is used to push releases to GitHub, and the Chef cookbook is used to get the release URL from GitHub (the `remote_file` resource should be then used for downloading).

The Ruby gem may also be used to purge old releases.
