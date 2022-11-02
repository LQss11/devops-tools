package main

import (
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"log"

	"github.com/gomodule/redigo/redis"
	"github.com/nitishm/go-rejson/v4"
)

var ctx = context.Background()

// Name - student name
type Name struct {
	First  string `json:"first,omitempty"`
	Middle string `json:"middle,omitempty"`
	Last   string `json:"last,omitempty"`
}

// Student - student object
type Student struct {
	Name Name `json:"name,omitempty"`
	Rank int  `json:"rank,omitempty"`
}

func Example_JSONSet(rh *rejson.Handler) {

	student := Student{
		Name: Name{
			"Markd",
			"Sd",
			"Prontoa",
		},
		Rank: 1,
	}

	res, err := rh.JSONSet("student", ".", student)
	if err != nil {
		log.Fatalf("Failed to JSONSet")
		return
	}

	if res.(string) == "OK" {
		fmt.Printf("Success: %s\n", res)
	} else {
		fmt.Println("Failed to Set: ")
	}

	studentJSON, err := redis.Bytes(rh.JSONGet("student", "."))
	if err != nil {
		log.Fatalf("Failed to JSONGet")
		return
	}

	readStudent := Student{}
	err = json.Unmarshal(studentJSON, &readStudent)
	if err != nil {
		log.Fatalf("Failed to JSON Unmarshal")
		return
	}
	fmt.Printf("Student read from redis : %#v\n", readStudent)

	res, err = rh.JSONGet("student", ".")
	if err != nil {
		log.Fatalf("Failed to JSONGet")
		return
	}
	fmt.Printf("Student with JSONGet : %s\n", res)
}

func main() {
	var addr = flag.String("Server", "redis-stack:6379", "Redis server address")

	rh := rejson.NewReJSONHandler()
	flag.Parse()
	// Redigo Client
	conn, err := redis.Dial("tcp", *addr)
	if err != nil {
		log.Fatalf("Failed to connect to redis-server @ %s", *addr)
	}
	rh.SetRedigoClient(conn)
	fmt.Println("Executing Example_JSONSET for Redigo Client")
	Example_JSONSet(rh)
}
