# ============================================================
# DOCKER COMPOSE EXTENDS CHEAT SHEET
# COMPLETE GUIDE
# ============================================================

# ============================================================
# APA ITU EXTENDS?
# ============================================================

# extends digunakan untuk:
#
# - mewarisi konfigurasi service lain
# - mengurangi duplikasi konfigurasi
# - membuat base service
# - membuat template service
# - berbagi konfigurasi antar project
#
# Konsepnya mirip:
#
# class App {}
# class Web extends App {}
#
# atau
#
# Parent -> Child
#
# Service Child akan mewarisi konfigurasi Parent.


# ============================================================
# BENTUK DASAR EXTENDS
# ============================================================

services:

  web:
    extends:
      service: app

  app:
    image: nginx

Penjelasan:
- web mewarisi seluruh konfigurasi app
- image nginx ikut diwariskan
- web sekarang memiliki image nginx


# ============================================================
# EXTENDS DALAM FILE YANG SAMA
# ============================================================

services:

  base:
    image: nginx
    environment:
      APP_ENV: production

  web:
    extends:
      service: base

Penjelasan:
- web mewarisi:
  image: nginx
  environment:
    APP_ENV: production


# Hasil akhirnya setara dengan:

services:

  web:
    image: nginx

    environment:
      APP_ENV: production

  base:
    image: nginx

    environment:
      APP_ENV: production


# ============================================================
# OVERRIDE PROPERTY
# ============================================================

services:

  base:
    image: nginx

  web:
    extends:
      service: base

    image: apache

Penjelasan:
- Child menang terhadap Parent
- image nginx diganti apache


# Hasil:

services:

  web:
    image: apache


# ============================================================
# EXTENDS FILE LAIN
# ============================================================

# compose.yaml

services:

  web:

    extends:
      file: common.yml
      service: app

Penjelasan:
- mengambil service app
- dari file common.yml


# ============================================================
# FILE COMMON
# ============================================================

# common.yml

services:

  app:

    image: nginx

    environment:
      APP_ENV: production

    ports:
      - "80:80"

Penjelasan:
- app menjadi template
- file lain dapat menggunakannya


# ============================================================
# HASIL EXTENDS FILE LAIN
# ============================================================

services:

  web:

    image: nginx

    environment:
      APP_ENV: production

    ports:
      - "80:80"

Penjelasan:
- service app tidak otomatis ikut dibuat
- hanya konfigurasi yang diwariskan


# ============================================================
# EXTENDS + TAMBAHAN CONFIG
# ============================================================

services:

  web:

    extends:
      file: common.yml
      service: app

    environment:
      DEBUG: true

Penjelasan:
- konfigurasi parent tetap ada
- child menambahkan DEBUG


# Hasil:

services:

  web:

    image: nginx

    environment:
      APP_ENV: production
      DEBUG: true


# ============================================================
# MULTI LEVEL EXTENDS
# ============================================================

services:

  base:
    image: nginx

  web:
    extends:
      service: base

  web_prod:
    extends:
      service: web

Penjelasan:
- web_prod
- mewarisi web
- web mewarisi base
- inheritance berantai


# ============================================================
# EXTENDS + BUILD
# ============================================================

services:

  base:

    build:
      context: .

  app:

    extends:
      service: base

Penjelasan:
- build ikut diwariskan


# ============================================================
# EXTENDS + ENVIRONMENT
# ============================================================

services:

  base:

    environment:
      APP_ENV: production
      LOG_LEVEL: info

  app:

    extends:
      service: base

Penjelasan:
- seluruh environment diwariskan


# ============================================================
# OVERRIDE ENVIRONMENT
# ============================================================

services:

  base:

    environment:
      APP_ENV: production
      LOG_LEVEL: info

  app:

    extends:
      service: base

    environment:
      LOG_LEVEL: debug

Penjelasan:
- LOG_LEVEL diganti debug
- APP_ENV tetap production


# Hasil:

environment:
  APP_ENV: production
  LOG_LEVEL: debug


# ============================================================
# EXTENDS + PORTS
# ============================================================

services:

  base:

    ports:
      - "80:80"

  app:

    extends:
      service: base

    ports:
      - "8080:80"

Penjelasan:
- sequence/list digabung
- bukan diganti


# Hasil:

ports:
  - "80:80"
  - "8080:80"


# ============================================================
# EXTENDS + VOLUMES
# ============================================================

