variable "parent_compartment_ocid" {
  type = string
}


variable "projects" {
  description = "Mapa de projetos e seus filhos"
  type = map(object({
    children = list(string)
  }))
}