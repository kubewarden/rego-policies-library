package policy

test_blocked_ingress_rule {
	testcase = {
		"parameters": {
			"namespace": "default",
			"cidr": "10.244.120.70/32",
			"exclude_label_key": "test_label",
			"exclude_label_value": "OK",
		},
		"review": {"object": {
			"kind": "NetworkPolicy",
			"apiVersion": "networking.k8s.io/v1",
			"metadata": {
				"name": "block-ingress-from-cidr-block",
				"namespace": "default",
			},
			"spec": {
				"podSelector": {},
				"ingress": [{"from": [{"ipBlock": {
					"cidr": "0.0.0.0/0",
					"except": ["10.244.120.70/32"],
				}}]}],
			},
		}},
	}

	count(violation) == 0 with input as testcase
}
