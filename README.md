# README

This repository is used to install vpc with tags and aws alb controller in aws with terraform

## Locals

	The missing information of the external components required needs to be completed
```
    id                         = " " # to fill 
    endpoint                   = " " # to fill 
    certificate_authority_data = " " # to fill 
    oidc_issuer_url            = " " # to fill 

    vpc = {
      id = " " # to fill 
```

## Configuration with aws sso

  - You need to create/configure your parameters in the following file  
```
    terraform.tfvars
```

  - You need to create your profile in your .aws/config and .aws/credentials

.aws/config  
```
	[profile devops]
	sso_start_url=<url>
	sso_region=<region>
	sso_account_id=<account id>
	sso_role_name=<role name>
	region=<defaul region>
	output=json
```

  - Run to obtain the credentials

  	aws sso login --profile devops

### *Terraform Individual Variables*

```
	alb-controller
	vpc
```

## Running

To run the following scripts, you will need to have ADMIN privileges.

  Following 3 commands need to be executed for every deployment
``` 
  terraform init 
  terraform plan 
  terraform apply 
```

## Pre-requisites

- Terraform CLI is [installed](https://learn.hashicorp.com/tutorials/terraform/install-cli).  
- AWS CLI [installed](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).  

## Resources

Resources that are going to be deployed  
```
	AWS  
		alb  
		targets
		roles  
		polices  
		targets
		security groups  

	EKS
		secrets
		configmap
		service account
		role
		role attachment
```

## Dependencies
	
	VPC
	EKS

### VPC Requirements

	Need to tag subnets

	 public_subnet_tags = {
    	"kubernetes.io/cluster/${local.app_name_dashed}" = "owned"
    	"kubernetes.io/role/elb"                         = 1
  		}

  	private_subnet_tags = {
    	"kubernetes.io/cluster/${local.app_name_dashed}" = "owned"
    	"kubernetes.io/role/internal-elb"                = 1
  		}