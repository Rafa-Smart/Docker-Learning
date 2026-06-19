Secara default, saat Container mati, maka Docker tidak akan menjalankan lagi Container nya
Kita harus menjalankan lagi Container nya secara manual
Kita bisa memaksa sebuah container untuk selalu melakukan restart jika misal terjadi masalah
pada Container nya
Kita bisa tambahkan attribute restart, dengan beberapa value :
no: default nya tidak pernah restart
always: selalu restart jika container berhenti /  error  jaid pas restart laptop lalu nyaain docker maka akan otomatis nyala nih si cntainernya
on-failure: restart jika container error dengan indikasi error ketika exit
unless-stopped: selalu restart container, kecuali ketika dihentikan manual