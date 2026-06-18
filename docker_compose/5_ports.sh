# nah ini juga banyak ya dari inernet ata yang ad di dokumentasinya lengka bange

# jadi ada yang pake cara simple
ports:
  - "3000"
#   in yang bawah berai artinya ita akan publis ke port 8000 dari port 80
  - "3000-3005"
  - "8000:80"
  - "9090-9091:8080-8081"
  - "49100:22"
  - "8000-9000:80"
  - "127.0.0.1:8001:8001"
  - "127.0.0.1:5000-5010:5000-5010"
  - "::1:6000:6000"
  - "[::1]:6001:6001"
  - "6060:6060/udp"


# atau cara yang lebih lnegkapnya lagi
ports:
  - name: web
    target: 80
    host_ip: 127.0.0.1
    published: "8080"
    protocol: tcp
    app_protocol: http
    mode: host

  - name: web-secured
    target: 443
    host_ip: 127.0.0.1
    published: "8083-9000"
    protocol: tcp
    app_protocol: https
    mode: host


# dan ports ini selars ya sama image dn container_name

services:
  nginx-port1:
    image: nginx: latest
    container_name: nginx-port1
    ports:
      - protocol: tcp
        published: 8080
        target: 80

  nginx-port2:
    image: nginx:latest
    container_name: nginx-port2
    ports:
     - protocol: tcp
       published: 8081
       target: 80

  nginx-port3:
    image: nginx:latest
    container_name: nginx-port3
    ports:
     - 8000:80