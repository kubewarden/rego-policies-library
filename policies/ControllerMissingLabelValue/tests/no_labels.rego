package policy

test_no_labels {
	testcase = {
		"parameters": {
			"label": "owner",
			"value": "tony2",
			"exclude_namespace": "",
			"exclude_label_key": "",
			"exclude_label_value": "",
		},
		"review": {"object": {
			"apiVersion": "apps/v1",
			"kind": "Deployment",
			"metadata": {"name": "demoservice"},
			"spec": {
				"replicas": 1,
				"selector": {"matchLabels": {"app": "demoservice"}},
				"template": {
					"metadata": {"labels": {"app": "demoservice"}},
					"spec": {
						"securityContext": {
							"runAsUser": 0,
							"runAsGroup": 1000,
							"fsGroup": 1000,
							"runAsNonRoot": false,
						},
						"containers": [{
							"name": "demoservice",
							"command": [
								"node",
								"app.js",
							],
							"image": "airwavetechio/demoservice:v0.0.2",
							"env": [{
								"name": "PORT",
								"value": "5001",
							}],
							"ports": [{
								"containerPort": 5001,
								"name": "liveness-port",
							}],
							"securityContext": {
								"privileged": true,
								"allowPrivilegeEscalation": true,
								"readOnlyRootFilesystem": false,
								"runAsUser": 1000,
								"runAsGroup": 1000,
								"runAsNonRoot": true,
								"capabilities": {"add": ["SYS_ADMIN"]},
							},
						}],
					},
				},
			},
		}},
	}

	count(violation) == 1 with input as testcase
}