services:

  base:

    volumes:
      - data:/data

  app:

    extends:
      service: base

    volumes:
      - logs:/logs

Penjelasan:
- volume digabung


# Hasil:

volumes:
  - data:/data
  - logs:/logs


# ============================================================
# EXTENDS + LABELS
# ============================================================

services:

  base:

    labels:
      app: myapp

  app:

    extends:
      service: base

    labels:
      env: prod

Penjelasan:
- mapping digabung


# Hasil:

labels:
  app: myapp
  env: prod


# ============================================================
# RULE MERGING
# ============================================================

# Mapping
#
# Child override Parent

environment:
labels:
healthcheck:
logging:
sysctls:
ulimits:

Penjelasan:
- key sama -> child menang
- key beda -> digabung


# ============================================================
# SEQUENCE MERGE
# ============================================================

ports:
volumes:
depends_on:
dns:
tmpfs:

Penjelasan:
- list digabung
- parent dulu
- child setelahnya


# ============================================================
# SCALAR MERGE
# ============================================================

image:
container_name:
hostname:
user:

Penjelasan:
- child menggantikan parent


# ============================================================
# RELATIVE PATH
# ============================================================

services:

  app:

    extends:
      file: ../common/compose.yaml
      service: base

Penjelasan:
- path dihitung relatif terhadap
  compose utama
- bukan file extends

INI PENTING!


# ============================================================
# MELIHAT HASIL EXTENDS
# ============================================================

docker compose config

Penjelasan:
- menampilkan hasil merge final
- sangat penting saat debugging


# ============================================================
# VALIDASI CONFIG
# ============================================================

docker compose config

Penjelasan:
- validasi syntax
- resolve extends
- resolve variable
- resolve merge


# ============================================================
# ERROR SERVICE TIDAK ADA
# ============================================================

extends:
  file: common.yml
  service: app

Penjelasan:
- jika app tidak ada
- compose error


# Error:

service "app" not found


# ============================================================
# ERROR FILE TIDAK ADA
# ============================================================

extends:
  file: abc.yml
  service: app

Penjelasan:
- file tidak ditemukan
- compose gagal


# ============================================================
# CIRCULAR EXTENDS
# ============================================================

services:

  app:
    extends:
      service: web

  web:
    extends:
      service: app

Penjelasan:
- tidak diperbolehkan
- Compose akan error


# ============================================================
# DEPENDS_ON TIDAK OTOMATIS DIBAWA
# ============================================================

PENTING!

Jika service parent menggunakan:

depends_on:
volumes:
networks:
configs:
secrets:

Anda tetap harus memastikan resource tersebut
didefinisikan pada compose utama.

Compose tidak otomatis meng-import resource yang
dibutuhkan service parent. 

# ============================================================
# EXTENDS VS YAML ANCHOR
# ============================================================

# EXTENDS

extends:
  service: base

Kelebihan:
- antar file
- antar project
- lebih modular


# YAML ANCHOR

x-base: &base

  image: nginx

services:

  web:
    <<: *base

Kelebihan:
- lebih cepat
- tidak perlu extends

Kekurangan:
- hanya dalam file yang sama


# ============================================================
# BEST PRACTICE
# ============================================================

# common.yml

services:

  base-app:

    restart: unless-stopped

    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]

    logging:
      options:
        max-size: "10m"

    environment:
      TZ: Asia/Jakarta


# compose.yml

services:

  api:

    extends:
      file: common.yml
      service: base-app

    image: my-api

  worker:

    extends:
      file: common.yml
      service: base-app

    image: my-worker

Penjelasan:
- healthcheck diwariskan
- restart diwariskan
- logging diwariskan
- environment diwariskan
- hanya image yang berbeda

# ============================================================
# COMMAND PALING PENTING
# ============================================================

docker compose config

Penjelasan:
- WAJIB saat memakai extends
- melihat hasil merge final
- debugging inheritance
- debugging override
- debugging environment

# ============================================================
# RINGKASAN
# ============================================================

extends:
  service: nama_service

extends:
  file: common.yml
  service: nama_service

Rule Merge:

Mapping  -> merge (child override)
Sequence -> gabung
Scalar   -> child menggantikan parent

Tool Debug:

docker compose config

Use Case:

- base service
- reusable config
- shared environment
- shared healthcheck
- shared logging
- shared build config
- shared production template
