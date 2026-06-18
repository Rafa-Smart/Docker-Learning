Sebelumnya untuk membuat container, kita selalu menggunakan perintah docker create
Namun sekarang kita bisa buat container hanya menggunakan configuration file di Docker
Compose
Pada file yaml, kita bisa tambahkan bagian services untuk menentukan container-nya
Dalam service tersebut, kita bisa tentukan container name dan image untuk docker container yang
akan kita buat






# jadi nanit di dalam services ini kita bsa tetuka container apa aja yang mau kita jalankan 
# bisa lebih dari satu ya, dan ki tabsia jalaninya sekaligus
# tapi defutlnya itu engga langsung jalan ya, jadi harus di star dulu pake perintah yang khusus juga, jadinya sleurhnya akna lanusng otomatis dijalanakn sekaligus seluruhnya

# ini dalma format yml ya



# nah PENTING
# defaltnya tu kalo engg aksih nama, maka nanit nama projeknya akan sama dengn nama fodlder yang mempunyai file .yml si docker commposenya ini ya
# dan syaratnya adalah
# nama file compose ini harus
# docker-compose.yml

version: "3.8"

services:
  nginx-example:
#   nah ushakan nama containerya itu harus sma nena nama contianer yang contiaenr_name ini ya
    container_name: nginx-example
    image: nginx:latest


# nah ntuk membuatnya itu kita tingal masuk saja e dalam folder yang berisi file dockercompose.yml ini
# setelah itu kita baru ketikan perintah
docker compose create