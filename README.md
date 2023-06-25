# odoo-13-base docker image

Based on odoo:13.0 with some addition in environment

* Docker hub: https://hub.docker.com/repository/docker/nothingctrl/odoo-13-base/general
* Github: https://github.com/nothingctrl/odoo-13-base

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
docker push nothingctrl/odoo-13-base
```

### Notes

* `locale_issue_61923` fix missing locale file [issue 61923](https://github.com/odoo/odoo/issues/61923)
* `patch/odoo/odoo/netsvc.py` fix logging in Google Cloud Kubernetes multi instance