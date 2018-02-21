FROM golang:1.8.5-jessie as builder

RUN go get github.com/Masterminds/glide
WORKDIR /go/src/app
ADD glide.yaml glide.yaml
ADD glide.lock glide.lock

RUN glide install

ADD src src
RUN go build src/main.go

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main src/main.go

FROM alpine:3.7
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
WORKDIR /root
COPY --from=builder /go/src/app/main .

CMD ["./main"]
