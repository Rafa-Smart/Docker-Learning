FROM golang:1.18-alpine

ENV APP_DATA="/logs"
ENV APP_PORT=8080

# jadi ingat ya APP_DATA ini isinya adalah /data
# dan ingat, di main.go kita udha maniplasi appaun url setelah localhost:8080/hello
# maka aka di buatkan file dalam folder data lalu buat file dnegn nama dan isi yang sama
RUN mkdir ${APP_DATA}
# RUN mkdir app // ni gausah di buat juga gapapa, akrena kalo pake workdir dan eblum ad afoldenya maka akan otomatis di buatin

# NAHH DINSI KTIA KASIH TAU YA KALO WORKDIRNYA ADLAH /APP
# JADI INIKAYA ROOTNYA GITU YA
WORKDIR /app
COPY main.go /app

EXPOSE ${APP_PORT}

# nah disn ktia sambunign antara folder data yang udah ada di image ya
# karena sekrng folder data udah di buat di dalma image ya
# jadi pas mkdir itu artinya kita buat folder di dalma image, nah kita mau agar 
# file file yang dimasukan dari go itu akan langsung ada di folde yng ada di dalma image ya
VOLUME ${APP_DATA}

# NHH JADI DISI GA PERLU LAGI YA PAKE /APP/MAIN.GO
# karena sekrng workdir atau defaul root nya udah jadi /app
# CMD go run app/main.go
# maka tinggal
CMD go run main.go

# JADI INGAT
# pertam kita akn buat folder di dalma iage namanya logs ya, lalu buat folder app juga idalam image nah pas kita jalanin containre ini kan dia akna menjalanakn si go ya yang dimaan dia akna buat file yang akan di masUkan kedalma folder logs 

# nah inaat, karnea ini udha ada di image dan container, maka seluruhnya ini akna terisolasi, jadi semua folder da file yang di buat di script main.go ini
# aka di bautakn di folder yang ada di imagenya ya bukan di sistem kita

# jadi apapun dan setiap perubahan maka volume kita akn terus beruabh jugaa

# KEREN BANGET, NANIT KANA LANGUNG DI BUTKAN VOLUMENYA YA KERENNN 

# dan kita juga bisa bind ke volume ya
# kerne banget dah