var redis = require('redis');

// Create Client
const client = redis.createClient({
	socket: {
		host: 'redis-node',
		port: 6379
	},
	password: ''
});

(async () => {
	await client.connect();
})();

console.log("Establishing connection to redis server");

client.on("ready", () => {
	console.log("Connection established to redis server on port 6379...");
});

client.on("error", (err) => {
	console.log("Error in the Connection");
});


// Create list
const asyncList = async () => {
	await client.rPush('names', 'Roger')
	await client.lPush('names', 'Syd')
};

// Create Key value pairs
const asyncBlock = async () => {
	await client.set("mykey", "myvalue");
	const value = await client.get("mykey");
	console.log(value);
};

asyncList()
asyncBlock()
