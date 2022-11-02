package main

import (
	"fmt"
	"log"

	"github.com/gomodule/redigo/redis"
	"github.com/nitishm/go-rejson/v4"
)

func GetStudent(rh *rejson.Handler, studentKey string) {
	studentJSON, err := redis.Bytes(rh.JSONGet(studentKey, "."))
	if err != nil {
		log.Fatalf("Failed to JSONGet")
		return
	}
	fmt.Printf("Student with key %s from redis JSON.GET: %s\n", studentKey, studentJSON)

	// readStudent := Student{}
	// err = json.Unmarshal(studentJSON, &readStudent)
	// if err != nil {
	// 	log.Fatalf("Failed to JSON Unmarshal")
	// 	return
	// }
	// fmt.Printf("Student read from redis : %#v\n", readStudent)
}
