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


# 2. dna untuk menjalankanya itu menggunakna peritha
docker compose start
# karena deaulntya seelh kita buat itu engga langsung jaalan si contianerya ya

# 3.untuk menstopnya itu menggunakan perintah
docker compose stop
# maka semuanya akna di stop di file compsoeyang lagi di runningy ya


# dan fun fact, docker composer itu akan selalu mengunakan cache ya
# adi kalo si dockernya tau isi file ini engg aberubah maka engga akna di buat lagi ya, 

# dan kalo ada satu file isiny stu contianr lalu buat, lalu kita edit lagi filenya tapi hanya nambahin contaienr baru untuk di create
# maka docker tidak akna membuat container pertam lagi tapi hanya mmebuat container yang kedua nya saja

# jdia akan lebih hemat dna suhda piner nih s dockernya 

# 4. kita bisa ihat daftar compose yng jalan dan tidka jalan ya ingat hanaya liht cnntianre yang di buat di compose di ile tersebut ya ya bukan yan lainnya pake perintha 
docker compose ps

# 5menghpaus container 
# Jika kita sudah tidak butuh lagi container yang terdapat di file konfigurasi, kita bisa menghapusnya
# Kita bisa hapus secara manual menggunakan perintah docker container rm, atau menggunakan
# Docker Compose
# Untuk menghapus container menggunakan Docker Compose, kita bisa gunakan perintah :
docker compose down
# Secara otomatis semua Container dan Network dan Volume yang digunakan oleh file configuration nya
# tersebut akan dihapus da kalo lagi berjalan itu oomatis kan di stop baru akan di hapus