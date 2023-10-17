FROM golang:1.21.0

ENV GOOS=linux
ENV GOARCH=amd64
ENV CGO_ENABLED=0
RUN mkdir -p /workspace
WORKDIR /workspace
ADD go.mod go.sum ./
RUN go mod download
ADD . .
RUN go build -o .build/api -ldflags "-w -s" ./cmd/api

FROM gcr.io/distroless/static

WORKDIR /app

COPY --from=0 --link /workspace/.build/* ./
ENTRYPOINT ["/app/api"]