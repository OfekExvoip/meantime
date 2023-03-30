/***

resource "aws_instance" "PBX2" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t3.micro"
    key_name = "terraform-key"
    count = 1
    vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
    subnet_id = "${aws_subnet.examplesub1.id}"
    iam_instance_profile = "tags-route53-bah-role"
     depends_on = [
    aws_vpc.examplevpc
  ]
    tags = {
        Name = "PBX-${count.index}"
    }


}



resource null_resource "ansible_install2" {

count = 1

 provisioner "local-exec" {
command = "sleep 180; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key /home/ubuntu/.ssh/terrakeybah -i '${aws_instance.PBX2[count.index].public_ip}', ansible-script.yaml"
}

}


***/