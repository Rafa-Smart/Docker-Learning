# ============================================================
# DOCKER BUILD CHEAT SHEET
# Dockerfile + Docker Build + Docker Compose Build
# ============================================================

# ============================================================
# BAGIAN 1 - KONSEP DASAR
# ============================================================

# Dockerfile
#
# Berisi instruksi untuk membuat image.
#
# Contoh:
#
# FROM node:22-alpine
# WORKDIR /app
# COPY . .
# RUN npm install
# CMD ["npm", "start"]
#
# Setelah Dockerfile dibuat:
#
# docker build -t myapp .
#
# Docker akan:
# 1. Membaca Dockerfile
# 2. Menjalankan setiap instruksi
# 3. Membuat image baru
#
# Hasil:
#
# myapp:latest


# ============================================================
# BAGIAN 2 - DOCKER BUILD
# ============================================================

# Build image dari Dockerfile

docker build -t myapp .

Penjelasan:
- -t = tag image
- myapp = nama image
- . = build context


# ------------------------------------------------------------

docker build .

Penjelasan:
- Build tanpa nama image.
- Docker membuat image ID saja.


# ------------------------------------------------------------

docker build -t myapp:v1 .

Penjelasan:
- Membuat image dengan tag v1


# ------------------------------------------------------------

docker build -t myapp:latest .

Penjelasan:
- Tag latest


# ============================================================
# BAGIAN 3 - BUILD CONTEXT
# ============================================================

docker build .

Penjelasan:
- "." = seluruh folder saat ini
- Semua file dalam folder bisa diakses oleh Dockerfile


# ------------------------------------------------------------

docker build ./backend

Penjelasan:
- Build context = folder backend


# ------------------------------------------------------------

docker build /home/user/project

Penjelasan:
- Build context = path absolut


# ============================================================
# BAGIAN 4 - DOCKERFILE CUSTOM
# ============================================================

docker build -f Dockerfile.dev .

Penjelasan:
- Menggunakan Dockerfile.dev


# ------------------------------------------------------------

docker build -f docker/prod.Dockerfile .

Penjelasan:
- Dockerfile berada di folder lain


# ------------------------------------------------------------

docker build \
-f Dockerfile.prod \
-t myapp:prod \
.

Penjelasan:
- Build image production


# ============================================================
# BAGIAN 5 - BUILD ARG
# ============================================================

docker build \
--build-arg VERSION=1.0 \
.

Penjelasan:
- Mengirim nilai ke ARG Dockerfile


# Dockerfile

ARG VERSION
RUN echo $VERSION


# ------------------------------------------------------------

docker build \
--build-arg APP_ENV=production \
.

Penjelasan:
- Build argument APP_ENV


# Multiple ARG

docker build \
--build-arg APP_ENV=production \
--build-arg VERSION=1.0 \
.

Penjelasan:
- Mengirim banyak ARG


# ============================================================
# BAGIAN 6 - NO CACHE
# ============================================================

docker build --no-cache .

Penjelasan:
- Paksa build ulang
- Tidak menggunakan cache layer


# ------------------------------------------------------------

docker build \
--no-cache \
-t myapp \
.

Penjelasan:
- Full rebuild


# ============================================================
# BAGIAN 7 - PULL BASE IMAGE TERBARU
# ============================================================

docker build --pull .

Penjelasan:
- Selalu pull image terbaru
- Walaupun image sudah ada lokal


# ------------------------------------------------------------

docker build \
--pull \
-t myapp \
.

Penjelasan:
- Update base image sebelum build


# ============================================================
# BAGIAN 8 - TARGET MULTI STAGE BUILD
# ============================================================

docker build \
--target builder \
.

Penjelasan:
- Hanya build stage builder


# Dockerfile

FROM golang AS builder
RUN go build

FROM alpine
COPY --from=builder /app .


# ------------------------------------------------------------

docker build \
--target production \
.

Penjelasan:
- Build stage production saja


# ============================================================
# BAGIAN 9 - PLATFORM BUILD
# ============================================================

