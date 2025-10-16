provider "google" {
  project = "terraform-teste-projeto01"
}

terraform {
	required_providers {
		google = {
	    version = "~> 5.45.2"
		}
  }
  
}
