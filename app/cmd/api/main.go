package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "¡Servidor Go funcionando!")
	})

	http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("OK"))
	})

	// Construimos la dirección correctamente: ":" + "8080" = ":8080"
	addr := ":" + port
	log.Printf("Arrancando el servidor en el puerto %s...", port)

	// Esto bloquea el programa y lo mantiene vivo eternamente
	err := http.ListenAndServe(addr, nil)
	
	// Si llega a esta línea, es que ListenAndServe falló inmediatamente.
	// log.Fatal imprime el error y fuerza la salida (Exited 1).
	if err != nil {
		log.Fatalf("Error crítico al arrancar el servidor: %v", err)
	}
}