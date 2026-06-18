# Fitur Bind Mounts sudah ada sejak Docker versi awal, di versi terbaru direkomendasikan
# menggunakan Docker Volume
# Docker Volume mirip dengan Bind Mounts, bedanya adalah terdapat management Volume, dimana
# kita bisa membuat Volume, melihat daftar Volume, dan menghapus Volume
# Volume sendiri bisa dianggap storage yang digunakan untuk menyimpan data, bedanya dengan
# Bind Mounts, pada bind mounts, data disimpan pada sistem host, sedangkan pada volume, data di
# manage oleh Docker
# nah lebih baik pake cara ini yah

# Saat kita membuat container, dimanakah data di dalam container itu disimpan misalnya kaya mongo db kan da akna meyimpan data ya, nah secara default
# semua data container disimpan di dalam volume
# Jika kita coba melihat docker volume, kita akan lihat bahwa ada banyak volume yang sudah
# terbuat, walaupun kita belum pernah membuatnya sama sekali
# Kita bisa gunakan perintah berikut untuk melihat daftar volume :
# docker volume Is

# jaid pas kita buat docker container maka akan otomatis membuat docker volume untuk container tersebut dan data yang ada did contianer itu aakn di simpan di dalma docker volume

# kita juga bisa buat volume sendiri ya
docker volume create redisvolume
# jadi sebenrnya kita iu pas but contianer engga selalu baut volume ya
# dan keuntungan buat volume sendiri adalah kti bisa tau secara jelas ini itu volume untuk contianer yag mana

# Volume yang tidak digunakan oleh container bisa kita hapus, tapi jika volume digunakan oleh
# container, maka tidak bisa kita hapus sampai container nya di hapus, jadi harus stop dulu dan hapus si contianernya baru bia apus volumenya
# Untuk menghapus volume, kita bisa gunakan perintah :
# docker volume rm namavolume
