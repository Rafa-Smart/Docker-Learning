# COPY adalah instruksi yang dapat digunakan untuk menambahkan file dari source ke dalam folder
# destination di Docker Image
# Lantas apa bedanya dengan instruksi ADD kalo begitu?
# COPY hanya melakukan copy file saja, sedangkan ADD selain melakukan copy, dia bisa
# mendownload source dari URL dan secara otomatis melakukan extract file kompres
# Namun best practice nya, sebisa mungkin menggunakan COPY, jika memang butuh melakukan
# extract file kompres, gunakan perintah RUN dan jalankan aplikasi untuk extract file kompres
# tersebut


# jadi copy itu hanya copy source bulat bulat ya
# kalo add, dia bisa copy source, download source dari url, dan kalo ada yang zip / file compress, maka akan otomatis di extrak

# Instruksi COPY memiliki format sebagai berikut :
# COPY source destination
# Contoh :
# COPY world.txt hello # menambah file world.txt ke folder hello
# COPY *. txt hello # menambah semua file .txt ke folder hello
# an bisa pake pattern match pae golang ya