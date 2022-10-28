package server

import "github.com/Junedayday/grpc-gateway-buf-example/idl/proto"

type Server struct {
	proto.UnimplementedEchoServiceServer
}
