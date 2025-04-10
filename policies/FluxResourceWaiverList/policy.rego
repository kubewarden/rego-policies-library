package policy

import future.keywords.in

default exclude_namespaces := []
default exclude_label_key := ""
default exclude_label_value := ""

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
waiver_list := input.parameters.waiver_list

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    not controller_input.metadata.name in waiver_list
    controller_spec.suspend == true
    result = {
        "issue_detected": true,
        "msg": sprintf("The resource '%s' of kind '%s' must not be suspended.", [controller_input.metadata.name, controller_input.kind]),
        "violating_key": "spec.suspend",
        "recommended_value": false
    }
}

# Controller input
controller_input = input.review.object

controller_spec = controller_input.spec {
    contains_kind(controller_input.kind, ["HelmRelease", "GitRepository", "OCIRepository", "Bucket", "HelmChart", "HelmRepository", "Kustomization"])
}

contains_kind(kind, kinds) {
kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
