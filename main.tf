resource "aws_ecr_repository" "this" {
  for_each = local.repositories_map
  name                 = each.key
  image_tag_mutability = each.value.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }
}
