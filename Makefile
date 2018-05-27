build:
	docker build -t consignment-cli .

run: 
	docker run --net="host" \
		-e MICRO_REGISTRY=mdns \
		consignment-cli consignment.json \
		eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyIjp7ImlkIjoiZjU4OTEzODQtM2VkMy00ZjZkLWExMmMtZThjMzllODc5MjYxIiwibmFtZSI6IkV3YW4gVmFsZW50aW5lIiwiY29tcGFueSI6IkJCQyIsImVtYWlsIjoiZXdhbi52YWxlbnRpbmU4OUBnbWFpbC5jb20iLCJwYXNzd29yZCI6IiQyYSQxMCRBYkg1cG1LekhNeUM3UHprZjRDbERlSFlCNldHd1ZZS3JidWp2VTlYeVpHbXFmUFNCQW5HLiJ9LCJleHAiOjE1Mjc3MDIxOTIsImlzcyI6ImdvLm1pY3JvLnNydi51c2VyIn0.JoYAj_z_crh12N-UrYabOyl1pVsrXt7FPNUzd9EAYrA