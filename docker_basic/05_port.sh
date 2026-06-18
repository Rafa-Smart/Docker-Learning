# biasanya sebuah aplikasi berjala di port tertent kan, nah kita bisa port apa ajayang di pake ketika melihat semau dafar contianer

# pake perintha docker container ls -a
# dan ingat ya, penitng!

# jadi port ini tuh udha erisolasi di satu contaier ini doang ya
# jadi klao kta akses port itu di locahost kita, maka tidak aakn calan ya

# 1.port forwading
# jadi kita bisa akses port yang ad adi contiaenr ini ke localhost pake cara port forwading
# jadi meneruskan sebuah port yang terdapat di sistem host laptop kita kedalam docker contianerya
# nah cara ini iut cocok jika kit aingin mengekspos port yang ad adi caontiaer agar bisa ke uar dan bia di akases oleh hiost laptop kita

# jadi intinya adalh ketiak kita buka port yang ada di host kita, maka port ini akan di teruskn kedalma port yang ada di containerya ya
# jadi dari host ke contianer, bukan dari conine ke host

# 2.cara buat port forwading
# syaranya adlah perinth ini harus di gunakan ketika membuat container ya
# jadi kalo dah buat contiaenr tapi lupa masukin peirntha ini maka harus buat ulang dulu cntianerya
docker container create --name namaContainer --p / --publish portHostnya:portContainernya namaImage:tag
# nah di port contianernya ini kita arus tau ya port berapa, janga sampe salah
# misalnya nginx itu dia kana pake port 80
# jadi misalnya
docker container create --name contohnginx -p 3000:80 nginx:latest
# jadi pas kita akses port 3000 maka akan masuk ke port 80 si nginxnya ya
# inagt aksesynya janga 0.0.0.0:3000, tpai localhost:3000