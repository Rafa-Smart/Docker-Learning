package main

import (
	"fmt"
	"net/http"
	"os"
)

func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Hello World")
}

func main() {
	port := os.Getenv("APP_PORT");
	fmt.Println("Run app in port: "+port)
	http.HandleFunc("/", HelloServer)
	http.ListenAndServe(":"+port, nil)
}

// nah jadi kita kan
// ngambil data env dari env ya, nah ingat env ini itu akan kita ambil dari env yang udah kita set di imagenya ya
// jadi ibsa pas kita buat iamgenya pake instrusi ENV atua bisa jga kita set pas buat containernya ya

// -------------


// bisa cek juga pake ini ya

// Rafa Khadafi@Rafa-Smart MINGW64 ~
// $ curl localhost:8080
// Hello World
// Rafa Khadafi@Rafa-Smart MINGW64 ~
// $
// tapi lewat bash atua terminal linx