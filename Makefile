build:
	docker build -t consignment-cli .

run: 
	docker run -e MICRO_REGISTRY=mdns shippy-consignment-cli