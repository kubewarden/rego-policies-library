package policy

import future.keywords.in

default restart_policy := "Always"
default exclude_namespaces := []
default exclude_label_key := ""
default exclude_label_value := ""

restart_policy := input.parameters.restart_policy
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  
  policy = controller_spec["restartPolicy"]
  policy != restart_policy
  result = {
    "issue_detected": true,
    "msg": sprintf("restartPolicy should be '%v'; found '%v'", [restart_policy, policy]),
    "violating_key": "spec.template.spec"
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
