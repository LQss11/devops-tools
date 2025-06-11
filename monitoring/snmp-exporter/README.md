# SNMP monitoring
you can setup snmp monitoring through prometheus using snmp exporter:
* **Prometheus config**
```sh
docker run -it --rm --name=prometheus -p 9090:9090 -v ${pwd}/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
```

* **snmp exporter config**
```sh
docker run -it --rm -v -v ${pwd}/snmp/snmp.yml:/etc/snmp_exporter/snmp.yml --name=snmp-exporter -p 9116:9116 prom/snmp-exporter 
```
you can then run this to check some metrics: **http://localhost:9116/snmp?module=if_mib&target=192.168.1.1**
