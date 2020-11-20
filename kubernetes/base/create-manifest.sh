#!/bin/bash -x

set -eo pipefail

cat namespace.yaml \
    pvc.yaml \
    configMap.yaml \
    secrets.yaml \
    networkDashboard.yaml \
    raspberryDashboard.yaml \
    pdb.yaml \
    daemonSet.yaml \
    services.yaml \
    deployment.yaml \
    cronJob.yaml > ../ISP-Checker-deploy.yaml

sha512sum --tag ../ISP-Checker-deploy.yaml > ../ISP-Checker-deploy.SHA512
md5sum --tag ../ISP-Checker-deploy.yaml > ../ISP-Checker-deploy.MD5

exit $?
