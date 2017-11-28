## How to contribute to Hyperterm

### Getting Started

* Make sure you have a [GitHub account](https://github.com/signup/free/)
* Follow the [quickstart guide](https://github.com/mikeanthonywild/hyperterm-hardware/blob/master/README.md) to get a development environment set up
* Read through the [documentation](https://mikeanthonywild.github.io/hyperterm-hardware/)

### Development Workflow

Development is largely based on the [GitHub fork and PR model](https://help.github.com/articles/about-collaborative-development-models/). If you are not familiar with this workflow then it is essential that you read through and understand it first. We focus heavily on automation and [Continuous Integration](https://en.wikipedia.org/wiki/Continuous_integration) in order to maximise test coverage and productivity.

#### Continuous Integration

All PRs are automatically tested by [Travis](https://travis-ci.org/mikeanthonywild/hyperterm-hardware). When a build is tagged

For further details see the documentation (TODO – see [#6](https://github.com/mikeanthonywild/hyperterm-hardware/issues/6)). 

#### Versioning and Release Process

TBC

#### Submitting Changes

1. Create a fork of the main Hyperterm repo.
2. Create an issue for the unit of work if there isn't one already.
3. Create a feature branch for the task – reference the issue number in the branch name (e.g. `issue_23_add_some_new_feature`).
4. Make your changes.
5. Test your changes locally (`make test`). 
6. Commit your changes following the [commit best practices](https://git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project).
  - Commits should reference the GitHub issue number (e.g. `Fix bug caused by something; fixes #23`).
  - Squash commits before raising a PR.
  - All commits should pass tests to aid with `git bisect`.
7. Raise a PR, but only once it is tested and you are sure it is ready for merging. You should not rely on the PR mechanism for building / testing your changes as this creates unnecessary noise.
8. Take on board any feedback and make changes if necessary.
9. Once everyone is happy the PR can finally be merged!

### Additional Resources

* [IRC channel (#hyperterm-dev on Freenode)](https://webchat.freenode.net/?channels=hyperterm-dev)
