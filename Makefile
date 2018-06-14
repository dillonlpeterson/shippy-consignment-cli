build:
	docker build -t event-cli . 
run: 
	docker run --net="host" \
		-e MICRO_REGISTRY=mdns \
		event-cli event.json 
