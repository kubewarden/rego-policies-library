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
  label := "app.kubernetes.io/name"
  # Filter the type of entity before moving on since this shouldn't apply to all entities
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
  not controller_input.metadata.labels[label]
  result = {
    "issue_detected": true,
    "msg": sprintf("Missing '%v' label", [label]),
    "violating_key": "metadata.labels",
    "recommended_value": label
  }
}

# Controller input
controller_input = input.review.object

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
