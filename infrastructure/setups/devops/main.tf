terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.92.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

data "oci_identity_compartment" "compartment" {
  id = var.compartment_ocid
}

module "cloud-coach-automate-deployments" {
  source                           = "../../../modules/devops-oke"
  compartment_ocid                 = var.compartment_ocid
  compartment_name                 = data.oci_identity_compartment.compartment.name
  tenancy_ocid                     = var.tenancy_ocid
  coderepo_dynamic_group_name      = var.coderepo_dynamic_group_name
  build_dynamic_group_name         = var.build_dynamic_group_name
  deploy_dynamic_group_name        = var.deploy_dynamic_group_name
  connection_dynamic_group_name    = var.connection_dynamic_group_name
  devops_general_policy_name       = var.devops_general_policy_name
  devops_notification_topic_name   = var.devops_notification_topic_name
  devops_project_name              = var.devops_project_name
  build_branch_name                = var.build_branch_name
  artifact_repository_name         = var.artifact_repository_name
  deployment_oke_cluster_ocid      = var.deployment_oke_cluster_ocid
  deployment_oke_cluster_namespace = var.deployment_oke_cluster_namespace
  repository                       = var.repository
}

output "devops_repository" {
  value = module.cloud-coach-automate-deployments.devops_repository
}