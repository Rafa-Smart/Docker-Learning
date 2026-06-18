Saat kita membuat Dockerfile dari base image yang besar, secara otomatis ukuran Image nya pun
akan menjadi besar juga
Oleh karena itu, usahakan selalu gunakan base image yang memang kita butuhkan saja, jangan
terlalu banyak menginstall fıtur di Image padahal tidak kita gunakan
# itu adalah masalah mengenai file image size

Sebelumnya kita menggunakan bahasa pemrograman Go-Lang untuk membuat web sederhana.
Sebenarnya, Go-Lang memiliki fitur untuk melakukan kompilasi kode program Go-Lang menjadi
binary file, sehingga tidak membutuhkan Image Go-Lang lagi
Kita bisa melakukan proses kompilasi di laptop kita, lalu file binary nya yang kita simpan di Image,
dan cukup gunakan base image Linux Alpine misal nya
Namun pada kasus Go-Lang, kita di rekomendasikan melakukan kompilasi file binary di sistem
operasi yang sama, pada kasus ini saya menggunakan Mac, sedangkan ingin menggunakan Image
Alpine, jadi tidak bisa saya lakukan

# jadi maksudnay adalh, kta itu dari pada haurs install iamge oglang yang gede
# ebih bai kit hanya gunakan iamge alpine saja
# tpai seblum itu selruuh kode goang yang kita punya itu di kompilasi dulu jadi binary fil
# baru di masukan ke image, jadinya engga akan terlalu berat ya

tapi harus gini, jadi kita akn pake alpine ya di imagenya, berati nanti aps kita compile file go lagnya
# tu juga harus di sistem operasi alpine 
# karena kalo di sistem winwows, maka fielnya akan jadi binary windows, tapi kalo di alpine kan maka akan cocok

# nahh solusinyaa aalah
Docker memiliki fitur Multi Stage Build, dimana dalam Dockerfile, kita bisa membuat beberapa
Build Stage atau tahapan build
Seperti kita tahu, bahwa di awal build, biasanya kita menggunakan instruksi FROM, dan di dalam
Dockerfile, kita bisa menggunakan beberapa instruksi FROM
Setiap Instruksi FROM, artinya itu adalah build stage
Hal build stage terakhir adalah build stage yang akan dijadikan sebagai Image
Artinya, kita bisa memanfaatkan Docker build stage ini untuk melakukan proses kompilasi kode
program Go-Lang kita

# nahh jadi sebenernya ktia bisa bikin beberapa form
# nahhh, jadi di build stage ini ktia bisa compilasi dulu si go langnyaa

# jadi kita but bebrpaa from ya
# from from awal itu untuk preparationnya atau persiapannya
# misalnya kaya compolasi kode dll

# dan di from yang terakhir atua di bild stage yang erkhir, baru kit abuild imagenya
# nah ini harus kita kasih nama ya, disini kita kasih nama builder
FROM golang:1.18-alpine as builder
WORKDIR /app/
# ini artinya copy ke direcroy saat ini, artinya ke app ya
COPY main.go . 

# nah jadi ini perintha untuk compilasi ke folder app/main, lalu jalanin atau compilasi si file main.go ini ya
RUN go build -o /app/main main.go

# ini hailnya
# builder stage

# /app
#  ├── main.go
#  └── main

# nah jadi engga akan di buat imag eya pas from yang pertama ini, dia hanya jadi builder 
# karen ada as buildernya

# ah for yan gterkhir ini baru jadi image ya

FROM alpine: 3
WORKDIR /app/

# nah badu dari sini, kita ambil folder yng ada dari builder tadi, sebutin nama buildernya ya, ii nama buildernya
# llau ambil /app/main ke directory ./ di image ini

# ingat ya, ini bukan buat dri sistem file kita ya tapi dari build stag nya 
COPY --from=builder /app/main ./
# jadi sekarng /app/main sudha ada di dalm folder /app (workdir iamge kita yang menggunakan alpne ini)

# nah karena ini tuh suhh jaid binary file, maka cukup pake ini saja dn gasah apke penrtah go run
CMD /app/main
