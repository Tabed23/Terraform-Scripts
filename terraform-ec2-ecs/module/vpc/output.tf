output "vpc_id" {
    value= "${aws_vpc.vpc.id}"
}
output "public_subnets" {
    value = "${aws_subnet.public}"
}

output "private_subnets" {
    value = "${aws_subnet.private}"
}

/* output "sg" {
    value= "${aws_security_group.ssh-http-sg.id}"
} */
 
 output "loadbalancer_sg"{
    value= "${aws_security_group.LoadBalancer-sg.id}"
} 
 
 
 output "ECS_sg"{
    value= "${aws_security_group.ECS-sg.id}"
}  