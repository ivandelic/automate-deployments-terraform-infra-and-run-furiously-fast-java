region                           = "eu-frankfurt-1"
tenancy_ocid                     = "ocid1.tenancy.oc1..aaaaaaaa4wptnxymnypvjjltnejidchjhz6uimlhru7rdi5qb6qlnmrtgu3a"
compartment_ocid                 = "ocid1.compartment.oc1..aaaaaaaalhqqlxb2j6zg3oboosynkhpthizwpepldbifo2k45brd77sstirq"
user_ocid                        = "ocid1.user.oc1..aaaaaaaazo3rolq26rx74vfgb763ud5octnkobpz2bx7oa3eemc4lj7yboaq"
fingerprint                      = "03:4b:e0:f9:46:28:2c:7b:f3:c8:f8:5b:ce:e4:e5:3d"
private_key_path                 = "/Users/ivandelic/.oci/oci_api_key_emeadsappdev.pem"
devops_notification_topic_name   = "cloud-coach-automate-deployments"
devops_project_name              = "cloud-coach-automate-deployments"
build_branch_name                = "main"
artifact_repository_name         = "cloud-coach-automate-deployments"
deployment_oke_cluster_ocid      = "ocid1.cluster.oc1.eu-frankfurt-1.aaaaaaaannekvtgydrlyego4nrorbbglrk7ffz3d4hoa7z3ufcecxnwzoweq"
deployment_oke_cluster_namespace = "default"
### Reusing dynamic groups and policies
coderepo_dynamic_group_name      = "CoderepoDG-cloud-native-stars"
build_dynamic_group_name         = "BuildDG-cloud-native-stars"
deploy_dynamic_group_name        = "DeployDG-cloud-native-stars"
connection_dynamic_group_name    = "ConnectionDG-cloud-native-stars"
devops_general_policy_name       = "DevOps-cloud-native-stars"
### Pipelines and Repos definition
repository                       = {
  helm-ui = {
    name      = "helm-ui"
    artifacts = {
      image = {
        helm-ui = {
          image_name       = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/helm-ui"
          spec_output_name = "helm-ui"
        }
      }
      manifest = {
        helm-ui = {
          manifest_name    = "helm-ui-cicd.yaml"
          spec_output_name = "helm_ui_yaml"
        }
      }
    }
    deploy_oke_bg = {
      helm-ui = {
        manifest_key = "helm-ui"
        ingress_name = "cns-helm-ui"
        namespace_blue = "cns-blue"
        namespace_green = "cns-green"
      }
    }
    build_parameters = {
      buildId = {
        name = "buildId"
        default_value = "id"
      }
      helmImageBaseUrl = {
        name = "helmImageBaseUrl"
        default_value = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/helm-ui"
      }
    }
    deploy_parameters = {
      buildId = {
        name = "buildId"
        default_value = "id"
      }
      helmImageBaseUrl = {
        name = "helmImageBaseUrl"
        default_value = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/helm-ui"
      }
      urlHelidonGraal = {
        name = "urlHelidonGraal"
        default_value = "http://warp-engine-graal.cloud-coaching.ivandelic.com/universe/traverse"
      }
      urlHelidonC2 = {
        name = "urlHelidonC2"
        default_value = "http://warp-engine-c2.cloud-coaching.ivandelic.com/universe/traverse"
      }
      urlMicronautNative = {
        name = "urlMicronautNative"
        default_value = "http://warp-engine-native.cloud-coaching.ivandelic.com/universe/traverse"
      }
      urlHelm = {
        name = "urlHelm"
        default_value = "helm-ui.cloud-coaching.ivandelic.com"
      }
    }
  }
  warp-engine-c2 = {
    name      = "warp-engine-c2"
    artifacts = {
      image = {
        warp-engine-c2 = {
          image_name       = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/warp-engine-c2"
          spec_output_name = "warp-engine-c2"
        }
      }
      manifest = {
        warp-engine-c2 = {
          manifest_name    = "warp-engine-c2-cicd.yaml"
          spec_output_name = "warp_engine_c2_yaml"
        }
      }
    }
    deploy_oke = {
      warp-engine-c2 = {
        manifest_key = "warp-engine-c2"
      }
    }
    build_parameters = {
      buildId = {
        name = "buildId"
        default_value = "id"
      }
      helidonC2ImageBaseUrl = {
        name = "helidonC2ImageBaseUrl"
        default_value = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/warp-engine-c2"
      }
    }
    deploy_parameters = {
      buildId = {
        name = "buildId"
        default_value = "id"
      }
      helidonC2ImageBaseUrl = {
        name = "helidonC2ImageBaseUrl"
        default_value = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/warp-engine-c2"
      }
      urlHelidonC2 = {
        name = "urlHelidonC2"
        default_value = "warp-engine-c2.cloud-coaching.ivandelic.com"
      }
    }
  }
  warp-engine-graal = {
    name      = "warp-engine-graal"
    artifacts = {
      image = {
        warp-engine-graal = {
          image_name       = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/warp-engine-graal"
          spec_output_name = "warp-engine-graal"
        }
      }
      manifest = {
        warp-engine-graal = {
          manifest_name    = "warp-engine-graal-cicd.yaml"
          spec_output_name = "warp_engine_graal_yaml"
        }
      }
    }
    deploy_oke = {
      warp-engine-graal = {
        manifest_key = "warp-engine-graal"
      }
    }
    build_parameters = {
      buildId = {
        name = "buildId"
        default_value = "id"
      }
      helidonGraalImageBaseUrl = {
        name = "helidonGraalImageBaseUrl"
        default_value = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/warp-engine-graal"
      }
    }
    deploy_parameters = {
      buildId = {
        name = "buildId"
        default_value = "id"
      }
      helidonGraalImageBaseUrl = {
        name = "helidonGraalImageBaseUrl"
        default_value = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/warp-engine-graal"
      }
      urlHelidonGraal = {
        name = "urlHelidonGraal"
        default_value = "warp-engine-graal.cloud-coaching.ivandelic.com"
      }
    }
  }
  warp-engine-native = {
    name      = "warp-engine-native"
    artifacts = {
      image = {
        warp-engine-native = {
          image_name       = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/warp-engine-native"
          spec_output_name = "warp-engine-native"
        }
      }
      manifest = {
        warp-engine-native = {
          manifest_name    = "warp-engine-native-cicd.yaml"
          spec_output_name = "warp_engine_native_yaml"
        }
      }
    }
    deploy_oke = {
      warp-engine-native = {
        manifest_key = "warp-engine-native"
      }
    }
    build_parameters = {
      buildId = {
        name = "buildId"
        default_value = "id"
      }
      micronautNativeImageBaseUrl = {
        name = "micronautNativeImageBaseUrl"
        default_value = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/warp-engine-micronaut-native"
      }
    }
    deploy_parameters = {
      buildId = {
        name = "buildId"
        default_value = "id"
      }
      micronautNativeImageBaseUrl = {
        name = "micronautNativeImageBaseUrl"
        default_value = "fra.ocir.io/frsxwtjslf35/cloud-coach-automate-deployments/warp-engine-micronaut-native"
      }
      urlMicronautNative = {
        name = "urlMicronautNative"
        default_value = "warp-engine-native.cloud-coaching.ivandelic.com"
      }
    }
  }
}