package main

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"os"

	"golang.org/x/net/context"

	pb "bitbucket.org/dillonlpeterson/myplans-event-service/proto/event"
	microclient "github.com/micro/go-micro/client"
	"github.com/micro/micro/cmd"
)

const (
	address         = "localhost:50051"
	defaultFilename = "event.json"
)

func parseFile(file string) (*pb.Event, error) {
	var event *pb.Event
	data, err := ioutil.ReadFile(file)

	if err != nil {
		return nil, err
	}
	json.Unmarshal(data, &event)
	return event, nil
}

func main() {
	cmd.Init()

	// Create new greeter client
	client := pb.NewEventServiceClient("myplans.event", microclient.DefaultClient)

	file := os.Args[1]

	event, err := parseFile(file)
	if err != nil {
		log.Fatal("Could not parse file: %v", err)
	}

	// First call to event service
	r, err := client.Create(context.Background(), event)
	if err != nil {
		log.Fatal("Could not create event: %v", err)
	}
	log.Println("Created: %v", r.Created)

}
