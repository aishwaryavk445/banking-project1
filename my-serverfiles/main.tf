resource "aws_instance" "test-server" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = "Awskeypair"
  connection {
     type         = "ssh"
     user         = "ubuntu"
     private_key  = file("./Awskeypair.pem")
     host         = self.public_ip
}
provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance' "]
}
provisioner "local-exec" {
    command = " echo ${aws_instance.test-server.public_ip} > inventory "
}
provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Banking-project1/my-serverfiles/finance-playbook.yml"
}
}
