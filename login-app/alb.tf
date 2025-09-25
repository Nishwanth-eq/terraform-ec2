module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.6.0"

  name               = "login-app-alb"
  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.alb_sg.id]

  http_tcp_listeners = [{
    port               = 80
    protocol           = "HTTP"
    action_type        = "redirect"
    redirect           = { port = "443", protocol = "HTTPS", status_code = "HTTP_301" }
  }]

  https_listeners = [{
    port               = 443
    protocol           = "HTTPS"
    certificate_arn    = var.acm_cert_arn
    action_type        = "forward"
    target_group_index = 0
  }]

  target_groups = [{
    name_prefix      = "login"
    backend_protocol = "HTTP"
    backend_port     = 80
    target_type      = "instance"
    health_check = {
      path = "/health"
    }
  }]
}
