variable "repo_max" {
  type        = number
  description = "No. of repositories"
  default     = 1
  validation {
    condition     = var.repo_max <= 5
    error_message = "Repo count must be less than 5"
  }
}

variable "repos" {
  type        = set(string)
  description = "Repository names"
  validation {
    condition = length(var.repos) <= var.repo_max
    error_message = "Not more than 5 repos please"
  }
}

# variable "varsource" {
#   type = string
#   description = "Source used to define variables"
#   #default = "variables.tfvars"
# }

variable "env" {
  type        = string
  description = "Environment type"
  default     = "dev"
  validation {
    #condition = var.env == "dev" || var.env == "prod"
    condition     = contains(["dev", "prod"], var.env)
    error_message = "Environment must either be 'dev' or 'prod'"
  }
}