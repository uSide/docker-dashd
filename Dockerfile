FROM debian:stable-slim

ENV DASH_VERSION=0.15.0
ENV DASH_MINOR_VERSION=0
ENV DASH_CHECKSUM=4cc0815ebd595f3d0134a8df9e6224cbe3d79398a5a899b60ca5f4ab8a576160

RUN apt-get update && apt-get install -y wget && apt-get clean
RUN wget https://github.com/dashpay/dash/releases/download/v${DASH_VERSION}.${DASH_MINOR_VERSION}/dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz \
    && echo "${DASH_CHECKSUM} dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz" | sha256sum -c \
    && tar -xzf dashcore-${DASH_VERSION}.${DASH_MINOR_VERSION}-x86_64-linux-gnu.tar.gz \
    && cp dashcore-${DASH_VERSION}/bin/dashd /usr/local/bin \
    && rm -rf dashcore-${DASH_VERSION} *.tar.gz

ENTRYPOINT ["/usr/local/bin/dashd"]