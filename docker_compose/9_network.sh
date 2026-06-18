Saat kita menjalankan file menggunakan Docker Compose, secara default semua container akan
dihubungkan dalam sebuah Network bernama nama-project_default
Jadi sebenarnya kita tidak perlu membuat Network secara manual
# karea udha di buatin satu network utnuk satu file configurtion nya ini

Silahkan inspect container yang sudah berjalan menggunakan Docker Compose, lalu lihat pada
bagian Network


# nah, dan juga kalo ktia mau contianer ini engga bisa nymbungke continer lain maka kita bisa pake perintah ini
If you want the service to not be connected a network, you must set network_mode: none.

services:

  app:
    # Nama service
    #
    # Service ini akan menjadi container saat compose dijalankan

    image: nginx
    # Image yang digunakan
    # network_mode: none -> kalo ga mau nyambung
    networks:
      - frontend
      - backend
    # Daftar network yang diikuti service ini
    #
    # Karena app berada di:
    # - frontend
    # - backend
    #
    # maka app bisa berkomunikasi dengan
    # semua container pada kedua network tersebut

  db:
    image: mysql:8

    networks:
      - backend
    # db hanya masuk ke network backend
    #
    # db TIDAK bisa diakses langsung
    # oleh container yang hanya berada
    # pada network frontend

networks:
  # Daftar network yang akan dibuat

  frontend:
    # Nama network

    driver: bridge
    # Driver network yang digunakan
    #
    # bridge = default Docker
    # overlay = Docker Swarm
    # macvlan = menggunakan jaringan fisik
    # host = menggunakan network host
    # none = tanpa network
    #
    # Pada kebanyakan kasus:
    #
    # driver: bridge

    internal: false
    # Apakah network boleh mengakses internet
    #
    # false = boleh keluar internet
    # true  = hanya komunikasi internal
    #
    # Cocok untuk:
    # - database
    # - redis
    # - service internal

    attachable: false
    # Mengizinkan container lain
    # di luar compose
    # bergabung ke network ini
    #
    # false = tidak boleh
    # true  = boleh
    #
    # Biasanya dipakai pada:
    # Docker Swarm

  backend:
    # Network backend

    driver: bridge

    name: company-backend
    # Nama asli network di Docker
    #
    # Tanpa property ini:
    #
    # project_backend
    #
    # Contoh:
    #
    # docker-learning_backend
    #
    # Dengan property ini:
    #
    # company-backend

    ipam:
      # Konfigurasi IP Address Management
      #
      # Digunakan jika ingin menentukan
      # subnet sendiri

      config:

        - subnet: 172.28.0.0/16
          # Range IP network
          #
          # Contoh:
          #
          # 172.28.0.2
          # 172.28.0.3
          # 172.28.0.4

          gateway: 172.28.0.1
          # Gateway network

          ip_range: 172.28.5.0/24
          # Range IP yang boleh digunakan
          # oleh container
          #
          # Jarang dipakai pada project biasa

          aux_addresses:
            dns: 172.28.0.10
          # Reserved IP Address
          #
          # Jarang digunakan

  monitoring:
    external: true
    # Gunakan network yang SUDAH ADA
    #
    # Docker Compose tidak akan membuat
    # network ini
    #
    # Network harus dibuat terlebih dahulu
    #
    # docker network create monitoring

    name: monitoring
    # Nama network yang sudah ada



    # BEST PRACTICE 1
#
# Gunakan nama service
# jangan gunakan IP
#
# BENAR:
#
# DB_HOST=db
#
# SALAH:
#
# DB_HOST=172.18.0.5
#
# Karena IP container bisa berubah


# BEST PRACTICE 2
#
# Pisahkan network
#
# frontend
# backend
#
# lebih baik daripada
#
# semua container
# dalam satu network


# BEST PRACTICE 3
#
# Database sebaiknya
# hanya berada pada
# network backend
#
# Jangan expose database
# langsung ke internet


# BEST PRACTICE 4
#
# Gunakan driver bridge
# kecuali memang ada alasan
# khusus menggunakan:
#
# overlay
# macvlan
# host


# BEST PRACTICE 5
#
# Hindari network_mode: host
#
# karena mengurangi isolasi
# yang diberikan Docker
#
# gunakan bridge jika memungkinkan