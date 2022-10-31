// https://github.com/go-redis/redis
package main

import (
	"context"
	"fmt"

	"github.com/go-redis/redis/v8"
)

var ctx = context.Background()

func main() {
	rdb := redis.NewClient(&redis.Options{
		Addr:     "redis-go:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})

	err := rdb.Set(ctx, "NEW-KEY", "Hello World", 0).Err()
	if err != nil {
		panic(err)
	}

	val, err := rdb.Get(ctx, "NEW-KEY").Result()
	if err != nil {
		panic(err)
	}
	//fmt.Println("NEW-KEY", val)
	fmt.Println("key 'NEW-KEY' was set with value", val)

	val2, err := rdb.Get(ctx, "key2").Result()
	if err == redis.Nil {
		fmt.Println("key2 does not exist")
	} else if err != nil {
		panic(err)
	} else {
		fmt.Println("key2", val2)
	}
	// Output: key value
	// key2 does not exist
}
