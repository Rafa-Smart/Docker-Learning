# Saat kita membuat container di docker, secara default container akan saling terisolasi satu sama
# lain, jadi jika kita mencoba memanggil antar container, bisa dipastikan bahwa kita tidak akan bisa
# melakukannya
# Docker memiliki fitur Network yang bisa digunakan untuk membuat jaringan di dalam Docker
# Dengan menggunakan Network, kita bisa mengkoneksikan container dengan container lain dalam
# satu Network yang sama
# Jika beberapa container terdapat pada satu Network yang sama, maka secara otomatis container
# tersebut bisa saling berkomunikasi

# Saat kita membuat Network di Docker, kita perlu menentukan driver yang ingin kita gunakan, ada
# banyak driver yang bisa kita gunakan, tapi kadang ada syarat sebuah driver network bisa kita
# gunakan.
# bridge, yaitu driver yang digunakan untuk membuat network secara virtual yang memungkinkan
# container yang terkoneksi di bridge network yang sama saling berkomunikasi
# host, yaitu driver yang digunakan untuk membuat network yang sama dengan sistem host. host
# hanya jalan di Docker Linux, tidak bisa digunakan di Mac atau Windows
# none, yaitu driver untuk membuat network yang tidak bisa berkomunikasi

# jadi gini defaultnya pas kita buat contianer, itu networknya adalah none ya

# untuk lihat network
docker network ls

# 2.cara buat network
docker network create --driver bridge / host / none namaNetwork

# 3.untuk hapus, dan ini tuh ga bisa di hapus kalo masih ada contianer yng menggunakan netork ini ya, makanya stop dan hapus dulu contianernya

docker network rm namaNetwork