package policy

import future.keywords.in

default resource_enabled := false
default exclude_namespaces := []
default exclude_label_key := ""
default exclude_label_value := ""

resource_enabled := input.parameters.resource_enabled
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  shared_resource := "hostPID"
  resource := controller_spec[shared_resource]
  not resource == resource_enabled
  result = {
    "issue_detected": true,
    "msg": sprintf("'%v' should be set to '%v'; found '%v'", [shared_resource, resource_enabled, resource]),
    "violating_key": sprintf("spec.template.spec[%v]", [shared_resource]),
    "recommended_value": resource_enabled
  }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec.template.spec {
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
} else = controller_input.spec {
  controller_input.kind == "Pod"
} else = controller_input.spec.jobTemplate.spec.template.spec {
  controller_input.kind == "CronJob"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
