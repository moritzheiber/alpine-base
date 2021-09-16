# Alpine base image with envconsul/consul-template

[![build-push](https://github.com/moritzheiber/alpine-base/actions/workflows/build-push.yml/badge.svg)](https://github.com/moritzheiber/alpine-base/actions/workflows/build-push.yml)

A Docker base image which contains [envconsul](https://github.com/hashicorp/envconsul), [consul_template](https://github.com/hashicorp/consul-template) and [gomplate](https://github.com/hairyhenderson/gomplate).

You need `dgoss` (and `goss`) to run the tests against the image:

```console
dgoss run -ti <image-name>
```
