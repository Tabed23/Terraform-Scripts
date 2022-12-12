resource "aws_route53_record" "record" {
  depends_on= [var.ig]
  zone_id =  var.zone_id # Replace with your zone ID
  name    = var.rancher_domain # Replace with your subdomain, Note: not valid with "apex" domains, e.g. example.com
  type    = "A"
  ttl     = "60"
  records = [var.rancher_instance_ip]
}

