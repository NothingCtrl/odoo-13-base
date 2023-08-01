# odoo-13-base docker image

Based on odoo:13.0 with some addition in environment

* Docker hub: https://hub.docker.com/repository/docker/nothingctrl/odoo-13-base/general
* Github: https://github.com/nothingctrl/odoo-13-base

## Important note for Docker Hub

* Image version `2.1.3` is the latest image with all source come from docker hub of [odoo:13 official](https://hub.docker.com/layers/library/odoo), the odoo source code of this build may not up-to-date
* Image version `3.x.x` is the new build with odoo source (and its native addons) come from [github odoo:13.0](https://github.com/odoo/odoo/tree/13.0), so it more up-to-date than the 2.x.x version (exclude [themes addons](https://github.com/odoo/design-themes))
  * It's required available `odoo` folder clone from repository `odoo:13.0`
* Image version `4.x.x` is the new build with odoo source come from [package release](https://nightly.odoo.com/13.0/nightly/deb/) and [original build script](https://github.com/odoo/docker/blob/26df6d6eef8df7a9927fbdade79772455de7e8eb/13.0/Dockerfile), this is the closest version with official build with up-to-date source code
  * Check note in `DockerfileFull` for detail how to update to new release

### Example usage

* Create your `Dockerfile`
  ```Dockerfile
  FROM nothingctrl/odoo-13-base:2.1.3
  # MAINTAINER name@foo.bar
  # add your custom addon(s)
  COPY addons/ /mnt/extra-addons/
  EXPOSE 8069
  ``` 
* Build and run: 
  ```cmd
  # run database container
  docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name demo-db postgres:15
  # build and run odoo container
  docker build --tag local/demo-odoo-image .
  docker run --rm -p 8069:8069 --name=demo-odoo-cont --link demo-db:db -t local/demo-odoo-image
  ```

### GIT & Docker Build - Push

* _Windows_ scripts, usage: `/path/to/script_file.bat 1.2.3` → commit, tag and build version 1.2.3
```
@echo OFF
rem Windows CMD
set version=%1
git add .
git commit -m "Update version %version%"
git tag %version%
git push && git push --tag
docker build . -t nothingctrl/odoo-13-base:%version%
docker push nothingctrl/odoo-13-base:%version%
docker tag nothingctrl/odoo-13-base:%version% nothingctrl/odoo-13-base:latest
docker push nothingctrl/odoo-13-base
```

* _Linux_ scripts, usage: _same as Windows_
```
#!/bin/bash
VERSION=$(($1))
git add .
git commit -m "Update version $VERSION"
git tag $VERSION
git push && git push --tag
docker build . -t nothingctrl/odoo-13-base:$VERSION
docker push nothingctrl/odoo-13-base:$VERSION
docker tag nothingctrl/odoo-13-base:%version% nothingctrl/odoo-13-base:latest
docker push nothingctrl/odoo-13-base
```

### Notes

* `locale_issue_61923` fix missing locale file [issue 61923](https://github.com/odoo/odoo/issues/61923)
* `patch/odoo/odoo/netsvc.py` fix logging in Google Cloud Kubernetes multi instance