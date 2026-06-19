# ============================================================
# DOCKER CUSTOM DOCKERFILE (-f)
# COMPLETE CHEAT SHEET
# ============================================================

# ============================================================
# APA ITU -f ?
# ============================================================

# Secara default Docker mencari file:

Dockerfile

# Contoh:

project/
│
├── Dockerfile
│
└── app.js

# Maka build biasa:

docker build -t myapp .

# Docker otomatis memakai:

Dockerfile


# ============================================================
# KENAPA MENGGUNAKAN -f ?
# ============================================================

# Karena seringkali kita punya banyak environment:

Dockerfile.dev
Dockerfile.local
Dockerfile.staging
Dockerfile.preview
Dockerfile.test
Dockerfile.production

# Masing-masing mempunyai konfigurasi berbeda.

Contoh:

Development
- Hot Reload
- Debug Mode
- Source Mounted

Production
- Optimized Build
- Security Hardening
- Smaller Image

Preview
- Testing sebelum Production

Staging
- Mirip Production
- Untuk QA Team

Testing
- Unit Test
- Integration Test


# ============================================================
# STRUKTUR PROJECT UMUM
# ============================================================

project/

├── Dockerfile
├── Dockerfile.dev
├── Dockerfile.local
├── Dockerfile.preview
├── Dockerfile.staging
├── Dockerfile.prod
│
├── src/
└── docker/

# Semua bisa dipilih menggunakan -f


# ============================================================
# BASIC -f
# ============================================================

docker build \
-f Dockerfile.dev \
-t myapp:dev \
.

Penjelasan:
- Menggunakan Dockerfile.dev
- Context tetap folder saat ini


# ============================================================
# PRODUCTION BUILD
# ============================================================

docker build \
-f Dockerfile.prod \
-t myapp:prod \
.

Penjelasan:
- Menggunakan Dockerfile production
- Biasanya image lebih kecil


# ============================================================
# LOCAL BUILD
# ============================================================

docker build \
-f Dockerfile.local \
-t myapp:local \
.

Penjelasan:
- Untuk development lokal


# ============================================================
# STAGING BUILD
# ============================================================

docker build \
-f Dockerfile.staging \
-t myapp:staging \
.

Penjelasan:
- Untuk server staging


# ============================================================
# PREVIEW BUILD
# ============================================================

docker build \
-f Dockerfile.preview \
-t myapp:preview \
.

Penjelasan:
- Untuk preview deployment


# ============================================================
# TEST BUILD
# ============================================================

docker build \
-f Dockerfile.test \
-t myapp:test \
.

Penjelasan:
- Untuk testing pipeline


# ============================================================
# DOCKERFILE DALAM FOLDER LAIN
# ============================================================

docker build \
-f docker/Dockerfile.prod \
-t myapp:prod \
.

Penjelasan:
- Dockerfile berada di folder docker/


# ============================================================
# ABSOLUTE PATH
# ============================================================

docker build \
-f /home/rafa/docker/Dockerfile.prod \
-t myapp \
.

Penjelasan:
- Menggunakan path absolut


# ============================================================
# BUILD CONTEXT TETAP PENTING
# ============================================================

docker build \
-f docker/Dockerfile.prod \
.

Penjelasan:
- "." tetap build context
- COPY dan ADD mengambil file dari sini

PENTING:
-f ≠ build context


# ============================================================
# SALAH YANG SERING TERJADI
# ============================================================

docker build \
-f Dockerfile.prod

ERROR

Penjelasan:
- Tidak ada build context


# Yang benar:

docker build \
-f Dockerfile.prod \
.

Penjelasan:
- "." wajib ada


# ============================================================
# MULTIPLE TAG
# ============================================================

docker build \
-f Dockerfile.prod \
-t myapp:v1 \
-t myapp:latest \
.

Penjelasan:
- Satu build
- Banyak tag


# ============================================================
# BUILD ARG + CUSTOM DOCKERFILE
# ============================================================

docker build \
-f Dockerfile.prod \
--build-arg APP_ENV=production \
-t myapp \
.

Penjelasan:
- Mengirim ARG ke Dockerfile


# Dockerfile

ARG APP_ENV

RUN echo $APP_ENV


# ============================================================
# NO CACHE + CUSTOM DOCKERFILE
# ============================================================

docker build \
-f Dockerfile.prod \
--no-cache \
-t myapp \
.

Penjelasan:
- Tidak menggunakan cache


# ============================================================
# PULL BASE IMAGE TERBARU
# ============================================================

docker build \
-f Dockerfile.prod \
--pull \
-t myapp \
.

Penjelasan:
- Selalu pull image terbaru


