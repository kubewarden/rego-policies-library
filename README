# Rego policies library

This repository contains a collection of Rego policies that can be used with
Kubewarden to enforce security and compliance best practices.

These policies have been adapted from https://github.com/weaveworks/policy-library.

Weaveworks has been a pioneer in the field of Kubernetes security and
compliance. They transitioned to a community-driven project with the closure of
their start-up company at the beginning of 2024, which was a sad moment in the
cloud native sphere. We thank Weaveworks and their contributors for their work
on these policies, and we believe they are a good asset for Kubernetes users.

The policies are organized as:
- `policies/`: Production ready, tested policies, released via tags to
  `ghcr.io/kubewarden/policies` and artifacthub.io.
- `staging/`: Policies under evaluation, not yet released.

## Releasing a policy

Push a new tag with the pattern `PolicyName/vX.Y.Z`, with the policy in the
folder `policies/PolicyName`. The release job will test, build and push the
policy to `ghcr.io/kubewarden/policies`, create the corresponding GH release,
as well as updating the `artifacthub` branch in this repository.
