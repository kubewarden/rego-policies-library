package policy

import future.keywords.in

default exclude_namespaces := []
default exclude_label_key := ""
default exclude_label_value := ""

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
service_account_names := input.parameters.service_account_names

# Violation for serviceAccountName not in service_account_names
violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    has_service_account_name
    service_account_name := controller_spec.serviceAccountName
    not service_account_name in service_account_names
    result = {
        "issue_detected": true,
        "msg": sprintf("The HelmRelease '%s' serviceAccountName must contain a value from parameters.service_account_names; found '%s'", [controller_input.metadata.name, service_account_name]),
        "violating_key": "spec.serviceAccountName"
    }
}

# Violation for serviceAccountName missing
violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    not has_service_account_name
    result = {
        "issue_detected": true,
        "msg": sprintf("The HelmRelease '%s' must have a serviceAccountName specified.", [controller_input.metadata.name]),
        "violating_key": "spec.serviceAccountName"
    }
}

# Check if serviceAccountName field is present
has_service_account_name {
  not is_null(controller_spec.serviceAccountName)
  not controller_spec.serviceAccountName == ""
}

controller_input = input.review.object

controller_spec = controller_input.spec {
  controller_input.kind == "HelmRelease"
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
