package policy

test_allowed_port {
	testcase = {
		"parameters": {
			"container_port": 22,
			"exclude_namespaces": [],
			"exclude_label_key": "",
			"exclude_label_value": "",
		},
		"review": {
			"object": {
				"apiVersion": "apps/v1",
				"kind": "Deployment",
				"metadata": {
					"name": "my-nginx"
				},
				"spec": {
					"selector": {
						"matchLabels": {
							"run": "my-nginx"
						},
					},
					"replicas": 2,
					"template": {
						"metadata": {
							"labels": {
								"run": "my-nginx"
							},
						},
						"spec": {
							"containers": [{
								"name": "my-nginx",
								"image": "nginx",
								"ports": [{
									"containerPort": 8080
								}],
							}]
						},
					},
				},
			}
		},
	}

	count(violation) == 0 with input as testcase
}
