FROM alpine:3.11.0
LABEL maintainer="Moritz Heiber <hello@heiber.im>"

ARG ENVCONSUL_VERSION="0.7.3"
ARG CONSUL_TEMPLATE_VERSION="0.19.5"
ARG ENVCONSUL_SHA256="67ed44cb254da24ca5156ada6d04e3cfeba248ca0c50a5ddd42282cbafde80bc"
ARG CONSUL_TEMPLATE_SHA256="e6b376701708b901b0548490e296739aedd1c19423c386eb0b01cfad152162af"
ARG GOMPLATE_VERSION="3.4.1"
ARG GOMPLATE_CHECKSUM="bc7c8e8d1ce40a52ea5099b816651159ad685c9bbed24a63c7e5af97f4a2409e"


RUN apk --no-cache upgrade && \
  apk --no-cache add curl ca-certificates && \
  curl -o /tmp/envconsul.zip -L https://releases.hashicorp.com/envconsul/${ENVCONSUL_VERSION}/envconsul_${ENVCONSUL_VERSION}_linux_amd64.zip && \
  echo "${ENVCONSUL_SHA256}  /tmp/envconsul.zip" | sha256sum -c - && \
  unzip /tmp/envconsul.zip -d /usr/bin/ && \
  curl -o /tmp/consul-template.zip -L https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
  echo "${CONSUL_TEMPLATE_SHA256}  /tmp/consul-template.zip" | sha256sum -c - && \
  unzip /tmp/consul-template.zip -d /usr/bin/ && \
  curl -o /usr/bin/gomplate -L https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64-slim && \
  echo "${GOMPLATE_CHECKSUM}  /usr/bin/gomplate" | sha256sum -c - && \
  chmod +x /usr/bin/gomplate && \
  rm -f /tmp/envconsul.zip /tmp/consul-template.zip && \
  apk --no-cache del --purge curl
