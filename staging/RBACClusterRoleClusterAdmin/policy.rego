package policy

default subjects_name := "system:masters"
default subjects_kind := "Group"
default exclude_label_key := ""
default exclude_label_value := ""

subjects_kind := input.parameters.subjects_kind
subjects_name := input.parameters.subjects_name
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == crb_input.metadata.labels[exclude_label_key]
  crb_input.metadata.name == "cluster-admin"
  some i
  subjects := crb_input.subjects[i]
  not subjects.kind == subjects_kind
  result = {
  	"issue_detected": true,
    "msg": sprintf("expected kind '%v'; found '%v'",[subjects_kind, subjects.name]),
    "violating_key": sprintf("subjects[%v]", [i])
  }
}

violation[result] {  
  not exclude_label_value == crb_input.metadata.labels[exclude_label_key]
  crb_input.metadata.name == "cluster-admin"
  some i
  subjects := crb_input.subjects[i]
  not subjects.name == subjects_name
  result = {
    "issue_detected": true,
    "msg": sprintf("expected name '%v'; found '%v'",[subjects_name, subjects.name]),
    "violating_key": sprintf("subjects[%v].name", [i])
  }
}

crb_input = input.review.object {
	contains_kind(input.review.object.kind, {"ClusterRoleBinding"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
