
# disi kita akan pake golang ya, akrena kita akan menjalankan aplikasi golang dan jangan lupa
# kita pake golang yang ada alpinenya ya, jadi bukan 2 image ya
FROM golang:1.18-alpine
# ternyata di docker hub ga ada golang:latest-alpine ya
RUN mkdir app
COPY main.go app

# nah ini kita akn kasih tua kalo kita itu jalan di port 8080 (karean emang saat ini server go kita ada di 8080)
EXPOSE 8080
# nah ini perintah untuk jalanin serverya ya, biasnaya emang ska di pake di cmd
CMD go run app/main.go