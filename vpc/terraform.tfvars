#
customer       = "devops-shared-services"
environment    = "production"
customer_short = "devops-cluster-production"
region         = "us-east-1"
#
vpc_main = {
  #
  cidr_block = "10.200.0.0/20"
  #
  private_subnet_0 = "10.200.0.0/24"
  private_subnet_1 = "10.200.1.0/24"
  #
  public_subnet_0 = "10.200.2.0/24"
  public_subnet_1 = "10.200.3.0/24"
  #
  db_subnet_0 = "10.200.4.0/24"
  db_subnet_1 = "10.200.5.0/24"
  #
  eks_control_panel_0 = "10.200.6.0/24"
  eks_control_panel_1 = "10.200.7.0/24"
  #
  eks_data_panel_0 = "10.200.8.0/24"
  eks_data_panel_1 = "10.200.9.0/24"
  #
}

vpc_centralized = {
  #
  cidr_block = "10.200.64.0/20"
  #
  dns_public_subnet_0 = "10.200.64.0/24"
  dns_public_subnet_1 = "10.200.65.0/24"
}

transit_gateway_id = "tgw-02eb998703a640cad"