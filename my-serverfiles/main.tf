resource "aws_instance" "test-server" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "Awskeypair"
  vpc_security_group_ids = ["sg-07fff356262072580"]
  connection {
     type         = "ssh"
     user         = "ubuntu"
     private_key  = file("./Awskeypair.pem")
     host         = self.public_ip
}
provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance' "]
}
tags {
  Name = "test-server"
}
provisioner "local-exec" {
    inline = " echo ${aws_instance.test-server1.public_ip} > inventory "
}
provisioner "remote-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Banking-project1/my-serverfiles/finance-playbook.yml"
}
}
