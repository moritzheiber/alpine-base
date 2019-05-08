FROM alpine:3.9.3
LABEL maintainer="Moritz Heiber <hello@heiber.im>"

ENV ENVCONSUL_VERSION="0.7.3" \
  CONSUL_TEMPLATE_VERSION="0.19.5" \
  ENVCONSUL_SHA256="67ed44cb254da24ca5156ada6d04e3cfeba248ca0c50a5ddd42282cbafde80bc" \
  CONSUL_TEMPLATE_SHA256="e6b376701708b901b0548490e296739aedd1c19423c386eb0b01cfad152162af"

RUN apk --no-cache upgrade && \
  apk --no-cache add curl ca-certificates && \
  curl -o /tmp/envconsul.zip -L https://releases.hashicorp.com/envconsul/${ENVCONSUL_VERSION}/envconsul_${ENVCONSUL_VERSION}_linux_amd64.zip && \
  echo "${ENVCONSUL_SHA256}  /tmp/envconsul.zip" | sha256sum -c && \
  unzip /tmp/envconsul.zip -d /usr/bin/ && \
  curl -o /tmp/consul-template.zip -L https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
  echo "${CONSUL_TEMPLATE_SHA256}  /tmp/consul-template.zip" | sha256sum -c && \
  unzip /tmp/consul-template.zip -d /usr/bin/ && \
  rm -f /tmp/envconsul.zip /tmp/consul-template.zip && \
  apk --no-cache del --purge curl
