Saat membuat file Docker Compose yang berisi banyak Container
Kadang kita membuat Container yang butuh Container lain sebelum berjalan
Atau sederhananya, kita ingin ada urutan Container berjalan
Secara default, Docker Compose akan menjalankan semua Container secara bersamaan, tanpa ada
urutan pasti
Kita bisa membuat urutan menjalankan Container dengan menggunakan attribute depends_on
Kita bisa sebutkan pada Container, bahwa Container ini hanya bisa berjalan, kalo Container yang
lain sudah berjalan
Kita bisa sebutkan satu atau lebih Container lainnya pada attribute depends_on

services:

  app:
    image: my-backend

    depends_on:
      - db
    # Daftar service yang harus dijalankan lebih dahulu
    #
    # Docker Compose akan:
    #
    # 1. Menjalankan db
    # 2. Menjalankan app
    #
    # Urutan:
    #
    # db
    # ↓
    # app
    #
    # TANPA depends_on:
    #
    # Docker bisa menjalankan
    # keduanya secara bersamaan

  db:
    image: mysql:8




# atua pake pengenekan heaty juga bisa nihh
services:

  app:
    image: my-backend

    depends_on:

      db:
        condition: service_healthy
    # Jangan jalankan app
    # sebelum db sehat

  db:
    image: mysql:8

    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]

      interval: 10s
      timeout: 5s
      retries: 5