# ============================================================
# PLATFORM BUILD
# ============================================================

docker build \
-f Dockerfile.prod \
--platform linux/amd64 \
-t myapp \
.

Penjelasan:
- Build untuk AMD64


# ------------------------------------------------------------

docker build \
-f Dockerfile.prod \
--platform linux/arm64 \
-t myapp \
.

Penjelasan:
- Build untuk ARM64


# ============================================================
# MULTI STAGE + TARGET
# ============================================================

docker build \
-f Dockerfile.prod \
--target production \
-t myapp \
.

Penjelasan:
- Build stage production saja


# Dockerfile

FROM node:22 AS builder

RUN npm install

FROM nginx AS production

COPY --from=builder /app .


# ============================================================
# BUILDX + CUSTOM DOCKERFILE
# ============================================================

docker buildx build \
-f Dockerfile.prod \
-t myapp \
.

Penjelasan:
- Build menggunakan Buildx


# ============================================================
# BUILDX MULTI ARCHITECTURE
# ============================================================

docker buildx build \
-f Dockerfile.prod \
--platform linux/amd64,linux/arm64 \
-t myapp \
.

Penjelasan:
- Multi architecture build


# ============================================================
# COMPOSE VERSION
# ============================================================

services:

  app:

    build:
      context: .
      dockerfile: Dockerfile.prod

Penjelasan:
- Sama seperti:
#
# docker build -f Dockerfile.prod .
#


# ============================================================
# DEV ENVIRONMENT
# ============================================================

services:

  app:

    build:
      context: .
      dockerfile: Dockerfile.dev

Penjelasan:
- Build menggunakan Dockerfile.dev


# ============================================================
# STAGING ENVIRONMENT
# ============================================================

services:

  app:

    build:
      context: .
      dockerfile: Dockerfile.staging

Penjelasan:
- Build menggunakan staging config


# ============================================================
# PRODUCTION ENVIRONMENT
# ============================================================

services:

  app:

    build:
      context: .
      dockerfile: Dockerfile.prod

Penjelasan:
- Build menggunakan production config


# ============================================================
# CONTOH REAL PROJECT
# ============================================================

project/

├── Dockerfile.dev
├── Dockerfile.local
├── Dockerfile.preview
├── Dockerfile.staging
├── Dockerfile.prod
│
├── compose.dev.yml
├── compose.staging.yml
├── compose.prod.yml
│
└── src/

Penjelasan:
- Sangat umum di perusahaan


# ============================================================
# DOCKERFILE.DEV
# ============================================================

FROM node:22

WORKDIR /app

COPY . .

RUN npm install

CMD ["npm","run","dev"]

Penjelasan:
- Hot reload
- Debugging


# ============================================================
# DOCKERFILE.PROD
# ============================================================

FROM node:22 AS builder

WORKDIR /app

COPY . .

RUN npm ci

RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

Penjelasan:
- Multi stage
- Image kecil
- Production ready


# ============================================================
# BUILD COMMAND YANG SERING DIPAKAI
# ============================================================

Development

docker build \
-f Dockerfile.dev \
-t myapp:dev \
.

------------------------------------------------------------

Staging

docker build \
-f Dockerfile.staging \
-t myapp:staging \
.

------------------------------------------------------------

Production

docker build \
-f Dockerfile.prod \
-t myapp:prod \
.

------------------------------------------------------------

Preview

docker build \
-f Dockerfile.preview \
-t myapp:preview \
.

------------------------------------------------------------

Testing

docker build \
-f Dockerfile.test \
-t myapp:test \
.

# ============================================================
# BEST PRACTICE
# ============================================================

Gunakan:

Dockerfile.dev
Dockerfile.staging
Dockerfile.prod

Daripada:

Dockerfile-v1
Dockerfile-baru
Dockerfile-final
Dockerfile-fix

Karena:
- lebih jelas
- lebih maintainable
- umum dipakai perusahaan

# ============================================================
# RINGKASAN PALING PENTING
# ============================================================

Default:

docker build .

Menggunakan:

Dockerfile

------------------------------------------------------------

Custom:

docker build \
-f Dockerfile.prod \
.

Menggunakan:

Dockerfile.prod

------------------------------------------------------------

Compose:

build:
  context: .
  dockerfile: Dockerfile.prod

------------------------------------------------------------

PENTING:

-f hanya memilih Dockerfile

Context tetap ditentukan oleh:

.

atau

./backend

atau

/path/project

Jangan tertukar antara:

-f Dockerfile.prod

dan

.

Karena:

-f = file Dockerfile

. = build context

Keduanya berbeda.