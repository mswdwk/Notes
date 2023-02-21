# 1 ensure CRDs are installed first
shell>kubectl apply -f calico.yaml

error: resource mapping not found for name: "calico-kube-controllers" namespace: "kube-system" from "calico.yaml": no matches for kind "PodDisruptionBudget" in version "policy/v1beta1"
ensure CRDs are installed first
