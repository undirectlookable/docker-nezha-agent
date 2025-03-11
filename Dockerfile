FROM --platform=${TARGETPLATFORM} alpine AS builder

ARG TARGETPLATFORM
ARG TAG

RUN echo "Building image for $TARGETPLATFORM" && \
    apk add --no-cache curl unzip && \
    ARCH=$(case ${TARGETPLATFORM} in \
        linux/386) echo "386" ;; \
        linux/amd64) echo "amd64" ;; \
        linux/arm/v6) echo "arm" ;; \
        linux/arm/v7) echo "arm" ;; \
        linux/arm64/v8) echo "arm64" ;; \
        *) echo "amd64" ;; \
    esac) && \
    curl -L "https://github.com/nezhahq/agent/releases/download/v${TAG}/nezha-agent_linux_${ARCH}.zip" -o /tmp/nezha-agent.zip && \
    unzip /tmp/nezha-agent.zip -d /tmp && \
    chmod +x /tmp/nezha-agent

FROM --platform=${TARGETPLATFORM} alpine
LABEL maintainer="undirectlookable@users.noreply.github.com"
COPY --from=builder /tmp/nezha-agent /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/nezha-agent"]
CMD ["--config", "/etc/nezha/config.yml"]