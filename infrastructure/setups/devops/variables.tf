# general
variable "region" {
  type = string
}
variable "tenancy_ocid" {
  type = string
}
variable "compartment_ocid" {
  type = string
}
variable "user_ocid" {
  type = string
}
variable "fingerprint" {
  type = string
}
variable "private_key_path" {
  type = string
}
variable "coderepo_dynamic_group_name" {
  type    = string
  default = null
}
variable "build_dynamic_group_name" {
  type    = string
  default = null
}
variable "deploy_dynamic_group_name" {
  type    = string
  default = null
}
variable "connection_dynamic_group_name" {
  type    = string
  default = null
}
variable "devops_general_policy_name" {
  type    = string
  default = null
}
variable "devops_notification_topic_name" {
  type = string
}
variable "devops_project_name" {
  type = string
}
variable "repository" {
  type = map(object({
    name     = string
    mirrored = optional(object({
      url       = string
      pat_ocid  = string
      frequency = string
    }))
    build_spec_file = optional(string)
    artifacts = optional(object({
      image = map(object({
        image_name       = string
        spec_output_name = string
      }))
      manifest = map(object({
        manifest_name    = string
        spec_output_name = string
      }))
    }))
    deploy_oke = optional(map(object({
      manifest_key = string
    })))
    deploy_oke_bg = optional(map(object({
      manifest_key = string
      ingress_name = string
      namespace_blue = string
      namespace_green = string
    })))
  }))
}
variable "build_branch_name" {
  type = string
}
variable "artifact_repository_name" {
  type = string
}
variable "deployment_oke_cluster_ocid" {
  type = string
}
variable "deployment_oke_cluster_namespace" {
  type = string
}