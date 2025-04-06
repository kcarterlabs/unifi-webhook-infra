locals {
    config         = yamldecode(file("${path.module}/config.yaml"))
    repositories_map = {
    for repo in local.config.this.repository:
    repo.name => {
    #   description = repo.
    name = repo.name
    image_tag_mutability = repo.image_tag_mutability
    scan_on_push = repo.scan_on_push

    #   private     = repo.visibility == "private" ? true : false
    }
  }
}