docker build \
--platform linux/amd64 \
.

Penjelasan:
- Build untuk AMD64


# ------------------------------------------------------------

docker build \
--platform linux/arm64 \
.

Penjelasan:
- Build untuk ARM64


# ------------------------------------------------------------

docker build \
--platform linux/amd64,linux/arm64 \
.

Penjelasan:
- Multi-platform build
- Biasanya menggunakan buildx


# ============================================================
# BAGIAN 10 - TAGGING
# ============================================================

docker build \
-t myapp:v1 \
-t myapp:latest \
.

Penjelasan:
- Satu build
- Banyak tag


# ============================================================
# BAGIAN 11 - COMPOSE BUILD DASAR
# ============================================================

services:
  app:
    build: .

Penjelasan:
- Build context = folder saat ini
- Dockerfile default


# ------------------------------------------------------------

services:
  app:
    build: ./backend

Penjelasan:
- Build dari folder backend


# ============================================================
# BAGIAN 12 - BUILD OBJECT
# ============================================================

services:
  app:
    build:
      context: .

Penjelasan:
- Bentuk lengkap build


# ============================================================
# BAGIAN 13 - CONTEXT
# ============================================================

services:
  app:
    build:
      context: .

Penjelasan:
- Folder project saat ini


# ------------------------------------------------------------

services:
  app:
    build:
      context: ./backend

Penjelasan:
- Folder backend sebagai context


# ============================================================
# BAGIAN 14 - DOCKERFILE
# ============================================================

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.prod

Penjelasan:
- Menggunakan Dockerfile.prod


# ------------------------------------------------------------

services:
  app:
    build:
      context: .
      dockerfile: docker/prod.Dockerfile

Penjelasan:
- Dockerfile dalam folder lain


# ============================================================
# BAGIAN 15 - DOCKERFILE_INLINE
# ============================================================

services:
  app:
    build:
      context: .
      dockerfile_inline: |
        FROM alpine
        RUN echo hello

Penjelasan:
- Dockerfile langsung ditulis di compose
- Tidak memerlukan file Dockerfile terpisah

# NOTE:
# Tidak boleh memakai:
#
# dockerfile:
# dockerfile_inline:
#
# secara bersamaan.


# ============================================================
# BAGIAN 16 - ARGS
# ============================================================

services:
  app:
    build:
      context: .
      args:
        APP_ENV: production
        VERSION: "1.0"

Penjelasan:
- Mengirim build arguments


# Bentuk list

services:
  app:
    build:
      context: .
      args:
        - APP_ENV=production
        - VERSION=1.0


# ============================================================
# BAGIAN 17 - TARGET
# ============================================================

services:
  app:
    build:
      context: .
      target: production

Penjelasan:
- Build stage production


# ============================================================
# BAGIAN 18 - CACHE_FROM
# ============================================================

services:
  app:
    build:
      context: .
      cache_from:
        - myapp:latest

Penjelasan:
- Menggunakan cache dari image lama
- Sangat berguna di CI/CD


# ------------------------------------------------------------

cache_from:
  - type=local,src=./cache

Penjelasan:
- Menggunakan cache lokal


# ------------------------------------------------------------

cache_from:
  - type=gha

Penjelasan:
- Cache GitHub Actions


# ============================================================
# BAGIAN 19 - CACHE_TO
# ============================================================

services:
  app:
    build:
      context: .
      cache_to:
        - type=local,dest=./cache

Penjelasan:
- Menyimpan cache build


# ------------------------------------------------------------

cache_to:
  - myapp:cache

Penjelasan:
- Simpan cache ke registry


# ============================================================
# BAGIAN 20 - NO CACHE
# ============================================================

services:
  app:
    build:
      context: .
      no_cache: true

Penjelasan:
- Paksa build ulang semua layer


# ============================================================
# BAGIAN 21 - PULL
# ============================================================

services:
  app:
    build:
      context: .
      pull: true

