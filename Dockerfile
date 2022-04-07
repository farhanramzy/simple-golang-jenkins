# STAGE 1
FROM golang:alpine as build
RUN apk update && apk add --no-cache git
WORKDIR /src
COPY . .
RUN go mod tidy
RUN go version 
RUN go test ./... -cover
RUN go build -o example-golang-jenkins

# STAGE 2
FROM alpine
WORKDIR /app
COPY --from=build /src/example-golang-jenkins /app
ENTRYPOINT [ "/app/example-golang-jenkins" ]