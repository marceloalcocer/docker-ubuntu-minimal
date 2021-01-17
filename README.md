# Ubuntu Desktop minimal install Dockerfiles

Dockerfiles for Ubuntu Desktop minimal installation images. These are mainly intended for upgrade related testing, e.g.:

* Backup recovery
* Automated system configuration

The Dockerfiles are contained in individual branches for each Ubuntu release.

## Contents

Images include;

* Subset of packages included in minimial installation
* Primary user and group
  * User name can be set at build time via `USERNAME` argument
  * User ID can be set at build time via `USERID` argument
* Primary user home directory structure

See [Dockerfile](Dockerfile) for full details.

A [makefile](makefile) is also included to aid building and running the image.

