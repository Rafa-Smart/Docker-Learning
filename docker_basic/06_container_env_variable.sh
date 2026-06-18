# Saat membuat aplikasi, menggunakan Environment Variable adalah salah satu teknik agar
# konfigurasi aplikasi bisa diubah secara dinamis
# Dengan menggunakan environment variable, kita bisa mengubah-ubah konfigurasi aplikasi, tanpa
# harus mengubah kode aplikasinya lagi
# Docker Container memiliki parameter yang bisa kita gunakan untuk mengirim environment
# variable ke aplikasi yang terdapat di dalam container

# karena kalo udha berbeda beda tempat, kita kan ga mungkin hardcode didalam apliaksinya ya utnuk pubic key dan lain lain

# jadi pas buat ya
docker contianer create --name namaContainer --env / -e namaKey="value" -p 3000:80 namaImage:tag
docker container create --name mongotest -e MONGO_INITDB_ROOT_USERNAME="Rafa Khadafi" -e MONGO_INITDB_ROOT_PASSWORD="password123" -p 27017:27017 mongo:latest
# mislanya di mongo ya, karena dia itu butuh env utuk user dan passwordnya, coba lia aja di dokumentsi si docker hub utuk image mongo
# dengan key nya adlah MONGO_INITDB_ROOT_USERNAME, MONGO_INITDB_ROOT_PASSWORD
# buan buat ile .env ya tapi Docker menyimpan environment variable ke konfigurasi container.

# untuk lihat env nya
# C:\Users\Rafa Khadafi>docker exec -it mongotest bash
# root@37c51df82272:/# ls
# bin  boot  data  dev  docker-entrypoint-initdb.d  etc  home  js-yaml.js  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
# root@37c51df82272:/# env
# HOSTNAME=37c51df82272
# PWD=/
# MONGO_INITDB_ROOT_PASSWORD=password123
# MONGO_INITDB_ROOT_USERNAME=Rafa Khadafi
# HOME=/data/db
# MONGO_PACKAGE=mongodb-org
# JSYAML_VERSION=3.13.1
# GOSU_VERSION=1.19
# MONGO_REPO=repo.mongodb.org
# MONGO_VERSION=8.2.11
# TERM=xterm
# MONGO_MAJOR=8.2
# JSYAML_CHECKSUM=662e32319bdd378e91f67578e56a34954b0a2e33aca11d70ab9f4826af24b941
# SHLVL=1
# PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# GLIBC_TUNABLES=glibc.pthread.rseq=0
# _=/usr/bin/env
# root@37c51df82272:/#

# pake perintah env didalm exec