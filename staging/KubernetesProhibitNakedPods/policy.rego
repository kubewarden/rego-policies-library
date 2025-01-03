package policy

violation[result] {
  kind := "Pod"
	lower_kind := lower(kind)
	specified_kind := input.review.object.kind
	lower_specified_kind := lower(specified_kind)
  lower_kind == lower_specified_kind
  result = {
    "issue_detected": true,
    "msg": sprintf("Naked Pods are prohibited",[]),
    "violating_key": "kind"
  }
}
