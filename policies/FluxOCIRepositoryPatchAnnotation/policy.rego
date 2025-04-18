package policy

import future.keywords.in
import data.k8s.matches

default exclude_namespaces := []
default exclude_label_key := ""
default exclude_label_value := ""

provider := input.parameters.provider
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_meta.labels[exclude_label_key]
    patch_key := get_annotation_for_provider(provider)
    not patch_exists(patch_key)
    result = {
        "issue_detected": true,
        "msg": sprintf("The Kustomization '%s' must have a patch annotation that matches the provider '%s'. Annotation '%s' not found", [controller_input.metadata.name, provider, patch_key]),
        "violating_key": sprintf("patches[*].patch.%s", [patch_key])
    }
}

get_annotation_for_provider(provider) = annotation {
  provider == "aws"
  annotation := "eks.amazonaws.com/role-arn"
} else = annotation {
  provider == "azure"
  annotation := "azure.workload.identity/client-id"
} else = annotation {
  provider == "gcp"
  annotation := "iam.gke.io/gcp-service-account"
}

patch_exists(patch_key) {
    some i
    patch := controller_input.spec.patches[i].patch
    contains(patch, patch_key)
}

controller_input = input.review.object

controller_meta = controller_input.metadata {
    controller_input.kind == "Kustomization"
}

isExcludedNamespace = true {
    controller_meta.namespace
    controller_meta.namespace in exclude_namespaces
} else = false
