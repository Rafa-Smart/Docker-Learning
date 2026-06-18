# VOLUME merupakan instruksi yang digunakan untuk membuat volume secara otomatis ketika kita
# membuat Docker Container
# Semua file yang terdapat di volume secara otomatis akan otomatis di copy ke Docker Volume,
# walaupun kita tidak membuat Docker Volume ketika membuat Docker Container nya
# Ini sangat cocok pada kasus ketika aplikasi kita misal menyimpan data di dalam file, sehingga data
# bisa secara otomatis aman berada di Docker Volume

# nahh jadi ini tuh cocok banget ya, karena seperti yang udah kita tau
# defaultnya kalo kita buat continer, itu kalo kita engga mount ke volume
# maka kita akan suhda di batkan volumenya otmatiss yaa
# nah disi kita akn cari tau gimana carnaya ketika image kita di buat container, aka akna di buatkan volumenya otomatis

kareana kalo engga pake volume instruction ini, maka engga kana i batakn otomatis ya

# jadi kan nnati ktia deklarasikan semua file di iamge ini yang mau kita connectkna atau masuakn ke volume
# maka semue file it akan langsug di copy ke dalma volume ya

Berikut adalah format untuk instruksi VOLUME :
VOLUME/lokasi/folder
VOLUME/lokasi/folder1/lokasi/folder2 ...
VOLUME ["/lokasi/folder1","/lokasi/folder2"," ... "]