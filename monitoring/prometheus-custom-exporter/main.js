const express = require("express");
const prometheus = require("prom-client");

const app = express();

const counter = new prometheus.Counter({
  name: "TotalRequests",
  help: "Total requests made to the service",
  labelNames: ["uri"]
});

const counterMiddleware = (req, res, next) => {
  if (req.path !== "/prometheus") {
    counter.inc({ uri: req.path });
  }
  next();
};

app.use(counterMiddleware);

app.get("/prometheus", (req, res) => {
  res.set("Content-Type", prometheus.register.contentType);
  prometheus.register.metrics().then(metrics => res.send(metrics));
});

app.get("*", (req, res) => res.send("Prometheus prometheus-custom-exporter app"));

const server = app.listen(80, () => console.log("Ready"));

// Graceful shutdown
const gracefulShutdown = () => {
  console.log("Received SIGINT. Shutting down gracefully...");
  server.close(() => {
    console.log("Closed out remaining connections.");
    process.exit();
  });

  // If after 10 seconds, forcefully exit.
  setTimeout(() => {
    console.error("Could not close connections in time, forcefully shutting down");
    process.exit(1);
  }, 10000);
};

// Listen for SIGINT signal
process.on("SIGINT", gracefulShutdown);
