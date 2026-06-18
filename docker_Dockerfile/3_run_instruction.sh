# RUN adalah sebuah instruksi untuk mengeksekusi perintah di dalam image pada saat build stage.
# Hasil perintah RUN akan di commit dalam perubahan image tersebut, jadi perintah RUN akan
# dieksekusi pada saat proses docker build saja, setelah menjadi Docker Image, perintah tersebut
# tidak akan dijalankan lagi.
# Jadi ketika kita menjalankan Docker Container dari Image tersebut, maka perintah RUN tidak akan
# dijalankan lagi.

# penting
# jadi ingat ya, eprintha yang ad adi run itu hanya kna di jalanakna ketiak process Dockerfile menjadi image ya pas buildnya
# jadi kalo udha di build dna kita jalanakan di contianer, itu tidak akan di jalanakn ya sama sekali 

# misalnya pas kita but Dockerfile kita mungkin ketika ingin buat image akna menginstlal apa gitu ya
# nah maka perintha yang kaya gitu tuh di lakukan di perintha run

# jadi pas di buat docker imagenya, maka nanti sudah ada hal hal yang ktia butuhkna

# perintahny ity kaya gini ya
# 1.RUN command -> jad hnaya satu barisa satu baris ya
# ch :
RUN apt update
RUN apt install -y curl
RUN mkdir aplikasi

# ini yan akan terjadi sebenrnya 
/bin/sh -c "apt update"
/bin/sh -c "apt install -y curl"
/bin/sh -c "mkdir aplikasi"


# 2.RUN ['executable', 'argument/command', 'argument/command']
# ch :
RUN ["mkdir", "app"] -> akan jadi mkdir app

# ini salah ya
RUN ["mkdir", "app", "&&", "touch", "app/index.js"]
# karena && adalah fitur shell (bash atau sh), bukan program.
# kalo mau gini
RUN ["/bin/sh", "-c", "mkdir app && touch app/index.js"]

# lebih baik pake cara pertma saja ya


# nah conothnya gini ya
# lihat di folder 1_run

# jadi pas saya coba buat contianer dari iamge ini, maka pas saya exec lalu ls maka baur ketauan uth aya punya foder test/hello yaaaa, bukan di sistem saya  

# dan ingat ya, ini tuh engga bisa di exec karena akan langusn ertutup kalo kit astart contianernya ini uhda pasti karna kita belum buat command di image nya ya    
# dan ingat di linu alpine itu bukn pake \ ya, tpai waib pake / sebagia pemisah file


# Secara default, di docker terbaru tidak akan menampilkan tulisan detail dari build-nya
# Jika kita ingin menampilkan detailnya, kita bisa gunakan perintah --progress=plain
# Selain itu juga docker build juga melakukan cache, jika kita ingin mengulangi lagi tanpa
# menggunakan cache, kita bisa gunakan perintah --no-cache

# nah jadi pas kita buat Dockerfile lalu kita buat image pertma dari Dockerfile itu
# maka akan di cache si isi dari file Dokerfile ini ya
# jasi pas kita mau buat image lagi, tapi file Dockerfilenya sama sekali tidak di ubah maka akan cepat karena ngambil dari cache, kalo ga ma apke cache maka bisa pake --no-cache







# NAH INI BACA YA
# MEMAHAMI RUN, IMAGE, CONTAINER, DAN FILESYSTEM DOCKER

# Saya awalnya berpikir:

# RUN mkdir hello

# akan membuat folder hello di komputer saya.

# Ternyata TIDAK.


# ---------------------------------------------------------
# YANG SEBENARNYA TERJADI
# ---------------------------------------------------------

# Dockerfile:

# FROM alpine

# RUN mkdir hello

# Saat menjalankan:

# docker build -t khadafi/hello .

# Docker akan:

# 1. Membuat container sementara
# 2. Menjalankan RUN mkdir hello
# 3. Menyimpan hasilnya ke Image
# 4. Menghapus container sementara

# Hasil akhirnya:

# Image khadafi/hello memiliki folder:

# /hello


# ---------------------------------------------------------
# RUN BERJALAN KAPAN?
# ---------------------------------------------------------

# RUN berjalan saat:

# docker build

# BUKAN saat:

# docker run

# Contoh:

# Dockerfile:

# FROM alpine

# RUN mkdir hello

# Saat build:

# docker build -t khadafi/hello .

# folder hello dibuat.

# Saat run:

# docker run khadafi/hello

# Docker TIDAK menjalankan ulang:

# mkdir hello

# karena folder tersebut sudah menjadi bagian Image.


# ---------------------------------------------------------
# DI MANA FOLDER HELLO DISIMPAN?
# ---------------------------------------------------------

# BUKAN di:

# C:\Users\Rafa

# BUKAN di:

# C:\DATA-DATA-PEMBELAJARAN

# Tetapi di filesystem Image Docker.

# Kira-kira:

# Image khadafi/hello

# /
# ├── bin
# ├── etc
# ├── usr
# ├── var
# └── hello


# ---------------------------------------------------------
# APA YANG TERJADI SAAT CONTAINER DIBUAT?
# ---------------------------------------------------------

# docker run -it khadafi/hello sh

# Docker membuat Container baru dari Image.

# Container tersebut mewarisi seluruh isi Image.

# Maka di dalam container:

# /
# ├── bin
# ├── etc
# ├── usr
# ├── var
# └── hello

# folder hello tetap ada.


# ---------------------------------------------------------
# MEMBUKTIKANNYA
# ---------------------------------------------------------

# Dockerfile:

# FROM alpine

# RUN mkdir hello

# Build:

# docker build -t khadafi/hello .

# Run:

# docker run -it khadafi/hello sh

# Di dalam container:

# ls /

# Hasil:

# bin
# etc
# usr
# var
# hello

# Folder hello terlihat karena sudah menjadi bagian
# dari filesystem Image.


# ---------------------------------------------------------
# CONTOH DENGAN FILE
# ---------------------------------------------------------

# Dockerfile:

# FROM alpine

# RUN mkdir test

# RUN echo "Hello World" > /test/hello.txt

# Image yang dihasilkan:

# /
# └── test
#      └── hello.txt

# Saat container dijalankan:

# docker run -it khadafi/hello sh

# Kemudian:

# ls /test

# Hasil:

# hello.txt

# Kemudian:

# cat /test/hello.txt

# Hasil:

# Hello World


# ---------------------------------------------------------
# CARA BERPIKIR YANG BENAR
# ---------------------------------------------------------

# Host Windows
#     ≠
# Image Docker
#     ≠
# Container Docker

# Ketiganya memiliki filesystem yang berbeda.

# Folder yang dibuat dengan RUN:

# RUN mkdir hello

# akan masuk ke:

# Filesystem Image

# dan nantinya muncul pada:

# Filesystem Container

# BUKAN pada filesystem Windows saya.


# ---------------------------------------------------------
# RUMUS SEDERHANA
# ---------------------------------------------------------

# RUN
# ↓
# mengubah Image

# Image
# ↓
# menjadi cetakan (template)

# Container
# ↓
# dibuat dari Image

# Semua file dan folder yang dibuat saat RUN
# akan ikut terbawa ke Container.
# =========================================================