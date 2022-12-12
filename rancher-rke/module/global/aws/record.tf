resource "aws_route53_record" "record" {
  depends_on = [aws_lb.alb]
  zone_id    = var.zone_id        # Replace with your zone ID
  name       = var.rancher_domain # Replace with your subdomain, Note: not valid with "apex" domains, e.g. example.com
  type       = "CNAME"
  ttl        = "60"
  records    = [aws_lb.alb.dns_name]
}

