build:
	docker build -t shippy-consignment-cli .

run: 
	docker run -e MICRO_REGISTRY=mdns shippy-consignment-cli