package policy

import future.keywords.in

default exclude_namespaces := []
default exclude_label_key := ""
default exclude_label_value := ""

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    not controller_spec.verify
    result = {
        "issue_detected": true,
        "msg": "The OCIRepository must provide cosign verification and reference a secret containing the Cosign public keys of trusted authors in '.tgz' extension",
        "violating_key": "spec.verify"
    }
}

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    controller_spec.verify
    not correct_provider_and_secret(controller_spec.verify)
    result = {
        "issue_detected": true,
        "msg": "The OCIRepository must provide cosign verification and reference a secret containing the Cosign public keys of trusted authors in '.tgz' extension",
        "violating_key": "spec.verify"
    }
}

correct_provider_and_secret(verify) = true {
    verify.provider == "cosign"
    verify.secretRef
    verify.secretRef.name
} else = false

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
    controller_input.kind == "OCIRepository"
}

contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
