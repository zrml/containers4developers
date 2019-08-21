package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
	var input string
	// fmt.Scanln(&input)

	if len(os.Args) != 2 {
		input = "http://www.google.com"
	} else {
		input = os.Args[1]
	}

	resp, err := http.Get(input)
	check(err)

	body, err := ioutil.ReadAll(resp.Body)
	check(err)

	fmt.Printf("Page size:\n%d bytes\n%dKB \n", len(body), (len(body) / 1024))
}

func check(err error) {
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
