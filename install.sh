#!/bin/bash

# 安装buf套件
function install_buf() {
    # change proxy for download
    export GOPROXY=https://mirrors.aliyun.com/goproxy,direct

    if ! [ -x "$(command -v buf)" ]; then
        echo ">>>> installing buf <<<<"
        go install -v github.com/bufbuild/buf/cmd/buf@v1.1.0
    else
        echo "buf is installed."
    fi

    if ! [ -x "$(command -v protoc-gen-go)" ]; then
        echo ">>>> installing protoc-gen-go <<<<"
        go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.27.1
    else
        echo "protoc-gen-go is installed."
    fi

    if ! [ -x "$(command -v protoc-gen-go-grpc)" ]; then
        echo ">>>> installing protoc-gen-go-grpc <<<<"
        go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1.0
    else
        echo "protoc-gen-go-grpc is installed."
    fi

    if ! [ -x "$(command -v protoc-gen-buf-breaking)" ]; then
        echo ">>>> installing protoc-gen-buf-breaking <<<<"
        go install -v github.com/bufbuild/buf/cmd/protoc-gen-buf-breaking@v1.1.0
    else
        echo "protoc-gen-buf-breaking is installed."
    fi

    if ! [ -x "$(command -v protoc-gen-buf-lint)" ]; then
        echo ">>>> installing protoc-gen-buf-lint <<<<"
        go install -v github.com/bufbuild/buf/cmd/protoc-gen-buf-lint@v1.1.0
    else
        echo "protoc-gen-buf-lint is installed."
    fi

    if ! [ -x "$(command -v protoc-gen-validate)" ]; then
        echo ">>>> installing protoc-gen-validate <<<<"
        go install -v github.com/envoyproxy/protoc-gen-validate@v0.6.7
    else
        echo "protoc-gen-validate is installed."
    fi

    if ! [ -x "$(command -v protoc-gen-grpc-gateway)" ]; then
        echo ">>>> installing protoc-gen-grpc-gateway <<<<"
        go install -v github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v2.6.0
    else
        echo "protoc-gen-grpc-gateway is installed."
    fi

    if ! [ -x "$(command -v protoc-gen-openapiv2)" ]; then
        echo ">>>> installing protoc-gen-openapiv2 <<<<"
        go install -v github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v2.6.0
    else
        echo "protoc-gen-openapiv2 is installed."
    fi

    cd scripts && buf mod update --timeout 15s && cd ..
}

# buf套件安装
install_buf
