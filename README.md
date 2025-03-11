# Docker nezha-agent

Multi-arch docker image builder for [nezhahq/agent](https://github.com/nezhahq/agent)

https://hub.docker.com/r/undirectlookable/nezha-agent

## Usage

`docker-compose.yml`

```yaml
services:
  app:
    image: undirectlookable/nezha-agent
    network_mode: host
    volumes:
      - ./config.yml:/etc/nezha/config.yml
    restart: unless-stopped
```

`config.yml`

Reference: https://nezha.wiki/configuration/agent.html