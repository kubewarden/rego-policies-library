# InfluxDB Enforce Environment Variable - DOCKER_INFLUXDB_INIT_ADMIN_TOKEN

This Policy ensures DOCKER_INFLUXDB_INIT_ADMIN_TOKEN environment variable are in place when using the official container images from Docker Hub.
DOCKER_INFLUXDB_INIT_ADMIN_TOKEN: The authentication token to associate with the system's initial super-user. If not set, a token will be auto-generated by the system.


If you encounter a violation, ensure the DOCKER_INFLUXDB_INIT_ADMIN_TOKEN environment variables is set.
For futher information about the InfluxDB Docker container, check here: https://hub.docker.com/_/influxdb


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
