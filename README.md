# Automate Deployments, Terraform Infrastructure and Run Furiously Fast Cloud-Native Java

This comprehansive session will give you an insight how automated CI/CD pipelines, infrastructure as a code, and blazingly fast Java makes the essence of every modern software factory.

## Prerequisites

1. Clone the Git repository
   ```console
   git clone https://github.com/ivandelic/automate-deployments-terraform-infra-and-run-furiously-fast-java.git
   ``` 

## Terraform Inftrastructure
Terraform is an open-source infrastructure as code (IaC) tool that enables you to safely and predictably create, change, and destroy infrastructure with a single CLI command. It follows the Write One Run Anywhere principle. Imagine yourself building complex infrastructure for your cloud-native application, comprised of networking, computes, Kubernetes, streaming, APIs, and databases. Now add the complexity of multiple environments such as development, testing, and production. You are at the inflection point there. Would you create all the components within all environments manually, spending days building them, or would you write it once in the form of code and execute it multiple times for each environment? If the correct answer for you is the latter one for you, keep reading, you are in the right place.

Oracle provides [OCI Terraform Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs), allowing you to use Terraform to interact with Oracle Cloud Infrastructure resources. Moreover, OCI enables you to use [OCI Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm) as a managed Terraform service, enabling larger teams to interact with Terraform resources in a safe and concurrently-safe way.

### Terraform Kubernetes Cluster With Networking
We will terraform OKE as a managed Kubernetes cluster in OCI. OCI Container Engine for Kubernetes is a fully-managed, scalable, and highly available service that you can use to deploy your containerized applications to the cloud. Use Container Engine for Kubernetes (sometimes abbreviated to just OKE) when your development team wants to reliably build, deploy, and manage cloud-native applications. You specify the compute resources that your applications require, and Container Engine for Kubernetes provisions them on Oracle Cloud Infrastructure in an existing OCI tenancy.

### Terraform CI/CD Pipelines
We will Terraform OCI DevOps service. OCI DevOps is a continuous integration and continuous delivery (CI/CD) platform for developers to simplify and automate their software development lifecycle.

1. Get inside setup folder to create infrastructure for OCI DevOps service
   ```
   cd infrastructure/setups/devops
   ```
2. Execute Terraform Init
   ```
   terraform init
   ```
3. Execute Terraform Apply
   ```
   terraform apply -var-file=.tfvars
   ```

Your DevOps Pipeline is created

## Automate Deployments
In the previous chapter, we created an OCI DevOps instance to automate deployments of our blazingly fast Java applications. The OCI DevOps comprises Repositories, Build Pipelines, and Deployment Pipelines. The repository is a managed Git repository. Build Pipelines connect Repository and Artifaces through managed builds, delivering artifacts in the form of container images or other binary formats. Finally, Deployment Pipeline deploys artifacts to environments, such as Kubernetes or computes.

## Run Furiously Fast Java
Furiousley fast java is the essence of the cloud native-native development. Oracle produced and helped building GraalVM, Helidon and Micronaut. GraalVM is a new-generation JVM capable of running and compiling Java apps blazingly fast. Helidon stand for the Java framwoekr for builidng cloud-native applications based on the Micorprofile. New and shiny gem, Micronaut is heavily used as a faster engine building 