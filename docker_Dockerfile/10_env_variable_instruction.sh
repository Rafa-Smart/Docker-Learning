# ENV adalah instruksi yang digunakan untuk mengubah environment variable, baik itu ketika
# tåhapan build atau ketika jalan dalam Docker Container
# ENV yang sudah di definisikan di dalam Dockerfile bisa digunakan kembali di DOckerfilenya menggunakan
# sintaks ${NAMA_ENV}
# Environment Variable yang dibuat menggunakan instruksi ENV disimpan di dalam Docker Image
# dan bisa dilihat menggunakan perintah docker image inspect
# Selain itu, environment variable juga bisa diganti nilainya ketika pembuatan Docker Container
# dengan perintah docker container create --env key=value

# nah nini bags anget, akrea kita emng ga boleh hardcode ya didalma aplikasi kita
# jadi kita emang harusnya pake ini

# Berikut adalah format untuk instruksi ENV :
# ENV key=value
# ENV ke1=value1 key2=value2 ..

# nah tapi gin, ketiak kita udah set ini ya pas di build image
# tapi kalo kita mau ubah pas kita run atua create si containerya juga bia ya
# maa nanti akna di overide

# FROM golang:1.18-alpine
# RUN mkdir app
# COPY main.go app
# ENV APP_PORT="8080"
# CMD go run app/main.go

docker run --name servergo -p 8080:8081 --env APP_PORT="8081" khadafi/go
Run app in port: 8081

# jadi bebner ya bisa override env dan nanti si palikasi ktia itu bisa pake envnya seprti cara bahas pemrograman itu manggil env

# /pokoknya nanti selah olah ad afile .env dialm imagneya ya


# NAHHH INI AKN AKAN OTOMATIS ADA DI INSPECT YA
# BERTAI KALO AD AIMAGE, DAN KGTA PENGEN TUA KIRA KIRA APA SIH ENV YANG HARUS KITA ISI UNTUK IAMGE INI
# BISA CARINAY PAKE INSPECT AJAA GAUSAH APKE LIAT LIAT WEB NYA YA