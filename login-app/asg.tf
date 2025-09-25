# Find latest Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Launch Template for Ubuntu
resource "aws_launch_template" "app" {
  name_prefix   = "login-app-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get upgrade -y
    apt-get install -y nginx git curl

    cd /home/ubuntu
    git clone https://github.com/<your-repo>.git app
    cd app

    # Install Node.js 18.x
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    apt-get install -y nodejs

    # Install dependencies and start app
    npm install
    nohup npm start &
  EOF
  )
}

# Auto Scaling Group (spread across 3 AZs)
resource "aws_autoscaling_group" "app" {
  desired_capacity    = 3
  max_size            = 10
  min_size            = 3
  vpc_zone_identifier = module.vpc.private_subnets

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = module.alb.target_group_arns
  health_check_type = "EC2"
}
