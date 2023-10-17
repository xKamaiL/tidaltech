all:
	protoc --c_out=esp_idf/main proto/message.proto
	protoc --dart_out=apps/lib proto/message.proto


include .env
export

test:
	go test ./...
