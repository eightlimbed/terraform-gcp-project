// Simple app to be deployed on App Engine that uses the instance metadata
// server to demonstrate load balancing

package main

import (
	"fmt"
	"log"
	"net/http"
    "cloud.google.com/go/compute/metadata"
)

func main() {
	http.HandleFunc("/", handle)
	http.HandleFunc("/_ah/health", healthCheckHandler)
	log.Print("Listening on port 8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

type userAgentTransport struct {
    userAgent string
    base      http.RoundTripper
}

func (t userAgentTransport) RoundTrip(req *http.Request) (*http.Response, error) {
    req.Header.Set("User-Agent", t.userAgent)
    return t.base.RoundTrip(req)
}

func handle(w http.ResponseWriter, r *http.Request) {
    client := metadata.NewClient(&http.Client{Transport: userAgentTransport {
        userAgent: "lee",
        base: http.DefaultTransport,
    }})
    name, _ := client.InstanceName()
    id, _ := client.InstanceID()
    ip, _ := client.ExternalIP()

	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
    fmt.Fprint(w, "This message is server by %s [%s] at %s", name, id, ip)
}

func healthCheckHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "ok")
}
