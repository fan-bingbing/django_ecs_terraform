data "aws_route53_zone" "selected" {
  name         = "rfexpert.net"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "www.rfexpert.net"
  type    = "A"

  alias {
    name                   = aws_lb.production.dns_name
    zone_id                = aws_lb.production.zone_id
    evaluate_target_health = true
  }
}
