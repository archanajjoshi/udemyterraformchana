# resource "random_id" "randomid" {
#   byte_length = 2
#   count       = var.repo_count
# }

resource "github_repository" "tf_repo" {
  for_each    = var.repos
  name        = "tf-repo-${each.key}"
  description = "tf code for ${each.value}"
  visibility  = var.env == "dev" ? "private" : "public"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  for_each            = var.repos
  repository          = github_repository.tf_repo[each.key].name
  file                = "README.md"
  content             = "# This README is for ${each.value} repo"
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  for_each            = var.repos
  repository          = github_repository.tf_repo[each.key].name
  file                = "index.html for ${each.value} repo"
  content             = "Hello tf"
  overwrite_on_create = true
}

output "gh-repo-names" {
  value       = { for i in github_repository.tf_repo : i.full_name => i.http_clone_url }
  description = "Github Repo Names and URL"
  sensitive   = false
}

# output "varsource" {
#   value = var.varsource
#   description = "Source being used to source the variable definition"
# }