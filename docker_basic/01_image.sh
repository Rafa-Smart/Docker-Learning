# 1.ini adlah perintha utnuk mengece apakah docker kita sudha berjalan atua belum
docker version


# 2.nah docker itu ada dua komponen ya,v yaitu client dna juga servernya yaitu docler deaemon
# dan mereka itu berinteraksi mengunakan rest api

# cara untuk liat apa aja image yang kitapunya, pake perintha 
docker image ls


# 3.nah jadi agar kita bisa download image orang lain yang uhda di sediakan bisa apke perintah ini
docker image pull namaImage/(redis):tag/versi
# kalo enga pake tagmaka kanalangusng otomatis download yang paling terbaru

# 4. nah mau hapus image
docker image rm namaImage/(redis):tag/versi

