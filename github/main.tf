provider "github" {
  token = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

resource "github_repository" "repo" {
  name        = "test"
  description = "this is test repo"
}