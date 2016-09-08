#!/bin/bash

set -xeu

prefix="shield"
infrastructure=warden
NAME=$prefix-$infrastructure

BOSH_STATUS=$(bosh status)
DIRECTOR_UUID=$(echo "$BOSH_STATUS" | grep UUID | awk '{print $2}')
DIRECTOR_CPI=$(echo "$BOSH_STATUS" | grep CPI | awk '{print $2}')
DIRECTOR_NAME=$(echo "$BOSH_STATUS" | grep Name | awk '{print $2}')


templates=$(dirname $0)
release=$templates/..
tmpdir=$release/tmp

mkdir -p $tmpdir

spruce merge \
  $templates/$prefix-deployment.yml \
  $templates/$prefix-jobs.yml \
  $templates/stub.yml \
  $templates/with-example-inputs.yml \
  $* > $tmpdir/$NAME-manifest.yml

bosh deployment $tmpdir/$NAME-manifest.yml
bosh status
