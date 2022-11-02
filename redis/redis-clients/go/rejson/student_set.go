package main

import (
	"fmt"
	"log"

	"github.com/nitishm/go-rejson/v4"
)

func SetStudent(rh *rejson.Handler, studentKey string) {

	student := Student{
		Name: Name{
			"Markd",
			"Sd",
			"Prontoa",
		},
		Rank: 1,
	}
	fmt.Println("Setting up a new student into the redis instance...")

	res, err := rh.JSONSet(studentKey, ".", student)
	if err != nil {
		log.Fatalf("Failed to JSONSet")
		return
	}

	if res.(string) == "OK" {
		fmt.Printf("Success: %s\n", res)
	} else {
		fmt.Println("Failed to Set: ")
	}

}
