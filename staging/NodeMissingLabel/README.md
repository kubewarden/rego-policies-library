# Node Missing Label

This Policy only looks for specific node label keys.

Important node labels include:
### kubernetes.io/hostname
The Kubelet populates this label with the hostname. Note that the hostname can be changed from the "actual" hostname by passing the --hostname-override flag to the kubelet.

### kubernetes.io/arch
The Kubelet populates this with runtime.GOARCH as defined by Go. This can be handy if you are mixing arm and x86 nodes.

### node.kubernetes.io/instance-type
The Kubelet populates this with the instance type as defined by the cloudprovider. This will be set only if you are using a cloudprovider. This setting is handy if you want to target certain workloads to certain instance types, but typically you want to rely on the Kubernetes scheduler to perform resource-based scheduling. You should aim to schedule based on properties rather than on instance types (for example: require a GPU, instead of requiring a g2.2xlarge).

### kubernetes.io/os
The Kubelet populates this with runtime.GOOS as defined by Go. This can be handy if you are mixing operating systems in your cluster (for example: mixing Linux and Windows nodes).

### topology.kubernetes.io/zone
The kubelet or the external cloud-controller-manager populates this with the information as provided by the cloudprovider. This will be set only if you are using a cloudprovider. However, you should consider setting this on nodes if it makes sense in your topology.


Ensure the label is as specified in the Policy. 
```
metadata: 
  labels: 
    <key>: value
```
https://kubernetes.io/docs/reference/labels-annotations-taints/


# Settings
```yaml
  settings:
    parameters:
      - name: node_label
        type: string
        required: true
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
`Node`
