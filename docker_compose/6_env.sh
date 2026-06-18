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
