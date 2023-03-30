resource "aws_ebs_volume" "exampleebs" {
    availability_zone= "me-south-1a"
    size = 50 
}

resource "aws_volume_attachment" "exampleebsattach" {
    device_name =  "/dev/sdf"
    instance_id = "${aws_instance.exampleec2.id}"
    volume_id = aws_ebs_volume.exampleebs.id
}