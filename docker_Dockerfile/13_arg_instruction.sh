# ARG merupakan instruksi yang digunakan untuk mendefinisikan variable yang bisa digunakan oleh
# pengguna untuk dikirim ketika melakukan proses docker build menggunakan perintah -- build-arg
# keɣ=value
# ARG hanya digunakan pada saat proses build time, artinya ketika berjalan dalam Docker Container,
# ARG tidak akan digunakan, berbeda dengan ENV yang digunakan ketika berjalan dalam Docker
# Container
# Cara mengakses variable dari ARG sama seperti mengakses variable dari ENV, menggunakan
# ${variable_name}

# Berikut adalah format untuk instruksi ARG:
# ARG key # membuat argument variable
# ARG key=defaultvalue # membuat argument variable dengan default value jika tidak diisi