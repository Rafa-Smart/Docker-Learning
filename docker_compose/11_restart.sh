Secara default, saat Container mati, maka Docker tidak akan menjalankan lagi Container nya
Kita harus menjalankan lagi Container nya secara manual
Kita bisa memaksa sebuah container untuk selalu melakukan restart jika misal terjadi masalah
pada Container nya
Kita bisa tambahkan attribute restart, dengan beberapa value :
no: default nya tidak pernah restart
always: selalu restart jika container berhenti /  error  jaid pas restart laptop lalu nyaain docker maka akan otomatis nyala nih si cntainernya
on-failure: restart jika container error dengan indikasi error ketika exit
unless-stopped: selalu restart container, kecuali ketika dihentikan manual

# ==========================================
# DOCKER HEALTHCHECK, RESTART & RESOURCE LIMITS
# COMPLETE CHEAT SHEET
# ==========================================

# ============================================================
# BAGIAN 1 - HEALTH CHECK
# ============================================================

# ------------------------------------------------------------
# HEALTHCHECK DI DOCKERFILE
# ------------------------------------------------------------

HEALTHCHECK CMD curl -f http://localhost || exit 1

Penjelasan:
- Docker akan menjalankan command ini secara berkala.
- Jika command exit code 0 -> healthy
- Jika command gagal -> unhealthy
- Berguna untuk memastikan aplikasi benar-benar berjalan.


# ------------------------------------------------------------
# HEALTHCHECK DENGAN INTERVAL
# ------------------------------------------------------------

HEALTHCHECK \
  --interval=30s \
  --timeout=5s \
  --start-period=30s \
  --retries=3 \
  CMD curl -f http://localhost || exit 1

Penjelasan:
- interval     = seberapa sering dicek
- timeout      = batas waktu pengecekan
- start-period = masa tunggu sebelum healthcheck aktif
- retries      = jumlah kegagalan sebelum dianggap unhealthy


# ------------------------------------------------------------
# MENONAKTIFKAN HEALTHCHECK
# ------------------------------------------------------------

HEALTHCHECK NONE

Penjelasan:
- Menonaktifkan healthcheck bawaan image.


# ============================================================
# HEALTHCHECK DI DOCKER COMPOSE
# ============================================================

services:
  app:
    image: nginx

    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s

Penjelasan:
- test          = command yang dijalankan
- interval      = jarak pengecekan
- timeout       = batas waktu
- retries       = jumlah retry
- start_period  = masa tunggu startup


# ------------------------------------------------------------
# MENGGUNAKAN CMD-SHELL
# ------------------------------------------------------------

services:
  app:
    image: nginx

    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost || exit 1"]

Penjelasan:
- CMD-SHELL menjalankan command melalui shell.
- Cocok untuk command yang menggunakan:
  - &&
  - ||
  - pipe (|)
  - variable shell


# ------------------------------------------------------------
# MELIHAT STATUS HEALTH
# ------------------------------------------------------------

docker ps

Penjelasan:
- Akan muncul:
  Up 2 minutes (healthy)

atau

  Up 2 minutes (unhealthy)


# ------------------------------------------------------------
# DETAIL HEALTHCHECK
# ------------------------------------------------------------

docker inspect container_name

Penjelasan:
- Menampilkan seluruh informasi container.


# ------------------------------------------------------------
# MELIHAT STATUS HEALTH SAJA
# ------------------------------------------------------------

docker inspect --format='{{json .State.Health}}' container_name

Penjelasan:
- Menampilkan hasil healthcheck lengkap.


# ------------------------------------------------------------
# MELIHAT STATUS HEALTH RINGKAS
# ------------------------------------------------------------

docker inspect --format='{{.State.Health.Status}}' container_name

Penjelasan:
Output:

healthy

atau

unhealthy


# ============================================================
# BAGIAN 2 - RESTART POLICY
# ============================================================

# ------------------------------------------------------------
# RESTART NO
# ------------------------------------------------------------

docker run --restart=no nginx

Penjelasan:
- Default.
- Container tidak restart otomatis.


# ------------------------------------------------------------
# RESTART ALWAYS
# ------------------------------------------------------------

docker run --restart=always nginx

Penjelasan:
- Selalu restart.
- Server reboot -> container hidup lagi.
- Cocok untuk:
  - Database
  - Reverse Proxy
  - Service penting


# ------------------------------------------------------------
# RESTART UNLESS-STOPPED
# ------------------------------------------------------------

docker run --restart=unless-stopped nginx

Penjelasan:
- Mirip always.
- Jika user stop manual:
  docker stop
  maka tidak otomatis hidup lagi.

Biasanya pilihan terbaik production.


# ------------------------------------------------------------
# RESTART ON FAILURE
# ------------------------------------------------------------

docker run --restart=on-failure nginx

Penjelasan:
- Restart hanya jika exit code != 0


# ------------------------------------------------------------
# RESTART ON FAILURE DENGAN LIMIT
# ------------------------------------------------------------

docker run --restart=on-failure:5 nginx

Penjelasan:
- Maksimal restart 5 kali.


# ============================================================
# RESTART POLICY DI COMPOSE
# ============================================================

services:
  app:
    image: nginx
    restart: always

Penjelasan:
- Restart terus.


services:
  app:
    image: nginx
    restart: unless-stopped

Penjelasan:
- Paling sering digunakan.


services:
  app:
    image: nginx
    restart: on-failure

Penjelasan:
- Restart saat crash.


services:
  app:
    image: nginx
    restart: on-failure:3

Penjelasan:
- Maksimal 3 kali restart.


services:
  app:
    image: nginx
    restart: "no"

Penjelasan:
- Tidak restart.


# ============================================================
# RESTART COMMAND
# ============================================================

docker restart container_name

Penjelasan:
- Restart container.


docker compose restart

Penjelasan:
- Restart semua service compose.


docker compose restart app

Penjelasan:
- Restart service tertentu.


docker compose restart -t 30

Penjelasan:
- Tunggu 30 detik sebelum force stop.
- Berguna untuk graceful shutdown.

# CATATAN:
# Restart command TIDAK menerapkan perubahan compose.yml
# Untuk menerapkan perubahan:
#
# docker compose up -d
#
# atau
#
# docker compose up -d --force-recreate

# ============================================================
# BAGIAN 3 - RESOURCE LIMITS
# ============================================================

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