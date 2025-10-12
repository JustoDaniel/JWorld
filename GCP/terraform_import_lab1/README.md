

# Abre o navegador para você fazer login com sua conta Google
''' bash
gcloud auth login
'''

# Define o projeto que você vai usar em todos os comandos seguintes
''' bash
gcloud config set project terraform-teste-projeto01
'''

# Habilitar a API para o Cloud Storage (nosso "S3")
''' bash
gcloud services enable storage.googleapis.com
gcloud services enable compute.googleapis.com
'''