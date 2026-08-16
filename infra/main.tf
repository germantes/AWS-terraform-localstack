terraform {
  backend "s3" {
    bucket = "mi-bucket-devops-local"
    key    = "estado-produccion/terraform.tfstate"
    region = "eu-west-1"

    # --- EL NUEVO MÉTODO ---
    use_lockfile = true

    # --- Trampas para LocalStack ---
    endpoint     = "http://127.0.0.1:4566"
    sts_endpoint = "http://127.0.0.1:4566"

    access_key                  = "test"
    secret_key                  = "test"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}
provider "aws" {
  region                      = "eu-west-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    # Apuntamos el servicio S3 a nuestro contenedor local
    s3       = "http://127.0.0.1:4566"
    dynamodb = "http://127.0.0.1:4566"
  }
}

# Creamos el Bucket de almacenamiento
resource "aws_s3_bucket" "mi_almacenamiento" {
  # Cambiamos el nombre para que no choque con el bucket del Backend
  bucket = "mi-bucket-aplicacion-datos"

  tags = {
    Name        = "Bucket de la App"
    Environment = "Desarrollo"
  }
}

# Output para que Terraform nos confirme que se ha creado
output "nombre_del_bucket" {
  description = "El nombre oficial de mi bucket"
  value       = aws_s3_bucket.mi_almacenamiento.id
}
