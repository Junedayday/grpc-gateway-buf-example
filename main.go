package main

import (
	"context"
	"net"
	"net/http"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"github.com/pkg/errors"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"

	"github.com/Junedayday/grpc-gateway-buf-example/idl/proto"
	"github.com/Junedayday/grpc-gateway-buf-example/internal/server"
)

const (
	gRPCEndPoint        = ":8080"
	gRPCGatewayEndPoint = ":8082"
)

func main() {
	go runGRPC()

	if err := runHTTP(); err != nil {
		panic(err)
	}
}

func runGRPC() {
	lis, err := net.Listen("tcp", gRPCEndPoint)
	if err != nil {
		panic(err)
	}

	s := grpc.NewServer()
	proto.RegisterEchoServiceServer(s, &server.Server{})

	if err := s.Serve(lis); err != nil {
		panic(err)
	}
}

func runHTTP() error {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// gRPC-Gateway mux
	gwMux := runtime.NewServeMux()
	opts := []grpc.DialOption{
		grpc.WithTransportCredentials(insecure.NewCredentials()),
	}

	if err := proto.RegisterEchoServiceHandlerFromEndpoint(ctx, gwMux, gRPCEndPoint, opts); err != nil {
		return errors.Wrap(err, "RegisterEchoServiceHandlerFromEndpoint error")
	}

	// Start HTTP server (and proxy calls to gRPC server endpoint)
	return http.ListenAndServe(gRPCGatewayEndPoint, gwMux)
}
