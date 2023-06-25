# odoo-13-base docker image

Based on odoo:13.0 with some addition in environment

* Docker hub: https://hub.docker.com/repository/docker/nothingctrl/odoo-13-base/general
* Github: https://github.com/nothingctrl/odoo-13-base

### GIT & Docker Build - Push

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

```
#!/bin/bash
VERSION=123
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