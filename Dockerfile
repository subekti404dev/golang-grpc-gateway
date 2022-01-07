FROM golang:alpine3.15

ENV GO111MODULE=on   
RUN apk update && apk add protoc make --no-cache && rm -rf /var/cache/apk/*

RUN go get -d github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
	&& go get -d github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2 \
	&& go get -d github.com/envoyproxy/protoc-gen-validate \
	&& go get -d google.golang.org/protobuf/cmd/protoc-gen-go \
	&& go get -d google.golang.org/grpc/cmd/protoc-gen-go-grpc \
    && cd $GOPATH/pkg/mod/github.com/grpc-ecosystem/grpc-gateway/v2@v2.7.2/protoc-gen-openapiv2/ \
    && go build main.go && mv main $GOPATH/bin/protoc-gen-openapiv2 \
    && cd $GOPATH/pkg/mod/github.com/grpc-ecosystem/grpc-gateway/v2@v2.7.2/protoc-gen-grpc-gateway/ \
    && go build main.go && mv main $GOPATH/bin/protoc-gen-grpc-gateway \
    && go install github.com/golang/protobuf/protoc-gen-go@latest \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest \
    && go install github.com/envoyproxy/protoc-gen-validate@latest \
    && rm -rf $GOPATH/pkg/mod/cache/*
