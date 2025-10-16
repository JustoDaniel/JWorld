# O Terraformer cria uma pasta com a estrutura completa do Terraform
terraformer import google --resources=instances \
    --filter="name=jmachinesrv002" \
    --regions=us-central1 \
    --projects=terraform-teste-projeto01


    jmachinesrv002