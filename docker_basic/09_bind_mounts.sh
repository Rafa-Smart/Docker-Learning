# Bind Mounts merupakan kemampuan melakukan mounting (sharing) file atau folder yang terdapat
# di sistem host ke container yang terdapat di docker

# Fitur ini sangat berguna ketika misal kita ingin mengirim konfigurasi dari luar container, 

# atau conoh kedua misal
# menyimpan data yang dibuat di aplikasi di dalam container ke dalam folder di sistem host
# Jika file atau folder tidak ada di sistem host, secara otomatis akan dibuatkan oleh Docker
# misalnya ketika kita buat service atua process databse di containernya iaslnya
# tpi kti ingin agar process itu di simpan atau dataya di simpa di folder host / laptop kita
# jdadi kalo di hapus contianernya maka datnaya akna tetap ad adi foler kita


# Untuk melakukan mounting, kita bisa menggunakan parameter -- mount ketika membuat container
# Isi dari parameter -- mount memiliki aturan tersendiri

# Parameter

# type : Tipe mount, bind atau volume
# source : Lokasi file atau folder di sistem host
# destination : Lokasi file atau folder di container
# readonly : Jika ada, maka file atau folder hanya bisa dibaca di container, tidak bisa ditulis

# jadi source itu maksudany adalhktia bisa sharing folder di hostke destinasi atau folde yang ad adi contianerya
# dan kita juta bsa nambahin readonly, jadi foldernya hanya bisa di baca aja dari contianerya, karena defaultnya bisa di ubah ubha

# Untuk melakukan mounting, kita bisa menggunakan perintah berikut :
docker container create --name namacontainer --mount
"type=bind,source=lokasi-folder-host,destination=lokasi-folder-container,readonly" image:tag


# oke jadi gini, studi kasusnaya adalah, saya mau buat contianer pake image redis yang dimana data yang di crud kan di contianer ini mau saya simpan di laptop saya juga
# caranya adlaha, 
# 1.cari dulu dimana tempat si image redis menyimpan data dataya cari aja di docker hubnya
# disini itu dari dokumentaisnya ada $ docker run --rm -v /your/host/path:/data redis chown -R redis:redis /data

# maka berait redis imge menyimpan datanya itu di folder /data
# contoh 
docker container create --name rediss -p 3000:6379 --memory 100m --cpus 1 --mount "type=bind,source=C:\DATA-DATA-PEMBELAJARAN-PEMROGRAMAN\CIOUD_LEARNNG\Docker-Learning\redis_data,destination=/data" redis:latest

# untuk cek
docker inspect rediss

# nah kalo di redis itu kan dia akna selalu simpan kedalma memory dulu ya, jadi hrus ktaketiakn save du dalma redis-cli (seelah masuk ke exec ya)
# maka akna masuk deh data nya di folder kita

# 3. dna ini tuh kerneny gini
# jadi ketika kita hapus contianer rediss ini misalny
# /maka datanya tidak akan hilnag karea suhda di simpan di dalam lapotp kita
# jadi kita tinggal buat lgi ontainerya pake pernth yang ini docker container create --name rediss -p 3000:6379 --memory 100m --cpus 1 --mount "type=bind,source=C:\DATA-DATA-PEMBELAJARAN-PEMROGRAMAN\CIOUD_LEARNNG\Docker-Learning\redis_data,destination=/data" redis:latest
# agar sama ya, lalu ktia bisa lihat datnaya tiak akan hlang
# begitu jgua kalo pake atabase mongo db, mysql dll

# jadi kaya dua arah gitu deh