terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.92.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.6.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.13.1"
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

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

data "oci_core_images" "oke_images" {
  compartment_id = var.compartment_ocid
  display_name   = var.vm_image_name #"Oracle-Linux-7.9-2022.05.31-0"
}

module "vcn" {
  source           = "../../modules/network-standard"
  compartment_ocid = var.compartment_ocid
  dns_zone_name    = var.name
  dns_zone_parent  = var.dns_zone_parent
  dns_zone_enabled = var.dns_zone_enabled
  name             = var.name
  vcn_cidr         = var.vcn_cidr
  vcn_subnets      = var.vcn_subnets
}

module "oke-cluster" {
  source                 = "../../modules/oke-standard"
  compartment_ocid       = var.compartment_ocid
  name                   = var.name
  vcn_id                 = module.vcn.vcn_id
  subnet_id_endpoint     = module.vcn.subnets["endpoint-api"].id
  subnet_id_lb           = module.vcn.subnets["load-balancer"].id
  subnet_id_node         = module.vcn.subnets["worker-node"].id
  k8s_version            = var.k8s_version
  k8s_is_public_endpoint = var.k8s_is_public_endpoint
  pool_name              = var.pool_name
  pool_total_vm          = var.pool_total_vm
  vm_shape               = var.vm_shape
  vm_memory              = var.vm_memory
  vm_ocpu                = var.vm_ocpu
  vm_image_id            = data.oci_core_images.oke_images.images[0].id
  vm_defined_tags        = var.vm_defined_tags
}

data "oci_containerengine_cluster_kube_config" "cluster_kube_config" {
  cluster_id = module.oke-cluster.oke_id
}

resource "oci_core_public_ip" "ingress_public_ip" {
  lifecycle {
    ignore_changes = [private_ip_id]
  }
  compartment_id = var.compartment_ocid
  lifetime = "RESERVED"
}

resource "oci_dns_rrset" "rrset_main" {
  domain = join(".", ["ingress", var.name, var.dns_zone_parent])
  rtype = "A"
  zone_name_or_id = module.vcn.zone_id
  items {
    domain = join(".", ["ingress", var.name, var.dns_zone_parent])
    rdata = oci_core_public_ip.ingress_public_ip.ip_address
    rtype = "A"
    ttl = 30
  }
}

resource "oci_dns_rrset" "rrset_c2" {
  domain = join(".", [var.dns_record_c2, var.name, var.dns_zone_parent])
  rtype = "CNAME"
  zone_name_or_id = module.vcn.zone_id
  items {
    domain = join(".", [var.dns_record_c2, var.name, var.dns_zone_parent])
    rdata = join(".", ["ingress", var.name, var.dns_zone_parent])
    rtype = "CNAME"
    ttl = 30
  }
}

resource "oci_dns_rrset" "rrset_graal" {
  domain = join(".", [var.dns_record_graal, var.name, var.dns_zone_parent])
  rtype = "CNAME"
  zone_name_or_id = module.vcn.zone_id
  items {
    domain = join(".", [var.dns_record_graal, var.name, var.dns_zone_parent])
    rdata = join(".", ["ingress", var.name, var.dns_zone_parent])
    rtype = "CNAME"
    ttl = 30
  }
}

resource "oci_dns_rrset" "rrset_native" {
  domain = join(".", [var.dns_record_native, var.name, var.dns_zone_parent])
  rtype = "CNAME"
  zone_name_or_id = module.vcn.zone_id
  items {
    domain = join(".", [var.dns_record_native, var.name, var.dns_zone_parent])
    rdata = join(".", ["ingress", var.name, var.dns_zone_parent])
    rtype = "CNAME"
    ttl = 30
  }
}

resource "oci_dns_rrset" "rrset_helm" {
  domain = join(".", [var.dns_record_helm, var.name, var.dns_zone_parent])
  rtype = "CNAME"
  zone_name_or_id = module.vcn.zone_id
  items {
    domain = join(".", [var.dns_record_helm, var.name, var.dns_zone_parent])
    rdata = join(".", ["ingress", var.name, var.dns_zone_parent])
    rtype = "CNAME"
    ttl = 30
  }
}

provider "helm" {
  kubernetes {
    host                   = local.cluster_endpoint
    cluster_ca_certificate = local.cluster_ca_certificate
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["ce", "cluster", "generate-token", "--cluster-id", local.cluster_id, "--region", local.cluster_region]
      command     = "oci"
    }
  }
}

provider "kubernetes" {
  host                   = local.cluster_endpoint
  cluster_ca_certificate = local.cluster_ca_certificate
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["ce", "cluster", "generate-token", "--cluster-id", local.cluster_id, "--region", local.cluster_region]
    command     = "oci"
  }
}

locals {
  cluster_endpoint       = yamldecode(data.oci_containerengine_cluster_kube_config.cluster_kube_config.content)["clusters"][0]["cluster"]["server"]
  cluster_ca_certificate = base64decode(yamldecode(data.oci_containerengine_cluster_kube_config.cluster_kube_config.content)["clusters"][0]["cluster"]["certificate-authority-data"])
  cluster_id             = yamldecode(data.oci_containerengine_cluster_kube_config.cluster_kube_config.content)["users"][0]["user"]["exec"]["args"][4]
  cluster_region         = yamldecode(data.oci_containerengine_cluster_kube_config.cluster_kube_config.content)["users"][0]["user"]["exec"]["args"][6]
}

resource "helm_release" "nginx_ingress" {
  depends_on = [module.oke-cluster]
  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  set {
    name  = "service.loadBalancerIP"
    value = oci_core_public_ip.ingress_public_ip.ip_address
  }
}

resource "kubernetes_secret" "ocir_secret" {
  metadata {
    name = "ocirsecret"
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.ocir_url}" = {
          "username" = var.ocir_username
          "password" = var.ocir_password
          "email"    = var.ocir_email
        }
      }
    })
  }
}

resource "kubernetes_namespace" "namespace_blue" {
  metadata {
    name = "blue"
  }
}

resource "kubernetes_namespace" "namespace_green" {
  metadata {
    name = "green"
  }
}

resource "kubernetes_secret" "ocir_secret_blue" {
  metadata {
    name = "ocirsecret"
    namespace = "blue"
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.ocir_url}" = {
          "username" = var.ocir_username
          "password" = var.ocir_password
          "email"    = var.ocir_email
        }
      }
    })
  }
}

resource "kubernetes_secret" "ocir_secret_green" {
  metadata {
    name = "ocirsecret"
    namespace = "green"
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.ocir_url}" = {
          "username" = var.ocir_username
          "password" = var.ocir_password
          "email"    = var.ocir_email
        }
      }
    })
  }
}

output "oke_id" {
  value = module.oke-cluster.oke_id
}