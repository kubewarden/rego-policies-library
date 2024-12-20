# RabbitMQ Enforce Environment Variable - RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT

This Policy ensures RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT: RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT when set to true, TLS connection will be rejected if client fails to provide a certificate.


If you encounter a violation, ensure the RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


# Settings
```yaml
  settings:
    parameters:
      - name: exclude_namespaces
        type: array
        required: false
        value:
      - name: exclude_label_key
        type: string
        required: false
        value:
      - name: exclude_label_value
        type: string
        required: false
        value:
```

# Resources
Policy applies to resources kinds:
`Deployment`, `Job`, `ReplicationController`, `ReplicaSet`, `DaemonSet`, `StatefulSet`, `CronJob`
