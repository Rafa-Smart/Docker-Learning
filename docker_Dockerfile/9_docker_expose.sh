# EXPOSE adalah instruksi untuk memberitahu bahwa container akan listen port pada nomor dan
# protocol tertentu
# Instruksi EXPOSE tidak akan mempublish port apapun sebenarnya, Instruksi EXPOSE hanya
# digunakan sebagai dokumentasi untuk memberitahu yang membuat Docker Container, bahwa
# Docker Image ini akan menggunakan port tertentu ketika dijalankan menjadi Docker Container

# /jaidini mah cuma dokumentasi aja ya, sama kaya kalo kti mau cari tau 
# mialnya aplikasi image ini itu jalan di port berpa

# nanti pas di inspect akan ada ini ya
# "ExposedPorts": {
#                 "8080/tcp": {}
#             },

# dan biasnaya kita ga perlu pake /tcp karena defaultya udah itu ya
# tapi bias juga pake udp
# tapi biasnaya kalo web mah tcp    