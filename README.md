# VPC + AWS Load Balancer Controller (EKS)

[![License: MIT](https://img.shields.io/github/license/ghcetraro/terraform_aws_eks_alb_controller)](LICENSE)
[![Terraform](https://img.shields.io/badge/terraform-1.x-7B42BC.svg)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-compatible-FF9900.svg)](https://aws.amazon.com/)
[![CI](https://github.com/ghcetraro/terraform_aws_eks_alb_controller/actions/workflows/ci.yml/badge.svg)](https://github.com/ghcetraro/terraform_aws_eks_alb_controller/actions/workflows/ci.yml)

**VPC etiquetada para EKS y AWS Load Balancer Controller — base de ingress en AWS**

---

## El problema

Sin tags correctos en la VPC/subnets y sin el ALB Controller, los Ingress de EKS no crean load balancers de forma confiable.

## La solución

Terraform en dos módulos: VPC con tags para EKS y despliegue del AWS Load Balancer Controller con IRSA.

```mermaid
flowchart TB
  TF[Terraform] --> VPC[VPC + tags]
  TF --> ALBC[ALB Controller]
  ALBC --> EKS[EKS]
  ING[Ingress] --> ALBC
  ALBC --> ALB[AWS ALB]
```

---

## Características

| Área | Detalle |
|------|---------|
| **VPC** | Tags listos para EKS / ALB discovery |
| **ALB Controller** | Helm/Terraform sobre el cluster |
| **IRSA** | Roles IAM vía OIDC del cluster |
| **Ejemplo** | Carpeta `example/` de referencia |
| **Modular** | `vpc/` + `alb-controller/` |

---

## Limitaciones y disclaimer

- Pensado como **punto de partida / referencia**: revisá roles IAM, redes y secretos antes de producción.
- Requiere **credenciales AWS** (recomendado SSO) y, en módulos EKS, acceso al cluster (kubeconfig / exec).
- Completá `locals` y variables según tu cuenta; los ejemplos usan valores ficticios.
- Software open source “as is” — probá primero en un ambiente no productivo.

---

## Stack

Terraform · VPC · EKS · AWS Load Balancer Controller · IRSA

---

## Inicio rápido

### Requisitos

- Terraform CLI 1.x
- AWS CLI configurado (`aws sso login` o credenciales)
- Permisos de administración en la cuenta / cluster según el módulo

### Configuración

```bash
cp vpc/terraform.tfvars.example / alb-controller/terraform.tfvars.example terraform.tfvars   # ajustá path si hay submódulos
# Completar variables — no commitear terraform.tfvars
```

Valores de ejemplo: `vpc/terraform.tfvars.example` / `alb-controller/terraform.tfvars.example`

### Apply

```bash
cd vpc
cp terraform.tfvars.example terraform.tfvars
# Editar valores (cuenta, región, cluster, etc.)

terraform init
terraform plan
terraform apply
```
```bash
cd alb-controller
cp terraform.tfvars.example terraform.tfvars
# Editar valores (cuenta, región, cluster, etc.)

terraform init
terraform plan
terraform apply
```

---

## Documentación

- [Uso y despliegue](docs/uso.md)
- [Presentación / LinkedIn](docs/PRESENTACION.md)
- [Speech para LinkedIn](docs/speech-linkedin.md)
- [Changelog](CHANGELOG.md)
- [Contribuir](CONTRIBUTING.md)
- [Seguridad](SECURITY.md)

---

## Seguridad

**No commitees** `terraform.tfvars`, state, claves ni tokens. Usá `*.tfvars.example` como plantilla.

Ver [SECURITY.md](SECURITY.md).

---

## Licencia

[MIT](LICENSE) — Copyright (c) Gabriel Cetraro

---

## Autor

Proyecto open source de **Gabriel Cetraro** — automatización de infraestructura, AWS, Kubernetes y observabilidad.

Si te resulta útil, ⭐ en GitHub ayuda a darle visibilidad.
