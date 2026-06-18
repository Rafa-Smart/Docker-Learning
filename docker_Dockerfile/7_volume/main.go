package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, %s", r.URL.Path[1:])

	dataString := "Hello " + r.URL.Path[1:]
	dataBytes := []byte(dataString)

	destination := os.Getenv("APP_DATA")
	file := destination + "/" + r.URL.Path[1:] + ".txt"

	err := ioutil.WriteFile(file, dataBytes, 0655)
	if err != nil {
		panic(err)
	}

	fmt.Println("DONE Write File : " + file)
}

func main() {
	port := os.Getenv("APP_PORT")

	fmt.Println("Run app in port : " + port)

	http.HandleFunc("/", HelloServer)

	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		panic(err)
	}
}