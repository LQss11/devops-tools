export SERVICE?=service2
export ENV?=local
# ports suffixes
service1_port_suffix=01
service2_port_suffix=02
service3_port_suffix=03

ifeq ($(ENV), dev)
	PORT = 40$($(SERVICE)_port_suffix)
else ifeq ($(ENV), uat)
	PORT = 41$($(SERVICE)_port_suffix)
else ifeq ($(ENV), prod)
	PORT = 42$($(SERVICE)_port_suffix)
else ifeq ($(ENV), local)
	PORT = 43$($(SERVICE)_port_suffix)
else
	PORT = 44$($(SERVICE)_port_suffix)
endif

deploy:
	@echo $(SERVICE) will be deployed on $(ENV) environment with port $(PORT)