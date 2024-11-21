# bash:latest is a small apline based image that contains bash
# hadolint ignore=DL3007
FROM bash:latest

# hadolint ignore=DL3018
RUN apk add --no-cache curl jq kubectl

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY kubestarter.sh .

RUN chmod +x kubestarter.sh

USER appuser

CMD ["/usr/local/bin/bash", "/app/kubestarter.sh"]