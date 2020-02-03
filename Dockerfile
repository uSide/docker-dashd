FROM debian:stable-slim

ENV DASH_VERSION=0.14.0
ENV DASH_MINOR_VERSION=5
ENV DASH_CHECKSUM=c40f579d30f523bf0d220e4c02ed58075cf2bd4ed9a9c73e72ac2b7420728f6a

RUN apt-get update && apt-get install -y wget && apt-get clean
RUN wget https://github.com/dashpay/dash/releases/download/v${DASH_VERSION}.${DASH_MINOR_VERSION}/dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz \
    && echo "${DASH_CHECKSUM} dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz" | sha256sum -c \
    && tar -xzf dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz \
    && cp dashcore-${DASH_VERSION}/bin/dashd /usr/local/bin \
    && rm -rf dashcore-${DASH_VERSION} *.tar.gz

ENTRYPOINT ["/usr/local/bin/dashd"]