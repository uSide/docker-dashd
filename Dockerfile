FROM debian:stable-slim

ENV DASH_VERSION=0.14.0
ENV DASH_MINOR_VERSION=2
ENV DASH_CHECKSUM=00482c0e2b861d0af042a695d8f6f2bafada0e6df036482d43ba36d51cf2464b

RUN apt-get update && apt-get install -y wget && apt-get clean
RUN wget https://github.com/dashpay/dash/releases/download/v${DASH_VERSION}.${DASH_MINOR_VERSION}/dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz \
    && echo "${DASH_CHECKSUM} dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz" | sha256sum -c \
    && tar -xzf dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz \
    && cp dashcore-${DASH_VERSION}/bin/dashd /usr/local/bin \
    && rm -rf dashcore-${DASH_VERSION} *.tar.gz

ENTRYPOINT ["/usr/local/bin/dashd"]