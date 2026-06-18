package main

import (
	"fmt"
	"net/http"
)

func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Hello World")
}

func main() {
	http.HandleFunc("/", HelloServer)
	http.ListenAndServe(":8080", nil)
}

// bisa cek juga pake ini ya

// Rafa Khadafi@Rafa-Smart MINGW64 ~
// $ curl localhost:8080
// Hello World
// Rafa Khadafi@Rafa-Smart MINGW64 ~
// $
// tapi lewat bash atua terminal linx