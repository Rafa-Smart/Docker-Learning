# Dalam konfigurasi Docker Compose, container disimpan dalam konfigurasi bernama services
# Kita bisa menambahkan satu atau lebih services dalam konfıgurasi file nya
https://docs.docker.com/compose/compose-file/compose-file-v3/#service-configuration-referenc
e

# contohnya
services:
  nginx-example:
    image: nginx:latest
    container_name: nginx-example
  mongodb-example:
   image: mongo:latest
   container_name: mongodb-example