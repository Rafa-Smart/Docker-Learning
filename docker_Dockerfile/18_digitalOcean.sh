# CLOUD & DOCKER ECOSYSTEM

Ketika membuat sebuah aplikasi, ada beberapa komponen yang terlibat:

1. Source Code (Kode Program)
2. Docker Image
3. Container Registry
4. Server / VPS / Cloud
5. CI/CD

Mari kita bahas satu per satu.
==================================================
1. SOURCE CODE
==================================================

Source Code adalah kode yang kita tulis.

Contoh:

- Laravel
- Go
- NodeJS
- Spring Boot
- Django

Misalnya:

main.go
app.js
index.php

Source Code belum bisa langsung dijalankan oleh Docker Hub.

Kita perlu mengubah source code menjadi Docker Image terlebih dahulu.
==================================================
2. DOCKER IMAGE
==================================================

Docker Image adalah "template" atau "cetakan"
untuk membuat container.

Analogi:

Source Code = Resep Masakan
Image       = Paket makanan siap masak
Container   = Makanan yang sedang dimasak

Proses:

Source Code
      |
      v
docker build
      |
      v
Docker Image

Contoh:

docker build -t 120509/go:v1 .

Hasil:

120509/go:v1

Image ini berisi:

- Binary aplikasi
- Library
- Dependency
- Environment yang dibutuhkan

Image belum berjalan.

Image hanya file/template.
==================================================
3. CONTAINER REGISTRY
==================================================

Container Registry adalah tempat menyimpan Docker Image.

Analogi:

Image       = Barang
Registry    = Gudang

Contoh Registry:

- Docker Hub
- GitHub Container Registry (GHCR)
- AWS ECR
- Google Artifact Registry
- DigitalOcean Container Registry

Alur:

docker build
      |
      v
Docker Image
      |
docker push
      |
      v
Registry

Contoh:

docker push 120509/go:v1

Image tersimpan di Docker Hub.
==================================================
4. DOCKER HUB
==================================================

Docker Hub adalah registry paling populer.

Fungsinya:

- Menyimpan image
- Membagikan image
- Versioning image
- Menjadi tempat download image

Contoh:

docker pull nginx

Docker akan mengambil image nginx
dari Docker Hub.

Docker Hub TIDAK menjalankan aplikasi.

Docker Hub hanya menyimpan image.
==================================================
5. VPS (VIRTUAL PRIVATE SERVER)
==================================================

VPS adalah komputer yang berada di internet
dan menyala 24 jam.

Biasanya berisi:

- CPU
- RAM
- Storage
- IP Public

Contoh:

CPU     : 1 Core
RAM     : 2 GB
Storage : 50 GB

Kita menggunakan VPS untuk menjalankan aplikasi.
==================================================
6. DIGITALOCEAN
==================================================

DigitalOcean adalah perusahaan cloud provider.

Mereka menyewakan VPS.

Produk paling terkenal:

Droplet

Droplet = VPS milik DigitalOcean

Contoh:

DigitalOcean
      |
      v
Droplet
      |
      v
Ubuntu Linux
      |
      v
Docker
      |
      v
Container

Jadi:

DigitalOcean bukan Docker Hub.

DigitalOcean adalah tempat menjalankan aplikasi.
==================================================
7. CLOUD PROVIDER
==================================================

DigitalOcean hanyalah salah satu cloud provider.

Contoh lainnya:

- AWS
- Google Cloud
- Microsoft Azure
- Alibaba Cloud
- Vultr
- Linode
- Hetzner

Semua menyediakan server.

Perbedaannya hanya fitur, harga,
dan skalanya.
==================================================
8. CONTAINER
==================================================

Container adalah instance yang sedang berjalan
dari sebuah image.

Image:
120509/go:v1

Jalankan:

docker run 120509/go:v1

Maka:

Image
  |
  v
Container

Container adalah aplikasi yang benar-benar
sedang berjalan.
==================================================
9. HUBUNGAN IMAGE DAN CONTAINER
==================================================

Satu Image bisa membuat banyak Container.

Contoh:

Image:
120509/go:v1

Container:

container-a
container-b
container-c

Semua berasal dari image yang sama.
==================================================
10. DEPLOYMENT MODERN
==================================================

Developer
    |
    v
GitHub
    |
    v
CI/CD
    |
docker build
    |
    v
Docker Image
    |
docker push
    |
    v
Docker Hub
    |
docker pull
    |
    v
DigitalOcean VPS
    |
docker run
    |
    v
Container Running
    |
    v
Website Online

Inilah alur yang paling sering digunakan
di perusahaan modern.
==================================================
11. CI/CD
==================================================

CI = Continuous Integration

Ketika code di-push:

git push

Maka otomatis:

- Testing
- Build
- Linting
- Security Check

dijalankan.

-----------------------------------

CD = Continuous Delivery/Deployment

Setelah build berhasil:

- Build Image
- Push Image
- Deploy ke Server

Semua otomatis.
==================================================
12. CONTOH DUNIA NYATA
==================================================

Saya membuat aplikasi POS Laravel.

1. Menulis code

Laravel Source Code

2. Build image

docker build -t rafa/pos:v1 .

3. Upload image

docker push rafa/pos:v1

4. Login VPS DigitalOcean

ssh root@ip-server

5. Download image

docker pull rafa/pos:v1

6. Jalankan

docker run -d -p 80:80 rafa/pos:v1

7. Website online

http://ip-server

atau

https://toko-saya.com
==================================================
RINGKASAN PALING PENTING
==================================================

GitHub
=
Tempat menyimpan source code

Docker
=
Teknologi container

Docker Image
=
Template aplikasi

Docker Container
=
Aplikasi yang sedang berjalan

Docker Hub
=
Tempat menyimpan image

DigitalOcean
=
Tempat menjalankan image

CI/CD
=
Otomatis build dan deploy

Alur Lengkap:

Source Code
     |
     v
GitHub
     |
     v
CI/CD
     |
     v
Docker Build
     |
     v
Docker Image
     |
     v
Docker Hub
     |
     v
DigitalOcean VPS
     |
     v
Docker Container
     |
     v
Website Online

Kalau kamu sedang belajar Docker dan CI/CD, urutan materi yang paling masuk akal selanjutnya adalah:

1. Docker Image
2. Docker Volume
3. Docker Network
4. Docker Compose
5. VPS Linux (Ubuntu)
6. Nginx Reverse Proxy
7. Domain & DNS
8. HTTPS (SSL/TLS)
9. GitHub Actions
10. CI/CD Deployment
11. Kubernetes (setelah Docker benar-benar paham)

Karena di perusahaan, alur sehari-harinya biasanya berakhir di:

Developer
   ↓
Git Push
   ↓
GitHub Actions
   ↓
Build Docker Image
   ↓
Push Docker Hub
   ↓
Deploy VPS
   ↓
Website Update Otomatis