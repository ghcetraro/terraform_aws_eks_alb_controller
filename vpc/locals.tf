locals {
  app_name_dashed = "${var.customer}-${var.environment}"
  #
  aws_profile = "${var.customer}-${var.environment}"
  #
  tags = {
    application_name = local.app_name_dashed
    environment      = var.environment
    provisioner      = "terraform"
  }
  #
  tags_alb = {
    private_subnet = {
      "kubernetes.io/cluster/${local.app_name_dashed}" = "owned"
      "kubernetes.io/role/internal-elb"                = 1
    },
    public_subnet = {
      "kubernetes.io/cluster/${local.app_name_dashed}" = "owned"
      "kubernetes.io/role/elb"                         = 1
    }
  }
}