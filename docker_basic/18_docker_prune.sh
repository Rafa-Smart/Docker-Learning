# jaid ini adlah fitur  yang bisa kita pake untuk bisa membersihkan hal hal yang memang tidakdi gunakna laig di docker

# jadi hampir semua perintha di docker itu menggunakan prune

# mislanya untuk hapus semua contianer yng lagi stop
# kit bisa pake perintha 
docker container prune

# atua hpus volume / network / image yang tidka di gunakna oleh conainer maka pake
docker volume/network/image prune

# atau hapus smeua yang engga ke pake
docker system prune