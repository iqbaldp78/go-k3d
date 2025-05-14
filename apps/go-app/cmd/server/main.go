package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

func handler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
	fmt.Fprintf(w, "hay dude dont let me down 6 test Hello from Go with Reflex! Hot reloading is working! Updated at %s", time.Now().Format(time.RFC3339))
}

func main() {
	http.HandleFunc("/", handler)
	log.Printf("Server starting on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
