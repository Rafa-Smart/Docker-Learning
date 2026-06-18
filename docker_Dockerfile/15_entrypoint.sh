# ENTRYPOINT adalah instruksi untuk menentukan executable file yang akan dijalankan oleh
# container
# Biasanya ENTRYPOINT itu erat kaitannya dengan instruksi CMD
# Saat kita membuat instruksi CMD tanpa executable file, secara otomatis CMD akan menggunakan
# ENTRYPOINT

# soanya pas di cmd itu kan kita ada yang pake ['', '']
# nah nilai pada array index ke 0 adalh executablenya kan, baru setelahnya argumen argumennya
# nah kalo di cmdnya kita ga kasih execuablenya, maka akna ngambil dari entrypoint

# Berikut adalah format untuk instruksi ENTRYPOINT:
# ENTRYPOINT ["executable","param1","param2"]
# ENTRYPOINT executable param1 param2
# Saat menggunakan CMD ["param1", "param2"], maka param tersebut akan dikirim ke
# ENTRYPOINT

# jaid kalo ada entry point  ["executable","param1","param2"]
# lalu di cmd ada CMD ["param1", "param2"], maka param tersebut akan dikirim ke
# ENTRYPOINT 
# jadi urutanya akan 
# ENTRYPOINT ["executable","param1(entry)","param2(entry)", "param1(cmd)", "param2(cmd)"]
# conothnya FROM golang:1.18-alpine

RUN mkdir /app/
COPY main.go /app/

EXPOSE 8080
ENTRYPOINT ["go", "run"]
CMD ["/app/main.go"]

# maka akna jadi go run /app/main.go