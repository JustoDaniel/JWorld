terraform {
  backend "gcs" {
    bucket = "tf-state-justo"                  # <-- MUDE AQUI para o nome do bucket que você criou
    prefix = "tf-criacaodesnapshot" # (Opcional) Uma pasta dentro do bucket para organizar o estado
  }


}
  