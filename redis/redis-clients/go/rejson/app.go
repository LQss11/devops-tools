package main

import (
	"flag"
	"fmt"
	"log"

	"github.com/gomodule/redigo/redis"
	"github.com/nitishm/go-rejson/v4"
)

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
	//Example_JSONSet(rh)
	SetStudent(rh, "student2&")
	GetStudent(rh, "student2")
}
