# 🚀 AWS Infrastructure as Code (IaC) with LocalStack & Terraform

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![LocalStack](https://img.shields.io/badge/LocalStack-LightBlue?style=for-the-badge&logo=localstack&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)

Este repositorio contiene una simulación completa de despliegue de infraestructura en AWS utilizando **Terraform** y **LocalStack** para desarrollo y pruebas en local sin incurrir en costes de nube.

## 📌 Características del Proyecto

- **Arquitectura Modular:** Uso de Terraform Modules (principio DRY) para la creación de infraestructura de red (VPC, Subnets, Security Groups).
- **Gestión de Estado Avanzada:** Configuración de Backend remoto simulado en S3.
- **Bloqueo de Estado Nativo:** Implementación del moderno sistema nativo de State Locking en S3 (migrado desde DynamoDB), garantizando la seguridad en entornos colaborativos.
- **CI/CD Pipeline:** Integración con GitHub Actions para automatizar el ciclo de vida de Terraform (`fmt`, `validate`, `plan`, `apply`).

## 📁 Estructura del Repositorio

    .
    ├── .github/
    │   └── workflows/
    │       └── terraform.yml       # Pipeline de CI/CD para GitHub Actions
    ├── modules/
    │   └── red_corporativa/        # Módulo reutilizable de red
    │       ├── main.tf
    │       ├── variables.tf
    │       └── outputs.tf
    ├── main.tf                     # Configuración del Provider, Backend remoto y llamada a módulos
    ├── variables.tf                # Variables globales del proyecto
    ├── .gitignore
    └── README.md


## 🛠️ Requisitos Previos

Para ejecutar este proyecto en tu entorno local necesitas:

* [Docker](https://www.docker.com/) (Para ejecutar LocalStack)
* [Terraform](https://www.terraform.io/downloads.html) (CLI)
* [AWS CLI](https://aws.amazon.com/cli/) o `awslocal` (Opcional, para interactuar con LocalStack)

## 🚀 Guía de Uso Rápido

**1. Levantar el entorno simulado de AWS (LocalStack):**

    docker run -d -p 4566:4566 -p 4510-4559:4510-4559 --name localstack localstack/localstack:3.0.0


**2. Crear el Bucket S3 local (Para guardar el Terraform State):**
*(Ejecutamos el comando dentro del contenedor. Al usar una región distinta a us-east-1, AWS requiere especificar el LocationConstraint)*

    docker exec -it localstack awslocal s3api create-bucket \
        --bucket mi-bucket-devops-local \
        --region eu-west-1 \
        --create-bucket-configuration LocationConstraint=eu-west-1

**3. Inicializar y desplegar la infraestructura:**
*(Entramos en la carpeta de infraestructura donde residen los archivos de Terraform y ejecutamos el despliegue)*

    cd infra
    terraform init
    terraform plan
    terraform apply -auto-approve


## 🧠 Aprendizajes Clave
Este proyecto demuestra habilidades reales de ingeniería DevOps:
- Desvío de endpoints de AWS hacia entornos locales (`endpoint`, `sts_endpoint`).
- Refactorización de código heredado (Migración de bloqueos de estado de DynamoDB a S3 nativo).
- Implementación de flujos de trabajo **GitOps** para prevención de errores en despliegues.

---
*Desarrollado con pasión por la automatización y la infraestructura escalable.* ☁️🏗️