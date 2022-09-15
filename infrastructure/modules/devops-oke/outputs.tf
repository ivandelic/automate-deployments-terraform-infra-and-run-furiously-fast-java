output "devops_id" {
  value = oci_devops_project.devops_project.id
}

output "artifact_manifest" {
  value = local.artifact_manifest
}