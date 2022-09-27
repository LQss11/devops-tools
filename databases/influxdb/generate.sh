#!/bin/bash
set -e

influx v1 dbrp create --db mydb --rp autogen --bucket-id $(influx bucket list | grep mybucket | awk '{print $1}')  --default --org myorg --token mytoken