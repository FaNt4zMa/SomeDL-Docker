# SomeDL Docker

> **Unofficial third-party image.** Not affiliated with or maintained by the SomeDL developer. Use at your own risk.

A Docker image for [SomeDL](https://github.com/ChemistryGull/SomeDL) — download music from YouTube with rich metadata, no API tokens or login required. The container starts the WebUI automatically, so everything — downloads, settings, search — is accessible from your browser.

## Quick Start

1. Replace `/path/to/config` and `/path/to/music` with real paths on your host.
2. Set `PUID`/`PGID` to your host user's IDs (run `id` in your terminal to find them).

```yaml
services:
  somedl:
    image: ghcr.io/fant4zma/somedl:latest
    container_name: somedl
    environment:
      - PUID=1000
      - PGID=1000
    ports:
      - "5000:5000"
    volumes:
      - /path/to/config:/config/SomeDL
      - /path/to/music:/downloads
    restart: unless-stopped
```

```bash
docker compose up -d
```

Open **http://localhost:5000** in your browser.

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PUID` | `1000` | User ID the process runs as. Should match your host user to avoid permission issues on bind mounts. |
| `PGID` | `1000` | Group ID the process runs as. Should match your host user's group. |

> The container runs as a non-root user. `PUID` and `PGID` control which user that is at runtime.

## Volumes

| Mount point | Purpose |
|-------------|---------|
| `/config/SomeDL` | SomeDL configuration and settings. |
| `/downloads` | Downloaded music output directory. |

## Tags

| Tag | Description |
|-----|-------------|
| `latest` | Most recent SomeDL release. Rebuilt automatically when a new version is published to PyPI. |
| `1.5.0`, `1.5.1`, … | Pinned to a specific SomeDL version. Available from 1.5.0 onwards. |

## Updating

Pull the new image and recreate the container — your config and downloads are safe in the volumes.

```bash
docker compose pull && docker compose up -d
```

## License

This image configuration is [GPL-3.0](LICENSE.md).