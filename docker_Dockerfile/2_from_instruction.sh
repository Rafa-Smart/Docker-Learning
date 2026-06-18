# Saat kita membuat Docker Image, biasanya perintah pertama adalah melakukan build stage
# dengan instruksi FROM
# FROM̧ digunakan untuk membuat build stage dari image yang kita tentukan
# Biasanya, jarang sekali kita akan membuat Docker Image dari scratch (kosongan), biasanya kita
# akan membuat Docker Image dari Docker Image lain yang sudah ada
# Untuk menggunakan FROM, kita bisa gunakan perintah :
# FROM image:version
# nah secara default kalo enggga di tulis tagnya maka akan emnjadi latest ya

# PENING, DI FROM ITU GA BSIA PAKE DAU IMGAE YA, KALO KIT NULIS 2 IMAGE MAKA AKANDI PAKENY YANG TERAKIHR

# nah ini tuh sama kaya format sebelumnya ya
# Instruction parameter/arguements

# /PENTING 
# /jadi oelh sebab itu setiap kali ktia ingin membuat image itu ktia perlu lingkungan linux ya, karena misalnya aplikasi kaya node js butuh filesystem dll
# makanya keitak ktia ingin membuat iamge custom, ktia perlu untu menggunaka itu

# sebenrnya ketika ktia buat contiaenr, kitkan buat bedasarkan image ya, nah image itu di buatnya pasti pake dokerfile yang menggunakan linkungan linux untuk menjalankan aplikasinya 



# contohnya ya, kita buat image custom

FROM alpine:latest

# nah pas kita jalanin ya ini misalnya, pas kita cek kapan di buatnya, ternyat audah 3 hri yang lalu, kenapa ? padhal saya baru batnya detik ini
# ini karena kna kita buat dari alpine latest ya, sedangkan saya itu udah puya image alpine latest
# nah karena dalam Dockerfie yang hanya FROM alpine:latest, iu kan betul betul hanya alpine tanpa ada instuksi lain, maknya kana di ambil dari image yang sudha say punya, kecuali kalo ada yang di ubah atau menmbahakn instruksi dan tidak hanya from alpine:latest


# jadi
# Container SELALU dibuat dari Image.

# Dan hampir semua Image pada akhirnya memiliki base image seperti:

# - alpine
# - ubuntu
# - debian
# - busybox
# - distroless

# Jadi sebenarnya container tidak pernah muncul begitu saja.

# Urutannya selalu:

# Dockerfile
#     ↓
# Image
#     ↓
# Container


# CONTOH PALING SEDERHANA
# =======================

# docker run nginx

# Apa yang terjadi?

# 1. Docker mencari image nginx
# 2. Jika belum ada → download image nginx
# 3. Docker membuat container dari image nginx
# 4. Nginx berjalan

# Kita tidak melihat alpine atau ubuntu.

# Tapi sebenarnya image nginx dibangun di atas image lain.

# Misalnya:

# debian
#    ↓
# nginx
#    ↓
# container


# ATAU

# alpine
#    ↓
# nginx
#    ↓
# container


# Jadi alpine/ubuntu tetap ada di bawahnya.


# --------------------------------------------------


# KAPAN KITA MENULIS "FROM ALPINE" ATAU "FROM UBUNTU"?
# ====================================================

# Biasanya saat membuat image sendiri.

# Misalnya saya membuat aplikasi Node.js.

# Dockerfile:

# FROM alpine

# RUN apk add nodejs npm

# COPY . .

# CMD ["node","app.js"]

# Artinya:

# "Saya ingin membuat image baru
# yang menggunakan Alpine Linux
# sebagai fondasinya."


# --------------------------------------------------


# KENAPA NODE.JS MEMBUTUHKAN ALPINE ATAU UBUNTU?
# ==============================================

# Karena Node.js bukan sistem operasi.

# Node.js hanyalah program.

# Agar bisa berjalan, Node.js membutuhkan:

# - filesystem
# - library sistem
# - DNS resolver
# - network stack
# - permission system
# - process management

# Semua itu disediakan oleh lingkungan Linux.

# Contoh:

# Node.js
#     ↓
# Alpine
#     ↓
# Linux Kernel Host
#     ↓
# Hardware


# Jadi Node.js tidak berjalan langsung di atas kernel.

# Dia berjalan di atas user-space Linux
# yang disediakan Alpine atau Ubuntu.


# --------------------------------------------------


# APAKAH CONTAINER PUNYA SISTEM OPERASI SENDIRI?
# ==============================================

# Ini bagian yang paling penting.

# Banyak orang mengira:

# Container
#     ↓
# Ubuntu Kernel
#     ↓
# Hardware

# SALAH.

# Yang benar:

# Container
#     ↓
# Ubuntu Filesystem
#     ↓
# Kernel Host
#     ↓
# Hardware

# Container tidak membawa kernel.

# Container hanya membawa:

# - file
# - library
# - binary
# - konfigurasi

# Kernel tetap milik host.


# --------------------------------------------------


# CONTOH NYATA
# ============

# Laptop saya:

# Windows
#     ↓
# Docker Desktop
#     ↓
# Linux VM
#     ↓
# Container Node
#     ↓
# Alpine Filesystem

# Container Redis
#     ↓
# Alpine Filesystem

# Container Nginx
#     ↓
# Debian Filesystem


# Semua container di atas
# memakai kernel Linux yang sama.

# Mereka TIDAK membawa kernel sendiri.


# --------------------------------------------------


# KENAPA BANYAK ORANG MEMILIH ALPINE?
# ===================================

# Karena ringan.

# Perkiraan ukuran:

# Alpine      : ~5 MB
# Ubuntu      : ~80 MB
# Debian      : ~120 MB

# Contoh:

# FROM alpine

# Ukuran image bisa sangat kecil.

# Sedangkan:

# FROM ubuntu

# Biasanya jauh lebih besar.


# --------------------------------------------------


# CARA BERPIKIR YANG BENAR
# ========================

# Jangan berpikir:

# "Node.js membutuhkan Ubuntu."

# Tapi berpikirlah:

# "Node.js membutuhkan lingkungan Linux."

# Lingkungan Linux itu bisa berupa:

# - Alpine
# - Ubuntu
# - Debian
# - Busybox
# - Distroless

# Ubuntu hanyalah salah satu pilihan.


# --------------------------------------------------


# CONTOH YANG LEBIH UMUM DI DUNIA KERJA
# =====================================

# Daripada:

# FROM alpine

# RUN apk add nodejs npm

# Biasanya orang langsung:

# FROM node:22-alpine

# Kenapa?

# Karena image itu sudah berisi:

# Alpine Linux
#     +
# Node.js
#     +
# npm

# Jadi kita tinggal:

# FROM node:22-alpine

# COPY . .

# RUN npm install

# CMD ["npm","start"]


# --------------------------------------------------


# KESIMPULAN
# ==========

# 1. Container selalu dibuat dari Image.

# 2. Image biasanya memiliki base image:
#    - Alpine
#    - Ubuntu
#    - Debian
#    - Busybox
#    - Distroless

# 3. Alpine/Ubuntu bukan kernel Linux.

# 4. Alpine/Ubuntu hanya menyediakan user-space Linux
#    (filesystem, library, shell, command, dll).

# 5. Semua container berbagi kernel host yang sama.

# 6. Kita biasanya menulis FROM alpine atau FROM ubuntu
#    ketika ingin membuat image custom.

# 7. Untuk Node.js, praktik yang lebih umum adalah:

#    FROM node:22-alpine

#    karena Node.js sudah terpasang dan siap digunakan.