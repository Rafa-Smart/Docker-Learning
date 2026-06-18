# HEALTHCHECK adalah instruksi yang digunakan untuk memberi tahu Docker bagaimana untuk
# mengecek apakah Container masih berjalan dengan baik atau tidak
# Jika terdapat HEALTHCHECK, secara otomatis Container akan memili status health, dari awalnya
# bernilai starting, jika sukses maka bernilai healthy, jika gagal akan bernilai unhealty

# jaid buat ontianer itu sebenrnya dfaulnta adalh tidka ada healtehceknya ya 


# Berikut adalah format untuk instruksi HEALTHCHECK:
# HEALTHCHECK NONE # artinya disabled health check
# HEALTHCHECK [OPTIONS] CMD command
# OPTIONS:
# -- interval=DURATION (default: 30s) -> artinya seberapa sering si oantinr ini di cek kesehatnanya
# jadi per 30 detik akan selu di cek
# -- timeout=DURATION (default: 30s) -> jika ggla perintahnya selma 30 maka di batlakan
# -- start-period=DURATION (default: Os) -> 
# -- retries=N (default: 3)

 