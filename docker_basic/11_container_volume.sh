# Volume yang sudah kita buat, bisa kita gunakan di container
# Keuntungan menggunakan volume adalah, jika container kita hapus, data akan tetap aman di
# volume
# Cara menggunakan volume di container sama dengan menggunakan bind mount, kita bisa
# menggunakan parameter --mount, namun dengan menggunakan type volume dan source nama
# volume

# jadi yang bedanya itu adalah 
# 1.typenya adalah volume bukan bind
# 2.sourcenya bukan lagi folder di host kita, tapi nama volumenya
# 3.untuk destination dan readonly nya mah sama aja yaa

# jadi buat dulu volumenya duu, baru buat contianernya
# dan di butnya pas create container ya
docker container create --name rediss -p 3000:6379 --memory 100m --cpus 1 -e nama="rafa" -e pass="123" --mount="type=volume,source=redisvolume,destination=/data" redis:latest

# lalu pas kit masukin data pake exe dulu baru ke redis-cli lalu set data lalu ketik save
# maka ktia bisa cek di volume untuk datanya yaaaa

# dan sama ya, kalo kt hapus continernya lalu kti pake perintah yang sama pas bat contienrnya, maka datnaya tidak akan hilang ya, keren banget

