# WORKDIR adalah instruksi untuk menentukan direktori / folder untuk menjalankan instruksi
# RUN, CMD, ENTRYPOINT, COPY dan ADD
# Jika WORKDIR tidak ada, secara otomatis direktorinya akan dibuat, dan selanjutnya setelah kita
# tentukan lokasi WORKDIR nya, direktori tersebut dijadikan tempat menjalankan instruksi
# selanjutnya
# Jika lokasi WORKDIR adalah relative path, maka secara otomatis dia akan masuk ke direktori dari
# WORKDIR sebelumnya
# WORKDIR juga bisa digunakan sebagai path untuk lokasi pertama kali ketika kita masuk ke dalam
# Docker Container

# JADI KATA KNCINYA ADLAH WORKDIR
# nah jadi ini adalh folder root yang ada di container kita ya
# jadi appaun yang akna ita lakukan pad directory, maka akan sellalu di mlai di WORKDIR ini ya
Berikut adalah format untuk instruksi WORKDIR :
WORKDIR /app # artinya working directory nya adalah /app

# nah kalo sebutkn lai workdir nya docker maka akna gini, jadi masuk ke workdir sebelumnya
WORKDIR docker # sekarang working directory nya adalah /app/docker
WORKDIR /home/app # sekarang working directory nya adalah /home/app

# seaidaninya waktu kita pake /app

# lalu sebutkan lagi
workdir /docker -> absolute path
# maka akan langusng ganti si workdirya jadi docker

# tapi kalo hanya docker 
workdir -> relative path
# maka akan jadi gini si workdirya jadi /app/docker


# karena gini, kalo absolute itu kan artinya ini adalh path paling awal ya
# tapi kalo rlative, artinya dia ngikutin dari path absolute yang sebelumnya / nerusin path absolute sebelumya 
# tandanya itu engg apake / (relative)  kalo pake / maka absolute