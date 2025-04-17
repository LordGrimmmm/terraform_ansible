resource "null_resource" "run_ansible_playbook" {
  depends_on = [module.linux_vms]

  provisioner "local-exec" {
    command = <<EOT
      mkdir -p /home/n01697923/terraform-project/final_ansible/

      echo "[linux]" > /home/n01697923/terraform-project/final_ansible/hosts
      echo "${join("\n", [for ip in module.linux_vms.linux_vm_public_ips : "${ip} ansible_user=azureuser ansible_ssh_private_key_file=/home/n01697923/.ssh/id_rsa"])}" >> /home/n01697923/terraform-project/final_ansible/hosts

      ANSIBLE_HOST_KEY_CHECKING=False final_ansible-playbook -i /home/n01697923/terraform-project/final_ansible/hosts /home/n01697923/terraform-project/final_ansible/n01697923-playbook.yml
    EOT

    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
