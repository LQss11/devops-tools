# Default to http://myserver but will be overridden if exported outside as env var (using ?)
# $env:SERVER_URL="windows"
# export SERVER_URL=linux
# make apm SERVER_URL=arg


export SERVER_URL?=myserver
server:
	echo $(SERVER_URL)