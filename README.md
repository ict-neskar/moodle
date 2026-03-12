# Moodle — SMKN 1 Karawang

Docker image for the Moodle LMS deployment at [smkn1karawang.sch.id](https://smkn1karawang.sch.id).

## Stack

| Component | Details |
|-----------|---------|
| Base image | `serversideup/php:8.4-fpm-nginx-debian` |
| Moodle | `MOODLE_500_STABLE` |
| Database | PostgreSQL 18 |
| Timezone | `Asia/Jakarta` |

## Container Image

The image is available on the GitHub Container Registry:

```
ghcr.io/ict-neskar/moodle:latest
```

Pull it directly:

```bash
docker pull ghcr.io/ict-neskar/moodle:latest
```

## Requirements

- Docker & Docker Compose

## Getting Started

1. Copy the environment file and adjust values:

   ```bash
   cp .env.example .env
   ```

2. Build and start the containers:

   ```bash
   docker compose up -d --build
   ```

3. Open [http://localhost:8080](http://localhost:8080) in your browser.

## Environment Variables

Configure the application via the `.env` file. Key variables:

| Variable | Description |
|----------|-------------|
| `MOODLE_WWWROOT` | Public URL of the Moodle site |
| `MOODLE_DBHOST` | Database host |
| `MOODLE_DBNAME` | Database name |
| `MOODLE_DBUSER` | Database user |
| `MOODLE_DBPASS` | Database password |

## Volumes

| Path | Description |
|------|-------------|
| `./data` | Moodle data directory (`moodledata`) |
| `db_data` | PostgreSQL data (named volume) |

## PHP Configuration

Custom PHP settings are applied via `/usr/local/etc/php/conf.d/moodle.ini`:

- `max_input_vars = 5000`
- `date.timezone = Asia/Jakarta`
- `post_max_size = 512M`
- `upload_max_filesize = 512M`
