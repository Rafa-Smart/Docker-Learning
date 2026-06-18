# 1.jadi gini, satu docker image itu bsia di membaut docker container berkali kali dnegna syarat
# nama containernya harus beda dan tidak boleh sama
# NAH, kalo kita udah buat docker container dari suatu docker iamge, maka docker image tersebut tiak akan bisa di apus ya
# jadi masih terikat gitu, jadi kalo mau itu harus hapus dulu sicontainreya baru hapus si imagenya

# 2.jaid contiane it defultnya akan memiliki status tidak runing ya, jadi harus dinyalain dulu baru bisa jaln 
# nah utnuk lihat sleuruh status dockeer
docker container ls -a
# tapi kalo ma ihat yang lagi jalan aja, bisa pake 
docker container ls

# 2.cara buat container
docker container create --name namaContainer namaImage:tag
# kalo kita buat contiaenr tapi beleum punya imagenya, maka nanti akan otomatis di downloadkan
# nah kita engga bisa buat contiaenr pake banyakimage ya
# karena 1 Container = 1 Main Process

# jadi nanti itu kita bisa manage banyak service pake docker compose ya
services:
  nginx:
    image: nginx

  php:
    image: php:8.3-fpm

  mysql:
    image: mysql:8

# 3.cara jalanin contianernya
docker container start namaContainer/idContainer


# 4.nah untuk hapus continer itu kita wajib dan perlu untuk stop dulu si contianrya jangan sapai masih start
# baru bsa di hapus
docker container stop namaContainer/idContainer