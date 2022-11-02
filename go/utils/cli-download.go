package main

import (
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
)

// Define key global variables.
var (

// OLD VARS
// filepath = "myfile"
// url      = ""
)

func CLIDownload() {
	//app subcommand
	dlCmd := flag.NewFlagSet("dl", flag.ExitOnError)
	//dl subcommands
	addUrl := dlCmd.String("url", "", "File URL")
	addFilename := dlCmd.String("filename", "", "File name")
	if len(os.Args) < 2 {
		fmt.Println("expected 'dl' subcommand")
		os.Exit(1)
	}

	switch os.Args[1] {
	case "dl": // if its the 'add' command
		HandleDl(dlCmd, addUrl, addFilename)
	default:
		fmt.Println("Command not found")
	}
}
func HandleDl(dlCmd *flag.FlagSet, url *string, filename *string) {

	ValidateLib(dlCmd, url, filename)
	DownloadFile(*url, *filename)

}

// Validate Anywind add
func ValidateLib(addCmd *flag.FlagSet, name *string, filename *string) {

	addCmd.Parse(os.Args[2:])

	if *name == "" || *filename == "" {
		fmt.Print("The following subcommands are required! \n")
		addCmd.PrintDefaults()
		os.Exit(1)
	}

}

func DownloadFile(url string, filepath string) {
	// Create the file
	out, err := os.Create(filepath)
	if err != nil {
		log.Fatalf("Error: %+v", err)
	}
	defer out.Close()

	// Get the data
	resp, err := http.Get(url)
	if err != nil {
		log.Fatalf("Error: %+v", err)
	}
	defer resp.Body.Close()

	// Check server response
	if resp.StatusCode != http.StatusOK {
		log.Fatalf("bad status: %s", resp.Status)

		//return fmt.Errorf("bad status: %s", resp.Status)
	}

	// Writer the body to file
	_, err = io.Copy(out, resp.Body)
	if err != nil {
		log.Fatalf("Error: %+v", err)
	}
	fmt.Println("Download Done!")
}
