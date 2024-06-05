from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import SERVICE_NAME, Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from flask import Flask

app = Flask(__name__)
trace.set_tracer_provider(
    TracerProvider(resource=Resource.create({SERVICE_NAME: "my-hello-service"}))
)

otlp_exporter = OTLPSpanExporter(endpoint="http://jaeger:4318/v1/traces")

trace.get_tracer_provider().add_span_processor(BatchSpanProcessor(otlp_exporter))

tracer = trace.get_tracer(__name__)

@app.route("/api1")
def api1():
   with tracer.start_as_current_span("api1rootSpan"):
      print("api1 Hello world!")
      with tracer.start_as_current_span("api1childSpan"):
         return "<p>Hello, api1!</p>"
@app.route("/api2")
def api2():
   with tracer.start_as_current_span("api2rootSpan"):
      print("Hello world!")
      return "<p>Hello, api2!</p>"


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)