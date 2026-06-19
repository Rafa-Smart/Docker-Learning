Untuk melihat kejadian apa saja yang terjadi di Docker secara realtime, kita bisa menggunakan
perintah :
docker events
https://docs.docker.com/engine/reference/commandline/events/
Contohnya kita bisa memonitor kejadian yang terjadi pada sebuah contanier dengan perintah :
docker events --filter 'container=nama'

# jaid nanti pas dia di restart, di stop di start, maka akan ketahuan ya
# jadi cara pakenya itu kti jaalnin dulu peritah itu, nahh, nanit tinggal tunggu ajaa