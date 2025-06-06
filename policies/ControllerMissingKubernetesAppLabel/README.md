# Missing Kubernetes App Label

Custom labels can help enforce organizational standards for each artifact deployed. This Policy ensure a custom label key is set in the entity's `metadata`. The Policy detects the presence of the following:

### owner

A label key of `owner` will help identify who the owner of this entity is.

### app.kubernetes.io/name

The name of the application

### app.kubernetes.io/instance

A unique name identifying the instance of an application

### app.kubernetes.io/version

The current version of the application (e.g., a semantic version, revision hash, etc.)

### app.kubernetes.io/part-of

The name of a higher level application this one is part of

### app.kubernetes.io/managed-by

The tool being used to manage the operation of an application

### app.kubernetes.io/created-by

The controller/user who created this resource

Add these custom labels to `metadata`.

- owner
- app.kubernetes.io/name
- app.kubernetes.io/instance
- app.kubernetes.io/version
- app.kubernetes.io/name
- app.kubernetes.io/part-of
- app.kubernetes.io/managed-by
- app.kubernetes.io/created-by

```
metadata:
  labels:
    <label>: value
```

For additional information, please check

- https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels

# Settings

```yaml
settings:
  exclude_namespaces: [] # optional
  exclude_label_key: "" # optional
  exclude_label_value: "" # optional
```

# Resources

Policy applies to resources kinds:
`Deployment`, `Job`, `ReplicationController`, `ReplicaSet`, `DaemonSet`, `StatefulSet`, `CronJob`
