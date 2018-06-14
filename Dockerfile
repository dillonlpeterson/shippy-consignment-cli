# We use the official golang image, which contains all the 
# correct build tools and libraries. Notice 'as builder',
# this gives the container a name that we can reference later on.
FROM golang:1.9.0 as builder 
# Set our workdir to our current service in the gopath
WORKDIR /go/src/bitbucket.org/dillonlpeterson/myplans-event-service-cli

ARG SSH_KEY
#RUN mkdir /root/.ssh && echo "StrictHostKeyChecking no " > /root/.ssh/config
#RUN echo "${SSH_KEY}" >> /root/.ssh/id_rsa
#RUN chmod 0600 /root/.ssh/id_rsa
#RUN echo "[url \"git@bitbucket.org:\"]\n\tinsteadOf = https://bitbucket.org/" >> /root/.gitconfig
# Copy the current directory into our workdir 
COPY . .
RUN go get -u github.com/golang/dep/cmd/dep
#RUN eval "$(ssh-agent -s)" && ssh-add /root/.ssh/id_rsa && dep init && dep ensure 
RUN dep init && dep ensure 
# Build the binary, with a few flags that will allow us 
# to run the binary in Alpine. 
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .

# Here we're using a second FROM statement, which tells Docker to start 
# a new build process with this image
FROM alpine:latest 

# Security-related package good to have 
RUN apk --no-cache add ca-certificates

RUN mkdir /app 
WORKDIR /app 

#ADD consignment-service /app/consignment-service 
# Instead of pulling binary from Host machine, we pill it from the container named builder!
# Copies into /app directory, which is the current working directory.
COPY event.json /app/event.json
COPY --from=builder /go/src/bitbucket.org/dillonlpeterson/myplans-event-service-cli .
# As usual, run the binary!
ENTRYPOINT ["./event-cli"]

# Code must be pushed up to Git so that it can pull in other services.