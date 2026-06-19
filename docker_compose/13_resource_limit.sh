Kita juga bisa menggunakan file konfigurasi Docker Compose untuk mengatur Resource Limit
untuk CPU dan Memory dari tiap Container yang akan kita buat
Kita bisa menggunakan attribute deploy, lalu didalamnya menggunakan attribute resources
Di dalam attribute resources kita bisa tentukan limit dan reservations
reservation adalah resource yang dijamin bisa digunakan oleh container
limit adalah limit maksimal untuk resource yang diberikan ke container, namun ingat bisa saja limit
ini rebutan dengan container lain

# ------------------------------------------------------------
# LIMIT MEMORY
# ------------------------------------------------------------

docker run -m 512m nginx

Penjelasan:
- Maksimum RAM 512 MB.


docker run --memory=512m nginx

Penjelasan:
- Sama seperti -m.


# ------------------------------------------------------------
# LIMIT MEMORY 1GB
# ------------------------------------------------------------

docker run -m 1g nginx

Penjelasan:
- Maksimum RAM 1 GB.


# ------------------------------------------------------------
# MEMORY + SWAP
# ------------------------------------------------------------

docker run \
  --memory=512m \
  --memory-swap=1g \
  nginx

Penjelasan:
- RAM = 512 MB
- Swap = 512 MB tambahan
- Total = 1 GB


# ------------------------------------------------------------
# NONAKTIFKAN SWAP
# ------------------------------------------------------------

docker run \
  --memory=512m \
  --memory-swap=512m \
  nginx

Penjelasan:
- Tidak boleh menggunakan swap.


# ============================================================
# CPU LIMIT
# ============================================================

docker run --cpus=1 nginx

Penjelasan:
- Maksimum 1 core CPU.


docker run --cpus=2 nginx

Penjelasan:
- Maksimum 2 core CPU.


docker run --cpus=0.5 nginx

Penjelasan:
- Maksimum setengah CPU.


# ------------------------------------------------------------
# CPU SHARES
# ------------------------------------------------------------

docker run --cpu-shares=512 nginx

Penjelasan:
- Prioritas CPU lebih rendah.


docker run --cpu-shares=2048 nginx

Penjelasan:
- Prioritas CPU lebih tinggi.


# ============================================================
# PID LIMIT
# ============================================================

docker run --pids-limit=100 nginx

Penjelasan:
- Maksimal 100 process.


# ============================================================
# RESOURCE LIMIT DI COMPOSE
# ============================================================

services:
  app:
    image: nginx

    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M

Penjelasan:
- CPU maksimum 1 core
- RAM maksimum 512 MB


# ------------------------------------------------------------
# RESERVATION
# ------------------------------------------------------------

services:
  app:
    image: nginx

    deploy:
      resources:
        reservations:
          cpus: '0.5'
          memory: 256M

Penjelasan:
- Resource minimum yang dicadangkan.


# ============================================================
# BAGIAN 4 - HEALTHCHECK + DEPENDS_ON
# ============================================================

services:

  db:
    image: postgres

    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      retries: 5

  app:
    image: myapp

    depends_on:
      db:
        condition: service_healthy

Penjelasan:
- app tidak akan start
- sampai db healthy


# ============================================================
# BAGIAN 5 - MONITORING
# ============================================================

docker stats

Penjelasan:
- Monitoring realtime:
  - CPU
  - Memory
  - Network
  - I/O


docker stats container_name

Penjelasan:
- Monitoring container tertentu.


# ============================================================
# BAGIAN 6 - BEST PRACTICE PRODUCTION
# ============================================================

services:

  app:
    image: myapp

    restart: unless-stopped

    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 5s
      retries: 3

    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M

Penjelasan:
- Restart otomatis
- Healthcheck aktif
- CPU dibatasi
- RAM dibatasi
- Cocok untuk production

# ============================================================
# REKOMENDASI UMUM
# ============================================================

restart:
  unless-stopped

healthcheck:
  interval: 30s
  timeout: 5s
  retries: 3

resources:
  cpus: 1
  memory: 512M

Alasan:
- Aman
- Stabil
- Mudah dipelihara
- Cocok untuk sebagian besar aplikasi web production