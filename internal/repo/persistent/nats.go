package persistent

import (
	"github.com/OpenBankingVN/OBVN-API/internal/repo"
	"github.com/OpenBankingVN/OBVN-API/pkg/nats"
	natsio "github.com/nats-io/nats.go"
)

// NatsRepo -.
type NatsRepo struct {
	nc *nats.NatsClient
}

// NewNatsRepo -.
func NewNatsRepo(nc *nats.NatsClient) repo.NatsRepo {
	return &NatsRepo{nc: nc}
}

// Publish -.
func (r *NatsRepo) Publish(subject string, data []byte) error {
	return r.nc.Publish(subject, data)
}

// Subscribe -.
func (r *NatsRepo) Subscribe(subject string, handler func(msg []byte)) (func() error, error) {
	sub, err := r.nc.Subscribe(subject, func(m *natsio.Msg) {
		handler(m.Data)
	})
	if err != nil {
		return nil, err
	}
	return sub.Unsubscribe, nil
}
