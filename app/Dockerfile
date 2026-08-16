FROM golang:1.24-alpine AS build
WORKDIR /demo-go
COPY go.mod go.sum* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /demo-go/server ./cmd/api
FROM alpine:3.20
WORKDIR /app
COPY --from=build /demo-go/server .

EXPOSE 8080
CMD ["./server"]