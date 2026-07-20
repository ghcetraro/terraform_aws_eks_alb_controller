# Uso y despliegue

## Descripción

VPC etiquetada para EKS y AWS Load Balancer Controller — base de ingress en AWS

Terraform en dos módulos: VPC con tags para EKS y despliegue del AWS Load Balancer Controller con IRSA.

## Requisitos

- Terraform 1.x
- AWS CLI con permisos adecuados
- Para módulos EKS: cluster existente y acceso de API

## Variables

Usá siempre la plantilla **`terraform.tfvars.example`**. No subas `terraform.tfvars` ni el state.

### Módulo `vpc/`

```bash
cd vpc
cp terraform.tfvars.example terraform.tfvars
# Completar variables y locals según tu cuenta/cluster

aws sso login --profile <tu-profile>   # o credenciales equivalentes
terraform init
terraform plan
terraform apply
```

### Módulo `alb-controller/`

```bash
cd alb-controller
cp terraform.tfvars.example terraform.tfvars
# Completar variables y locals según tu cuenta/cluster

aws sso login --profile <tu-profile>   # o credenciales equivalentes
terraform init
terraform plan
terraform apply
```


## Post-apply

Revisá outputs del módulo y recursos en la consola AWS / `kubectl` según corresponda.

## Seguridad

Ver [SECURITY.md](../SECURITY.md).
