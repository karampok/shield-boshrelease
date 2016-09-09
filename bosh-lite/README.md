# Running SHIELD with MariaDB in Bosh-lite

## Tutorial

* Bring up a [bosh-lite director](https://github.com/cloudfoundry/bosh-lite) and upload a stemcell if not exist
* Update the cloud-config in bosh-lite

  ```
  bosh update cloud-config bosh-lite/cloudconfig-warden.yml
  ```

  or merge on an existing one

  ```
  bosh cloud-config > /tmp/current-cc
  spruce merge /tmp/current bosh-lite/cloudconfig-warden.yml  > /tmp/new-cc
  bosh update cloud-config /tmp/new-cc
  rm /tmp/new-cc /tmp/current-cc
  ```
* Create and upload the SHIELD release
  ```
  bosh create release --force && bosh -n upload release
  ```

* Modify the `bosh-lite/[stub.yml|with-example-inputs.yml]` accordingly

* Create the warden deployment manifest
  ```
  ./bosh-lite/make-manifest.sh
  ```

* Deploy
  ```
    bosh -n deploy
  ```

* Visit https://10.244.20.20
