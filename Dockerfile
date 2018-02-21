FROM golang:1.8.5-jessie

RUN go get github.com/Masterminds/glide
RUN go get github.com/codegangsta/gin

WORKDIR /go/src/app

ADD glide.yaml glide.yaml
ADD glide.lock glide.lock

RUN glide install

ADD src src

CMD ["go","run","src/main.go"]
