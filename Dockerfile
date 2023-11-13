FROM golang:1.21.3-alpine3.18 AS builder

WORKDIR /app

COPY . .
RUN go mod tidy

RUN go build -o main main.go

FROM alpine:latest AS runner
WORKDIR /app/
COPY --from=builder /app/main .
EXPOSE 8080
ENTRYPOINT ["./main"]