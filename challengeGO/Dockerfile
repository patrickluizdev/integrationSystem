FROM golang:1.18-rc-alpine as builder

WORKDIR /go/src/app
COPY main.go /go/src/app

RUN go build -o /app main.go

FROM scratch

COPY --from=builder /app /app

ENTRYPOINT ["/app"]