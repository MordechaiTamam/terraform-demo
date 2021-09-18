provider "github" {
  token = "<ENTER-YOUR-TOKEN>"
}

resource "github_repository" "repo" {
  name        = "test"
  description = "this is test repo"
}