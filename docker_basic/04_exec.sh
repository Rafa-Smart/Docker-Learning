# jadi pas kita buat contianer itu, maka si palikasinya  yang aa di contianernya itu hanya bisa di akses oleh env yang ada di dalma contianernya itu sendri, maka kita harus masuk ke dalam contianernya itu, untuk melihat atau mengakses dan mengeksekusi kode progrma yang ada di contiaenrya
# docker exec adalah perintah untuk menjalankan proses baru di dalam container yang sudah berjalan.

# 1.jaid gini, docker exec itu adalh perinah untuk memasukaan sebuah process kedalam continar y, yang dimana process ini tuh bisa mengekseksi hal ha yang ada didalma contianrya ini, karean ingat kalo container itu terisolasi ya
# jaid dia bia akese terminal, env dll, misanyakita punya conianer laravel, nah kita ingin eksekusi perintah php artisan serve / migrasi / dll
# nah kita perlu masuk dulu ke continernya, baru kitaakna di beri akses utnuk eksekusi hal hal tersebut

# nah kalo suhda beres kita bisa ketik exit untuk keluar, dan nantinya process bash ii akna di keluarkan dari contianerya ya
# jadi ini tuh engga permanent

# docker exec nginx-server pwd
# docker exec nginx-server ls
# docker exec nginx-server cat test.txt
# 1. Buat process baru
# 2. Jalankan command
# 3. Tampilkan output
# 4. Process selesai
# 5. Process dihapus
#  bedanya degan 

# docker exec -it nginx-server bash adalah

# kalo yang engga pake -it itu dia sekali process aja ya jadi pas procesnya udah beres maka proess tersbut aka di hilangkan lagi dari contaienry, tapi kalo yang pake -it itu dia kan asuk ya seolah olah masuk, jadi dia bisa masukin beberapa perintah samapi ketik exit / Ctrl+D

# -it itu adalh dua flag ya, yaitu :
# -i : Interactive, Jangan tutup STDIN, Artinya bash masih bisa menerima input keyboard.
# -t : TTY (terminal) Docker membuat terminal virtual.
# bash / sh itu adalh kode program yang ada didalam continer yang bsia kita akses, /bin/bash






