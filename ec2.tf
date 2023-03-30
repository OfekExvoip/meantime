
resource "aws_instance" "exampleec2" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t3.micro"
    key_name = "terrakey-bah"
    vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
    subnet_id = "${aws_subnet.examplesub1.id}"
    iam_instance_profile = "tags-route53-bah-role"
     depends_on = [
    aws_vpc.examplevpc
  ]
    tags = {
        Name = "newpbx"
    }

  root_block_device {
    volume_size = 50 
    volume_type = "gp2"
    encrypted   = true
  }

}


resource null_resource "ansible_install" { 
  
  provisioner "local-exec" {
command = "sleep 5; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key /home/ubuntu/.ssh/terrakeybah -i '${aws_instance.exampleec2.public_ip},' ansible-script.yaml"
}

}
