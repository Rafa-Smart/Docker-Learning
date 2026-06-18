# CMD atau Command, merupakan instruksi yang digunakan ketika Docker Container berjalan
# CMD tidak akan dijalankan ketika proses build, namun dijalankan ketika Docker Container
# berjalan
# Dalam Dockerfile, kita tidak bisa menambah lebih dari satu instruksi CMD, jika kita tambahkan
# lebih dari satu instruksi CMD, maka yang akan digunakan untuk menjalankan Docker Container
# adalah instruksi CMD yang terakhir

# jadi bedanya dengan run itu
# kalo run, dia akna di jalanakn ketiak ktia build imagenya ya, fungisnya biansaya untuk install install gitu deh atua yng lainnya jgua bisa

# kalo cmd/command, dia akan di jalankan SETIAP KALI KITA start atua menjalankan si container yang menggunakna image dari dockerfile ini ya /  ATUA PAE RUN JUG BSIA
# BIASNAYA DI CMMAND INI ISINYA UNTUK JALANIN WEB KAYA PHP ARTISAN SERVE DLL

# ini adalh format instruksinya ya
# Perintah CMD memiliki beberapa format :
# CMD command param param
# CMD [“executable", “param",“param"]
# CMD ["param", "param"], akan menggunakan executable ENTRY POINT, yang akan dibahas di
# chapter terpisah

# ==========================================
# FORMAT 1
# CMD command param param
# (Shell Form)
# ==========================================

FROM alpine:latest
CMD echo Hello World
# keitka start si continerya malka akan menjalankan ini
/bin/sh -c "echo Hello World"

# ==========================================
# FORMAT 2
# CMD ["executable", "param", "param"]
# (Exec Form)
# ==========================================

FROM alpine:latest
CMD ["echo", "Hello World"]
# keitka start si continerya malka akan menjalankan ini
/bin/sh -c "echo Hello World"

# ==========================================
# FORMAT 3
# CMD ["param", "param"]
# Menggunakan ENTRYPOINT
# ==========================================

FROM alpine:latest
ENTRYPOINT ["echo"]
CMD ["Hello World"]
# keitka start si continerya malka akan menjalankan ini
/bin/sh -c "echo Hello World"

# NAH INAGT, PERINTAH DARI RUN ITU ADALH GABUNGAN ANTARA CREATE DAN START YA
# ini formatnya
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
# docker run
#     │
#     ├── OPTIONS  -> konfigurasi container
#     ├── IMAGE    -> image yang dipakai
#     ├── COMMAND  -> command yang dijalankan
#     └── ARG      -> parameter untuk command
# jadi pas kita run maka akan create contianer dan start ya

# /tpai biasnya itu gini
docker run nginx
# atinya adlah ktia ga ngsih naa pas create lalu ingat, nginx adalah nama imag ya
# jadi namanya bebas atau random 

# tpai kalo mau pake nama bisa
docker run --name web nginx

# atau mau apke port
docker run -p 8080:80 nginx


# atau kalo misalnya kan kao image ubunt dang itu ga ad a service yang terus berjalan ya
# jadi harus pake command giut

# nah kita bisa override commandny
docker run ubuntu ls

# atau kita mau pas buat itu langusng masuk ke exec
docker run -it ubuntu bash

# atau kalo pake nama
docker run --name web -it nginx -p 3000:80 bash