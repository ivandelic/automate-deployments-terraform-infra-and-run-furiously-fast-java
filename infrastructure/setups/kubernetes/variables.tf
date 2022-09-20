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

# user identity
variable "user_ocid" {
  type = string
}
variable "fingerprint" {
  type = string
}
variable "private_key_path" {
  type = string
}

variable "name" {
  type = string
}

variable "vcn_cidr" {
  type = string
}

variable "vcn_subnets" {
  default = null
  type = map(object({
    cidr_block = string
    is_public  = bool
    rt_rules = list(object({
      description         = string
      destination         = string
      destination_type    = string
      network_entity_type = string
      network_entity_id   = optional(string)
    }))
    sl_rules = object({
      egress_security_rules = optional(list(object({
        destination      = string
        protocol         = string
        description      = optional(string)
        destination_type = optional(string)
        stateless        = optional(bool)
        tcp_options = optional(object({
          min = number
          max = number
        }))
        udp_options = optional(object({
          min = number
          max = number
        }))
        icmp_options = optional(object({
          type = number
          code = optional(number)
        }))
      })))
      ingress_security_rules = optional(list(object({
        source      = string
        protocol    = string
        description = optional(string)
        source_type = optional(string)
        stateless   = optional(bool)
        tcp_options = optional(object({
          min = number
          max = number
        }))
        udp_options = optional(object({
          min = number
          max = number
        }))
        icmp_options = optional(object({
          type = number
          code = optional(number)
        }))
      })))
    })
  }))
}

variable "dns_zone_parent" {
  type = string
}

variable "dns_zone_enabled" {
  type = bool
}

variable "dns_record_helm" {
  type = string
}

variable "dns_record_c2" {
  type = string
}

variable "dns_record_graal" {
  type = string
}

variable "dns_record_native" {
  type = string
}

variable "pool_name" {
  type = string
}

variable "pool_total_vm" {
  type = string
}

variable "vm_shape" {
  type = string
}

variable "vm_memory" {
  type = number
}

variable "vm_ocpu" {
  type = number
}

variable "vm_image_name" {
  type = string
}


variable "vm_defined_tags" {
  type = map
  default = {}
}

variable "k8s_version" {
  type = string
}

variable "k8s_is_public_endpoint" {
  type = string
}

variable "ocir_url" {
  type = string
}

variable "ocir_username" {
  type = string
}

variable "ocir_password" {
  type = string
  sensitive   = true
}

variable "ocir_email" {
  type = string
}