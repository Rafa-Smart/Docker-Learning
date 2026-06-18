# jadi kitajga bisa masukan env kedalma si continernya ya

# bisa pake env file atau bisa  juga kita deklarasikan langsung

# 1.file
env_file:
  - path: ./default.env
    format: raw

# 2.langsung gaya map
environment:
  RACK_ENV: development
  SHOW: "true"
  USER_INPUT:

# 3.langsung gaya array syntax
environment:
  - RACK_ENV=development
  - SHOW=true
  - USER_INPUT


# NAHH INI ENTING BANGET NIH
# JADI SEBENRYA ENV ITU DI SIMPANNYA DIDALMA CONTIENRNYA YA
# JADI PAS RUN DOCKER NYA

# NAH KALO KITA NARUH ENV DI IMAGE IT BERATI KTIA LAGI NARUH ENV DEFAULTNYA YA

# ADI PAS KITA NARUH ENV DI CONTAINER ATAU DI ONTINER COMPOSE, ITU NANTI DI CONTIAENR TERSBEUT KTIA IBSA AKSES SI ENVNYA DNA ENG HARUSNYA DI TARUH DI SI CONTAIENRYA YAA

# KARENA YANG DI IAMGE ITU HANYA NILAI DEFAULNTYA SAJA