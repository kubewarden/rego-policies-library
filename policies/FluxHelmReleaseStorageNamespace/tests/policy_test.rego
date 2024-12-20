package policy

import data.policy.violation

test_valid_storage_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "storage_namespaces": ["allowed-storage-namespace"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
            "storageNamespace": "allowed-storage-namespace"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_storage_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "storage_namespaces": ["allowed-storage-namespace"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
            "storageNamespace": "disallowed-storage-namespace"
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label_storage_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true",
      "storage_namespaces": ["allowed-storage-namespace"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
          "labels": {
            "exclude": "true"
          }
        },
        "spec": {
            "storageNamespace": "disallowed-storage-namespace"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace_storage_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "storage_namespaces": ["allowed-storage-namespace"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
          "namespace": "excluded-namespace",
        },
        "spec": {
            "storageNamespace": "disallowed-storage-namespace"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
