# Namespace Resources Limitrange

When setting up default CPU and Memory values for your namespace, this policy will check if both requests and limits are set. This policy checks for the following:

| Resource Setting | Resource Type |
| ---------------- | ------------- |
| default          | cpu           |
| default          | memory        |
| defaultRequest   | cpu           |
| defaultRequest   | memory        |
| min              | memory        |
| min              | cpu           |
| max              | cpu           |
| max              | memory        |

Ensure you are specifying both CPU and Memory requests and limits in your LimitRange

```
spec:
limits:
- <resource_setting>:
    <resource_type>: value
```

https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-default-namespace/
https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/

# Settings

```yaml
settings:
  resource_type: "resource_type"
  resource_setting: "resource_setting"
  namespace: "magalix" # default: "magalix"
```

# Resources

Policy applies to resources kinds:
`LimitRange`
