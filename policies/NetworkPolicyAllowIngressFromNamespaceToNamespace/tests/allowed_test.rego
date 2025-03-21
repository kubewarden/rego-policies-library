package policy

test_allowed {
  testcase = {
    "parameters": {
      "src_namespace": "ns1",
      "dst_namespace": "ns2",
      "exclude_label_key": "test_label",
      "exclude_label_value": "OK"
    },
    "review": {
      "object": {
        "apiVersion": "networking.k8s.io/v1",
        "kind": "NetworkPolicy",
        "metadata": {
          "name": "allow-ingress-from-namespace-to-another",
          "namespace": "ns2"
        },
        "spec": {
          "podSelector": {},
          "ingress": [
            {
              "from": [
                {
                  "namespaceSelector": {
                    "matchLabels": {
                      "kubernetes.io/metadata.name": "ns1"
                    }
                  }
                }
              ]
            }
          ],
          "policyTypes": [
            "Ingress"
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}