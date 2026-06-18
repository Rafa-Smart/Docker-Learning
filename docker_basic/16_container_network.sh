# nah jadi setelh ktia buat networkdnya, maka kita juga bsa untuk memasukan autau mengconnectkan container
# kedalam container itu ya  
# nah contianer bisa saling berhubungan dnegna contiaenr nlain degna hanya menyebutkan nmaConitaner yang mau di hubungi ya

# contoh kita akan buat dua container yang nantinya akna bisa berhubugnan, yaitu mongo d dan mongo express
# jadi mongo express ini adlah web yg akan bisa melihat data dari mongo db

# nah ktia juga bisa membuat contianer sekaligus memasuakn ontiner ini ke dalam network ya, dengan cara ini

docker container create --name namaContainer --network namaNetwork iamge:tag


# OKE INI STUDY KASUS YA

# /jadi disni saya ga pake publish karena ingin aksesna itu di mongo-expressnya saja
docker network create --driver bridge mongo-network

docker container create --name mongo_db --network mongo-network -e MONGO_INITDB_ROOT_USERNAME="rafa" -e MONGO_INITDB_ROOT_PASSWORD="12345"  mongo:latest


# nahh utnuk config si mongo express dengna si mongonya itu pas kita buat contianer mongo-expressnya
# kita perlu namahin env ya yaitu
ME_CONFIG_MONGODB_URL=mongodb://(usernya):(password)@(namaContainer yg satu network):(port CONTAINERNYA SI MONGO BUKAN PORT YANG DI PUBLISH DAN BUKAN PORT DARI SI MONGO EXPRESS BISA DEFAULT DARI CONTIANERNYA JUGA BISA, KARENA DEFAUL DARI MONGO ITU 27017 MAKA BISA PAKE IT AJA)/
# user dan password ini itu ada pas kita buat container nya ya di env nya

docker container create --name mongo_db_express --network mongo-network --publish 8081:8081 -e ME_CONFIG_MONGODB_URL="mongodb://rafa:12345@mongo_db:27017/" mongo-express:latest

# brau start semuanya 
docker container start mongo_db
docker container start mongo_db_express

# gini, karena pas buat image si mongo-express kita enga masukin ini
-e ME_CONFIG_BASICAUTH_USERNAME="username nanit untuk login"
-e ME_CONFIG_BASICAUTH_PASSWORD="username nanit untuk login" 

# maka defaulntya itu adlah admin dan pass

# cek aja gini
docker logs mongo_db_express


# 3.cara untuk mendisconnect container dari network
docker network disconnect namaNetwork namaContainer

# 4.cara untuknambahin contianer yang udah di buat ke network pake
docker network connect namaNetwork namaContainer