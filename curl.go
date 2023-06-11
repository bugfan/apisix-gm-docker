package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
)

type A struct {
	Cert  string   `json:"cert"`
	Key   string   `json:"key"`
	Certs []string `json:"certs"`
	Keys  []string `json:"keys"`
	Snis  []string `json:"snis"`
	Gm    bool     `json:"gm"`
}

func main() {
	cert, _ := ioutil.ReadFile("./t/certs/server_enc.crt")
	key, _ := ioutil.ReadFile("./t/certs/server_enc.key")
	scert, _ := ioutil.ReadFile("./t/certs/server_sign.crt")
	skey, _ := ioutil.ReadFile("./t/certs/server_sign.key")

	a := &A{
		Cert:  string(cert),
		Key:   string(key),
		Certs: []string{string(scert)},
		Keys:  []string{string(skey)},
		Gm:    true,
		Snis:  []string{"domain"},
	}
	data, _ := json.Marshal(a)
	fmt.Println("data:", string(data))
}
