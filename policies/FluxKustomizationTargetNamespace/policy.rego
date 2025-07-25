package policy

import future.keywords.in

default exclude_namespaces := []
default exclude_label_key := ""
default exclude_label_value := ""

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
target_namespaces := input.parameters.target_namespaces
target_namespace_list := concat(", ", target_namespaces)

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == kustomization_input.metadata.labels[exclude_label_key]
    not kustomization_input.spec.targetNamespace
    result = {
        "issue_detected": true,
        "msg": sprintf("The Kustomization '%s' targetNamespace must be one of the allowed target namespaces: %v; found none", [kustomization_input.metadata.name, target_namespace_list]),
        "violating_key": "spec.targetNamespace"
    }
}

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == kustomization_input.metadata.labels[exclude_label_key]
    not kustomization_input.spec.targetNamespace in target_namespaces
    result = {
        "issue_detected": true,
        "msg": sprintf("The Kustomization '%s' targetNamespace must be one of the allowed target namespaces: %v; found '%s'", [kustomization_input.metadata.name, target_namespace_list, kustomization_input.spec.targetNamespace]),
        "violating_key": "spec.targetNamespace"
    }
}


# Kustomization input
kustomization_input = input.review.object {
  input.review.object.kind == "Kustomization"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
  kustomization_input.metadata.namespace
  kustomization_input.metadata.namespace in exclude_namespaces
} else = false
