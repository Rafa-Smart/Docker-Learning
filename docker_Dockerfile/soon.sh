# jadi ini itu isinya adlah kode kode instruksi dan ada format penulisannya
# jadi docker file in itu agar kita bisa mmebuat docker image secara custom ya

# Untuk membuat Docker Image dari Dockerfile, kita bisa menggunakan perintah docker build.
# Saat membuat Docker Image dengan docker build, nama image secara otomatis akan dibuat
# random, dan biasanya kita ingin menambahkan nama/tag pada image nya, kita bisa mengubahnya
# dengan menambahkan perintah -t
# Misal berikut adalah contoh cara menggunakan docker build :

# docker build -t khadafi/app:1.0.0 folder-dockerfile
# ada bebrapa yang perlu di perhatikan
# 1.nah kalo dia engga ada tagnya, maka otomatis kana jadi latest
# 2.nah kalo misalnya nama akun kita itu adalah khadafi, maka nti setleh -t itu haru pake nama akunnya ya
# jaid nanit nama image yang akna di haislkan adalah khadafi/app:1.0.0
# 3. setealh tag itu adalah folder dimana Dockerfile nya berada, nahh, jadi didalam folder itu hanya boleh ada satu file tnapa extensi yang bernama Dockerfile ya, sebernnay bis aja sih beda, ya namanya tidka Dockerfile, tpai ini ebst practice  

# contoh dua
# docker build -t khadafi/app:1.0.0 -t khannedy/app:latest folder-dockerfile
# ktia juga bisa membaut docker iamge bebrapa kali sekaligus berdasaarkan satu Dockerfile
# msailnya kti buat di folder 1_from ya
# FROM alpie:latest
# maka perintahnya adlah
docker build -t khadafi/simple  

# fungsi dari -t adalah untuk ngaish nama ya, karena defaultnya namanya itu akan random