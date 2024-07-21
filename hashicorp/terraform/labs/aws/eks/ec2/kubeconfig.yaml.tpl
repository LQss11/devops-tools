apiVersion: v1
kind: Config
current-context: terraform
clusters:
- name: ${cluster_id}
  cluster:
    certificate-authority-data: ${certificate_authority_data}
    server: ${endpoint}
contexts:
- name: terraform
  context:
    cluster: ${cluster_id}
    user: terraform
users:
- name: terraform
  user:
    token: ${token}
