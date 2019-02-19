FROM debian:stable-slim

ENV DASH_VERSION=0.13.1
ENV DASH_CHECKSUM=5ce96dbb8376e99f1e783f4ff77018d562778aac5a1249fbe4f4532c03df6432

RUN apt-get update && apt-get install -y wget && apt-get clean
RUN wget https://github.com/dashpay/dash/releases/download/v${DASH_VERSION}.0/dashcore-${DASH_VERSION}.0-x86_64-linux-gnu.tar.gz \
    && echo "${DASH_CHECKSUM} dashcore-${DASH_VERSION}.0-x86_64-linux-gnu.tar.gz" | sha256sum -c \
    && tar -xzf dashcore-${DASH_VERSION}.0-x86_64-linux-gnu.tar.gz \
    && cp dashcore-${DASH_VERSION}/bin/dashd /usr/local/bin \
    && rm -rf dashcore-${DASH_VERSION} *.tar.gz

ENTRYPOINT ["/usr/local/bin/dashd"]