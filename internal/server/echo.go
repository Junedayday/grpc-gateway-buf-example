package server

import (
	"context"

	"github.com/Junedayday/grpc-gateway-buf-example/idl/proto"
)

func (s *Server) ListFlows(ctx context.Context, req *proto.EchoRequest) (resp *proto.EchoResponse, err error) {
	resp = new(proto.EchoResponse)
	return
}
