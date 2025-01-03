package policy

test_patches_required_enabled_violation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "patches_required": true
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization"
        },
        "spec": {}
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_patches_required_enabled_no_violation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "patches_required": true
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization"
        },
        "spec": {
          "patches": [
            {
              "patch": "dummy-patch"
            }
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_patches_required_disabled_violation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "patches_required": false
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization"
        },
        "spec": {
          "patches": [
            {
              "patch": "dummy-patch"
            }
          ]
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_patches_required_disabled_no_violation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "patches_required": false
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization"
        },
        "spec": {}
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
    testcase := {
        "parameters": {
            "patches_required": true,
            "exclude_namespaces": ["kube-system"],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "kube-system"
                },
                "spec": {
                    "patches": [{
                        "patch": "example patch"
                    }]
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}


test_exclude_label {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "allow-patches",
      "exclude_label_value": "true",
      "patches_required": false
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "labels": {
            "allow-patches": "true"
          }
        },
        "spec": {
          "patches": [
            {
              "patch": "dummy-patch"
            }
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}