# ADD adalah instruksi yang dapat digunakan untuk menambahkan file dari source ke dalam folder
# destination di Docker Image
# Perintah ADD bisa mendeteksi apakah sebuah file source merupakan file kompres seperti tar.gz,
# gzip, dan lain-lain. Jika mendeteksi file source adalah berupa file kompress, maka secara otomatis
# file tersebut akan di extract dalam folder destination
# Perintah ADD juga bisa mendukung banyak penambahan file sekaligus
# misalnya saya mau emnambhaakn semua file .txt di folder source di lapopt saya ke destination si image, maka itu ia, berati *.txt
# Penambahan banyak file sekaligus di instruksi ADD menggunakan Pattern di Go-Lang :
# https://pkg.go.dev/path/filepath#Match

# jadi kita bisa nambahin file dari lapotp kita atau file dari url kedalam file destionation yang ada di imge dockerya ya

# formtnya
# Instruksi ADD memiliki format sebagai berikut :
# ADD source destination
# Contoh:
# ADD world.txt hello # menambah file world.txt ke folder hello di image
# ADD *.txt hello # menambah semua file .txt ke folder hello di image

# nah kalo *.txt / world.txt
# berati ini artinya dia sejajar dengna file Dockerfilenya ya

# nanit pas uhda di build kita bisa pake ini untuk cat atau lihat isi dari fil world.txt
# ini artinya kita override ya si cammand, inagt command itu hanya satu jad bisa di override

 docker run --name testduluguys  khadafi/testlagi cat hello/world.txt