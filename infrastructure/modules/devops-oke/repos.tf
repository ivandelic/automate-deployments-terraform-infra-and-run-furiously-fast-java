resource "oci_artifacts_repository" "artifacts_repository" {
    count          = length(local.artifact_manifest) > 0 ? 1 : 0
    compartment_id = var.compartment_ocid
    is_immutable = false
    display_name = var.artifact_repository_name
    repository_type = "generic"
}