# Instruksi LABEL merupakan instruksi yang digunakan untuk menambahkan metadata ke dalam
# Docker Image yang kita buat
# Metadata adalah informasi tambahan, misal seperti nama aplikasi, pembuat, website, perusahaan,
# lisensi dan lain-lain
# Metadata hanya berguna sebagai informasi saja, tidak akan digunakan ketika kita menjalankan
# Docker Container

# Berikut adalah format instruksi LABEL
# LABEL <key> =< value>
# LABEL<key1> =< value1><key2> =< value2> ...

# jaid nanti cara ceknya adalh menggunkna docker image inspect namaImage
# nani aakan ada array yang isinya label label yang ita sudha buat