output "ssh_info" {
  value = <<EOF
To get the ip of the nodes, Run the following command:
    kubectl get nodes -o wide | awk '{print $7}' | grep -v EXTERNAL-IP
To ssh into the one of nodes, run the following command:
    ssh ${var.gce_ssh_user}@NODE_IP
EOF

  description = "information about how to get the nodes"
}
