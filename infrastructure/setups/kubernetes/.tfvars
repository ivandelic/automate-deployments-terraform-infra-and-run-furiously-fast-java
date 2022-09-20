# general
region                           = "eu-frankfurt-1"
tenancy_ocid                     = "ocid1.tenancy.oc1..aaaaaaaa4wptnxymnypvjjltnejidchjhz6uimlhru7rdi5qb6qlnmrtgu3a"
compartment_ocid                 = "ocid1.compartment.oc1..aaaaaaaalhqqlxb2j6zg3oboosynkhpthizwpepldbifo2k45brd77sstirq"

# user identity
user_ocid                        = "ocid1.user.oc1..aaaaaaaazo3rolq26rx74vfgb763ud5octnkobpz2bx7oa3eemc4lj7yboaq"
fingerprint                      = "03:4b:e0:f9:46:28:2c:7b:f3:c8:f8:5b:ce:e4:e5:3d"
private_key_path                 = "/Users/ivandelic/.oci/oci_api_key_emeadsappdev.pem"

name = "cloud-coach"

# VCN
vcn_cidr = "10.10.0.0/16"
vcn_subnets = {
  load-balancer = {
    cidr_block = "10.10.10.0/24"
    is_public  = true
    rt_rules = [
      {
        description         = "Traffic from Internet"
        destination         = "0.0.0.0/0"
        destination_type    = "CIDR_BLOCK"
        network_entity_type = "ig"
      }
    ]
    sl_rules = {
      egress_security_rules = [
        {
          destination = "10.10.20.0/24"
          protocol    = "6"
          tcp_options = {
            min = 30000
            max = 32767
          }
        }
      ]
      ingress_security_rules = [
        {
          protocol  = "6"
          source    = "0.0.0.0/0"
          stateless = false
          tcp_options = {
            min = 80
            max = 80
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          source_type = "CIDR_BLOCK"
          stateless   = false
          tcp_options = {
            max = 443
            min = 443
          }
        }
      ]
    }
  }
  worker-node = {
    cidr_block = "10.10.20.0/24"
    is_public  = false
    rt_rules = [
      {
        description         = "Traffic to Internet"
        destination         = "0.0.0.0/0"
        destination_type    = "CIDR_BLOCK"
        network_entity_type = "ng"
      },
      {
        description         = "traffic to OCI services"
        destination         = "all-fra-services-in-oracle-services-network"
        destination_type    = "SERVICE_CIDR_BLOCK"
        network_entity_type = "sg"
      }
    ]
    sl_rules = {
      egress_security_rules = [
        {
          description      = "Allow pods on one worker node to communicate with pods on other worker nodes"
          destination      = "10.10.20.0/24"
          destination_type = "CIDR_BLOCK"
          protocol         = "all"
        },
        {
          description      = "Path Discovery"
          destination      = "0.0.0.0/0"
          destination_type = "CIDR_BLOCK"
          icmp_options = {
            code = "4"
            type = "3"
          }
          protocol = "1"
        },
        {
          description      = "Allow nodes to communicate with OKE"
          destination      = "all-fra-services-in-oracle-services-network"
          destination_type = "SERVICE_CIDR_BLOCK"
          protocol         = "6"
        },
        {
          description      = "Access to Kubernetes API Endpoint"
          destination      = "10.10.30.0/24"
          destination_type = "CIDR_BLOCK"
          protocol         = "6"
          tcp_options = {
            min = 6443
            max = 6443
          }
        },
        {
          description      = "Kubernetes worker to control plane communication"
          destination      = "10.10.30.0/24"
          destination_type = "CIDR_BLOCK"
          protocol         = "6"
          tcp_options = {
            min = 12250
            max = 12250
          }
        },
        {
          description      = "Worker Nodes access to Internet"
          destination      = "0.0.0.0/0"
          destination_type = "CIDR_BLOCK"
          protocol         = "6"
        }
      ]
      ingress_security_rules = [
        {
          description = "Allow pods on one worker node to communicate with pods on other worker nodes"
          protocol    = "all"
          source      = "10.10.20.0/24"
        },
        {
          description = "TCP access from Kubernetes Control Plane"
          protocol    = "6"
          source      = "10.10.30.0/24"
        },
        {
          description = "Path discovery"
          icmp_options = {
            code = "4"
            type = "3"
          }
          protocol = "1"
          source   = "0.0.0.0/0"
        },
        {
          description = "Inbound SSH traffic to worker nodes"
          protocol    = "6"
          source      = "0.0.0.0/0"
          tcp_options = {
            min = 22
            max = 22
          }
        },
        {
          description = "Inbound k8s traffic from load balancers"
          protocol    = "6"
          source      = "10.10.10.0/24"
          stateless   = "false"
          tcp_options = {
            min = 30000
            max = 32767
          }
        }
      ]
    }
  }
  endpoint-api = {
    cidr_block = "10.10.30.0/24"
    is_public  = true
    rt_rules = [
      {
        description         = "Traffic to Internet"
        destination         = "0.0.0.0/0"
        destination_type    = "CIDR_BLOCK"
        network_entity_type = "ig"
      }
    ]
    sl_rules = {
      egress_security_rules = [
        {
          description      = "Allow Kubernetes Control Plane to communicate with OKE"
          destination      = "all-fra-services-in-oracle-services-network"
          destination_type = "SERVICE_CIDR_BLOCK"
          protocol         = "6"
          tcp_options = {
            min = 443
            max = 443
          }
        },
        {
          description      = "All traffic to worker nodes"
          destination      = "10.10.20.0/24"
          destination_type = "CIDR_BLOCK"
          protocol         = "6"
        },
        {
          description      = "Path discovery"
          destination      = "10.10.20.0/24"
          destination_type = "CIDR_BLOCK"
          icmp_options = {
            code = "4"
            type = "3"
          }
          protocol = "1"
        }
      ]
      ingress_security_rules = [
        {
          description = "External access to Kubernetes API endpoint"
          protocol    = "6"
          source      = "0.0.0.0/0"
          tcp_options = {
            min = 6443
            max = 6443
          }
        },
        {
          description = "Kubernetes worker to Kubernetes API endpoint communication"
          protocol    = "6"
          source      = "10.10.20.0/24"
          tcp_options = {
            min = 6443
            max = 6443
          }
        },
        {
          description = "Kubernetes worker to control plane communication"
          protocol    = "6"
          source      = "10.10.20.0/24"
          tcp_options = {
            min = 12250
            max = 12250
          }
        },
        {
          description = "Path discovery"
          icmp_options = {
            code = "4"
            type = "3"
          }
          protocol = "1"
          source   = "10.10.20.0/24"
        }
      ]
    }
  }
}

# OKE
pool_name     = "cloud-coach-pool-1"
pool_total_vm = 3
vm_shape      = "VM.Standard.E4.Flex"
vm_memory     = 16
vm_ocpu       = 2
vm_image_name = "Oracle-Linux-7.9-2022.06.30-0"
#vm_defined_tags        = { "Schedule.AnyDay" = "0,0,0,0,0,0,0,*,*,*,*,*,*,*,*,*,*,*,0,0,0,0,0,0" }
k8s_version            = "v1.24.1"
k8s_is_public_endpoint = true

# DNS
dns_zone_parent  = "ivandelic.com"
dns_zone_enabled = true
dns_record_helm = "helm-ui"
dns_record_c2 = "warp-engine-c2"
dns_record_graal = "warp-engine-graal"
dns_record_native = "warp-engine-native"

# OCIR
ocir_url = "fra.ocir.io"
ocir_username = "frsxwtjslf35/oracleidentitycloudservice/ivan.delic@oracle.com"
ocir_email = "ivan.delic@oracle.com"