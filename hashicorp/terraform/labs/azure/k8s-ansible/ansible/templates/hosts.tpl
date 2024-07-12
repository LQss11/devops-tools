all:
  hosts:
%{ for k, v in masters_private_ips ~}
    ${k}:
      ansible_host: "lqss"
      ansible_host: "${v}"
      ansible_port: 22
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
%{ endfor ~}
%{ for k, v in workers_private_ips ~}
    ${k}:
      ansible_host: "lqss"
      ansible_host: "${v}"
      ansible_port: 22
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
%{ endfor ~}

  children:
    master:
      hosts:
%{ for k, _ in masters_private_ips ~}
        ${k}:
%{ endfor ~}
%{ for k, _ in workers_private_ips ~}
        ${k}:
%{ endfor ~}
