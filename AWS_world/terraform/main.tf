terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2" // Use a mesma região onde o bucket foi criado
}

# Bloco de recurso que irá "adotar" o bucket existente.
# O nome lógico "logs_bucket" é como o Terraform o conhecerá.


resource "aws_s3_bucket" "logs_bucket" {
  bucket = "justo-bucket-12345" // É uma boa prática definir o nome aqui
  tags = {
    Ambiente = "Legado"
  }
}

resource "aws_instance" "servidor_web" {
  ami           = "ami-0c55b159cbfafe1f0" // Use a AMI exata da sua instância
  instance_type = "t2.micro"                // Use o tipo de instância exato

  tags = {
    Name = "Servidor-Web-Legado"
  }

  // Nota: Terraform também pode detectar outras configurações, como
  // a subnet_id ou o security_group. Adicione-os conforme o 'plan' indicar
  // a necessidade, até que não haja mais diferenças.
}
