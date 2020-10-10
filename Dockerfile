FROM debian:stable-slim

ENV DASH_VERSION=0.16.0
ENV DASH_MINOR_VERSION=1
ENV DASH_CHECKSUM=d1cfa14ee614872d21956f4fc6648969049a9354cf638efcf69916c0b6465346

RUN apt-get update && apt-get install -y wget && apt-get clean
RUN wget https://github.com/dashpay/dash/releases/download/v${DASH_VERSION}.${DASH_MINOR_VERSION}/dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz \
    && echo "${DASH_CHECKSUM} dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz" | sha256sum -c \
    && tar -xzf dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz \
    && cp dashcore-${DASH_VERSION}/bin/dashd /usr/local/bin \
    && rm -rf dashcore-${DASH_VERSION} *.tar.gz

ENTRYPOINT ["/usr/local/bin/dashd"]