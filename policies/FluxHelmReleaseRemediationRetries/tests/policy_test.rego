package policy

import data.policy.violation

test_valid_install_retries {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "lower_bound": 3,
      "upper_bound": 5
    },
    "review": {
      "object": {
        "apiVersion": "helm.toolkit.fluxcd.io/v2beta1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
          "install": {
            "remediation": {
              "retries": 4
            }
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_valid_upgrade_retries {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "lower_bound": 3,
      "upper_bound": 5
    },
    "review": {
      "object": {
        "apiVersion": "helm.toolkit.fluxcd.io/v2beta1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
          "upgrade": {
            "remediation": {
              "retries": 4
            }
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_lower_bound_upgrade_retries {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "lower_bound": 3,
      "upper_bound": 5
    },
    "review": {
      "object": {
        "apiVersion": "helm.toolkit.fluxcd.io/v2beta1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "upgrade": {
            "remediation": {
              "retries": 2
            }
          }
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_invalid_upper_bound_retries {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "lower_bound": 3,
      "upper_bound": 5
    },
    "review": {
      "object": {
        "apiVersion": "helm.toolkit.fluxcd.io/v2beta1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "install": {
            "remediation": {
              "retries": 6
            }
          }
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label_retries {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true",
      "lower_bound": 3,
      "upper_bound": 5
    },
    "review": {
      "object": {
        "apiVersion": "helm.toolkit.fluxcd.io/v2beta1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-helm-release",
          "labels": {
            "exclude": "true"
          }
        },
        "spec": {
          "upgrade": {
            "remediation": {
              "retries": 6
            }
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace_retries {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "lower_bound": 3,
      "upper_bound": 5
    },
    "review": {
      "object": {
        "apiVersion": "helm.toolkit.fluxcd.io/v2beta1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-helm-release",
          "namespace": "excluded-namespace",
        },
        "spec": {
          "install": {
            "remediation": {
              "retries": 6
            }
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_lower_bound_install_retries {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "lower_bound": 3,
            "upper_bound": 5
        },
        "review": {
            "object": {
                "apiVersion": "helm.toolkit.fluxcd.io/v2beta1",
                "kind": "HelmRelease",
                "metadata": {
                    "name": "invalid-helm-release",
                },
                "spec": {
                    "install": {
                        "remediation": {
                            "retries": 2
                        }
                    }
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_invalid_upper_bound_install_retries {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "lower_bound": 3,
            "upper_bound": 5
        },
        "review": {
            "object": {
                "apiVersion": "helm.toolkit.fluxcd.io/v2beta1",
                "kind": "HelmRelease",
                "metadata": {
                    "name": "invalid-helm-release",
                },
                "spec": {
                    "install": {
                        "remediation": {
                            "retries": 6
                        }
                    }
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_invalid_upper_bound_upgrade_retries {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "lower_bound": 3,
            "upper_bound": 5
        },
        "review": {
            "object": {
                "apiVersion": "helm.toolkit.fluxcd.io/v2beta1",
                "kind": "HelmRelease",
                "metadata": {
                    "name": "invalid-helm-release",
                },
                "spec": {
                    "upgrade": {
                        "remediation": {
                            "retries": 6
                        }
                    }
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}