Penjelasan:
- Selalu pull image terbaru untuk FROM


# ============================================================
# BAGIAN 22 - PLATFORMS
# ============================================================

services:
  app:
    build:
      context: .
      platforms:
        - linux/amd64
        - linux/arm64

Penjelasan:
- Multi-platform image


# ============================================================
# BAGIAN 23 - TAGS
# ============================================================

services:
  app:
    image: myapp

    build:
      context: .
      tags:
        - myapp:v1
        - myapp:latest

Penjelasan:
- Menambahkan tag tambahan


# ============================================================
# BAGIAN 24 - ADDITIONAL_CONTEXTS
# ============================================================

services:
  app:
    build:
      context: .
      additional_contexts:
        resources: ./resources

Penjelasan:
- Menambahkan context tambahan


# ------------------------------------------------------------

additional_contexts:
  source: https://github.com/user/project.git

Penjelasan:
- Context dari repository Git


# ------------------------------------------------------------

additional_contexts:
  app: docker-image://nginx:latest

Penjelasan:
- Context dari image Docker lain


# ============================================================
# BAGIAN 25 - SSH
# ============================================================

services:
  app:
    build:
      context: .
      ssh:
        - default

Penjelasan:
- Menggunakan SSH agent host
- Cocok untuk clone private repository


# ============================================================
# BAGIAN 26 - SECRETS
# ============================================================

services:
  app:
    build:
      context: .
      secrets:
        - npm_token

Penjelasan:
- Secret hanya tersedia saat build
- Tidak masuk image final


# ============================================================
# BAGIAN 27 - SHM_SIZE
# ============================================================

services:
  app:
    build:
      context: .
      shm_size: 2gb

Penjelasan:
- Shared memory build container
- Berguna untuk Chrome/Puppeteer


# ============================================================
# BAGIAN 28 - PRIVILEGED
# ============================================================

services:
  app:
    build:
      context: .
      privileged: true

Penjelasan:
- Build dengan privilege tinggi


# ============================================================
# BAGIAN 29 - PROVENANCE
# ============================================================

services:
  app:
    build:
      context: .
      provenance: true

Penjelasan:
- Menambahkan build provenance metadata


# ------------------------------------------------------------

provenance: mode=max

Penjelasan:
- Metadata provenance lebih detail


# ============================================================
# BAGIAN 30 - SBOM
# ============================================================

services:
  app:
    build:
      context: .
      sbom: true

Penjelasan:
- Generate Software Bill of Materials


# ============================================================
# BAGIAN 31 - DOCKER COMPOSE BUILD COMMAND
# ============================================================

docker compose build

Penjelasan:
- Build semua service


# ------------------------------------------------------------

docker compose build app

Penjelasan:
- Build service app saja


# ------------------------------------------------------------

docker compose build --no-cache

Penjelasan:
- Build tanpa cache


# ------------------------------------------------------------

docker compose build --pull

Penjelasan:
- Pull image terbaru


# ------------------------------------------------------------

docker compose build --push

Penjelasan:
- Build lalu push image


# ------------------------------------------------------------

docker compose build --with-dependencies

Penjelasan:
- Build service beserta dependency


# ------------------------------------------------------------

docker compose build --check

Penjelasan:
- Validasi konfigurasi build


# ------------------------------------------------------------

docker compose build --provenance

Penjelasan:
- Tambahkan provenance attestation


# ------------------------------------------------------------

docker compose build --sbom

Penjelasan:
- Generate SBOM


# ============================================================
# BEST PRACTICE PRODUCTION
# ============================================================

services:
  app:
    image: mycompany/app:latest

    build:
      context: .
      dockerfile: Dockerfile
      target: production
      pull: true

      args:
        APP_ENV: production

      cache_from:
        - mycompany/app:latest

      cache_to:
        - type=local,dest=.build-cache

      platforms:
        - linux/amd64

Penjelasan:
- Menggunakan cache
- Pull image terbaru
- Multi-stage build
- Production target
- Siap CI/CD
