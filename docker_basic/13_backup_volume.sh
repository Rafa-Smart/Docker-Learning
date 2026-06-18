# car utnuk lihat lokasi volume

docker volume inspect namaVolume

# Sayangnya, sampai saat ini, tidak ada cara otomatis melakukan backup volume yang sudah kita
# buat
# Namun kita bisa memanfaatkan container untuk melakukan backup data yang ada di dalam volume
# ke dalam archive seperti zip atau tar.gz
# jadi kita akn buat container, lalu kita archive datnaya, lalu arcvhivenya akan di simpan di bind mountnya


# TAHAPAN TAAHAPAN UNTUK BACKUP
# Matikan container yang menggunakan volume yang ingin kita backup
# Buat container baru dengan dua mount, volume yang ingin kita backup, dan bind mount folder dari
# sistem host
# Lakukan backup menggunakan container dengan cara meng-archive isi volume, dan simpan di bind
# mount folder
# Isi file backup sekarang ada di folder sistem host
# Delete container yang kita gunakan untuk melakukan backup

# tapi ada cara yang lebih mudah, jadi pake perintah
run bukan create agar otomatis remove etelha bers ya
# tpi ignat ketiak backup itu si container dan volumenya usahakan mati dulu ya

docker container run --rm 

# nah jadi igni untuk destioanton itu bebas ya namanya apa aja juga gapapa
# karena gini 
# Di Docker ada 2 dunia:

# HOST (komputer kamu)
# CONTAINER (filesystem dari image)

# Mount itu hanya:

# MENYAMBUNGKAN folder host ke folder container

# Bukan “mengikuti aturan image”.
# "kalau container akses /folder_ini,
#  arahkan ke storage ini"


docker run --rm `
# nama volume ya lalu isi nya dimasukan ke folde /data
  -v redisvolume:/data ` 
# Folder di Windows:
# C:/DATA-DATA-PEMBELAJARAN-PEMROGRAMAN/.../backup-redis
#         ↓
# dipasang ke container sebagai:
#         ↓
# /backup
  -v C:/DATA-DATA-PEMBELAJARAN-PEMROGRAMAN/CIOUD_LEARNNG/Docker-Learning/backup/backup-redis:/backup `
#   lalu nama imagenya
  alpine:latest `
#   nah ini itu relative ya, jadi kan ita udah ada di docker-leaning, aanya tinggal asuk ke /backup
  sh -c "tar czf /backup/redis-backup.tar.gz -C /data ."

# jaid isi dri -v adlah
# -v [source]:[destination]

# tanda ^ atau ` artinya adalah
"command ini belum selesai, lanjut di baris berikutnya"

# INAGT JANGNA EPRNAH JALANIN DOCKER RU DIALMA EXEC CONTAINER YA NATI ERROR

docker run --rm -v redisvolume:/data -v C:/DATA-DATA-PEMBELAJARAN-PEMROGRAMAN/CIOUD_LEARNNG/Docker-Learning/backup-redis:/backup alpine sh -c "tar czf /backup/redis-backup.tar.gz -C /data ."


# TPI GINI, SEKARNG MAH UDAH AD AYA BACKUP OOTMATIS, CARANYA TINGAL KE VOLUME TERUS EXPORTS