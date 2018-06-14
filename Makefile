build:
	docker build -t event-cli \
		--build-arg SSH_KEY=$(cat ~/.ssh/dillonlpeterson-Bitbucket) \
		 . 
run: 
	docker run --net="host" \
		-e MICRO_REGISTRY=mdns \
		event-cli event.json 
