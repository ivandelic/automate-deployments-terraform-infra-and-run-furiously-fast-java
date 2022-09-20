# Automate Deployments, Terraform Infrastructure and Run Furiously Fast Cloud-Native Java

This comprehansive session will give you an insight how automated CI/CD pipelines, infrastructure as a code, and blazingly fast Java makes the essence of every modern software factory.

## Prerequisites

1. Clone the Git repository
   ```console
   git clone https://github.com/ivandelic/automate-deployments-terraform-infra-and-run-furiously-fast-java.git
   ``` 
2. Disconnet and remove Git
   ```
   cd automate-deployments-terraform-infra-and-run-furiously-fast-java
   rm -rf .git
   ```

## Terraform Inftrastructure
Terraform is an open-source infrastructure as code (IaC) tool that enables you to safely and predictably create, change, and destroy infrastructure with a single CLI command. It follows the Write One Run Anywhere principle. Imagine yourself building complex infrastructure for your cloud-native application, comprised of networking, computes, Kubernetes, streaming, APIs, and databases. Now add the complexity of multiple environments such as development, testing, and production. You are at the inflection point there. Would you create all the components within all environments manually, spending days building them, or would you write it once in the form of code and execute it multiple times for each environment? If the correct answer for you is the latter one for you, keep reading, you are in the right place.

Oracle provides [OCI Terraform Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs), allowing you to use Terraform to interact with Oracle Cloud Infrastructure resources. Moreover, OCI enables you to use [OCI Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm) as a managed Terraform service, enabling larger teams to interact with Terraform resources in a safe and concurrently-safe way.

### Terraform Kubernetes Cluster With Networking
We will terraform OKE as a managed Kubernetes cluster in OCI. OCI Container Engine for Kubernetes is a fully-managed, scalable, and highly available service that you can use to deploy your containerized applications to the cloud. Use Container Engine for Kubernetes (sometimes abbreviated to just OKE) when your development team wants to reliably build, deploy, and manage cloud-native applications. You specify the compute resources that your applications require, and Container Engine for Kubernetes provisions them on Oracle Cloud Infrastructure in an existing OCI tenancy.

1. Get inside setup folder to create infrastructure for running our Warp engines
   ```
   cd infrastructure/setups/kubernetes
   ```
2. Execute Terraform Init
   ```
   terraform init
   ```
3. Execute Terraform Apply
   ```
   terraform apply -var-file=.tfvars
   ```

You have successfully created VCN, DNS, OKE, Ingress and K8s namespaces. Output will print statement similar to the following one.

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

Your DevOps Pipeline is created. Check the Terraform output, and you will find HTTP addresses of Git repositories for hosting Warp Speed components. Output will print statement similar to the following one.
```
devops_repository = {
  "helm-ui" = "https://devops.scmservice.eu-frankfurt-1.oci.oraclecloud.com/namespaces/frsxwtjslf35/projects/cloud-coach-automate-deployments/repositories/helm-ui"
  "warp-engine-c2" = "https://devops.scmservice.eu-frankfurt-1.oci.oraclecloud.com/namespaces/frsxwtjslf35/projects/cloud-coach-automate-deployments/repositories/warp-engine-c2"
  "warp-engine-graal" = "https://devops.scmservice.eu-frankfurt-1.oci.oraclecloud.com/namespaces/frsxwtjslf35/projects/cloud-coach-automate-deployments/repositories/warp-engine-graal"
  "warp-engine-native" = "https://devops.scmservice.eu-frankfurt-1.oci.oraclecloud.com/namespaces/frsxwtjslf35/projects/cloud-coach-automate-deployments/repositories/warp-engine-native"
}
```

## Automate Deployments
In the previous chapter, we created an OCI DevOps instance to automate deployments of our blazingly fast Java applications. The OCI DevOps comprises Repositories, Build Pipelines, and Deployment Pipelines. The repository is a managed Git repository. Build Pipelines connect Repository and Artifaces through managed builds, delivering artifacts in the form of container images or other binary formats. Finally, Deployment Pipeline deploys artifacts to environments, such as Kubernetes or computes.

1. Go to the Application folder
   ```
   cd ../../../application/
   ```

### Deploy Helm UI
Position yourself in the ```application/helm-ui``` folder. You need to initialize the Git repository and push it to the remote repository in the OCI DevOps service. Prepare ```<helm-ui-git-url>``` by copying the output from the previous Terraform Apply action.
```
git init
git remote add origin <helm-ui-git-url>
git fetch
git checkout origin/main -ft
git add .
git commit -m "first commit"
git push -u origin main
```

### Deploy Warp Engine based on Helidon and C2 Compiler
Position yourself in the ```application/warp-engine/warp-engine-helidon-c2``` folder. You need to initialize the Git repository and push it to the remote repository in the OCI DevOps service. Prepare ```<warp-engine-c2-git-url>``` by copying the output from the previous Terraform Apply action.
```
git init
git remote add origin <warp-engine-c2-git-url>
git fetch
git checkout origin/main -ft
git add .
git commit -m "first commit"
git push -u origin main
```

### Deploy Warp Engine based on Helidon and Graal Compiler
Position yourself in the ```application/warp-engine/warp-engine-helidon-graal``` folder. You need to initialize the Git repository and push it to the remote repository in the OCI DevOps service. Prepare ```<warp-engine-graal-git-url>``` by copying the output from the previous Terraform Apply action.
```
git init
git remote add origin <warp-engine-graal-git-url>
git fetch
git checkout origin/main -ft
git add .
git commit -m "first commit"
git push -u origin main
```

### Deploy Warp Engine based on Micronaut and Native Image
Position yourself in the ```application/warp-engine/warp-engine-micronaut-native``` folder. You need to initialize the Git repository and push it to the remote repository in the OCI DevOps service. Prepare ```<warp-engine-micronaut-git-url>``` by copying the output from the previous Terraform Apply action.
```
git init
git remote add origin <warp-engine-micronaut-git-url>
git fetch
git checkout origin/main -ft
git add .
git commit -m "first commit"
git push -u origin main
```

## Run Furiously Fast Java
Furiousley fast java is the essence of the cloud native-native development. Oracle produced and helped building GraalVM, Helidon and Micronaut. GraalVM is a new-generation JVM capable of running and compiling Java apps blazingly fast. Helidon stand for the Java framwoekr for builidng cloud-native applications based on the Micorprofile. New and shiny gem, Micronaut is heavily used as a faster engine building component.

1. Open Helm UI in browser:
   ```
   http://helm-ui.cloud-coach.ivandelic.com/helm-ui
   ```
2. Inspect Warp Engine based on Helidon and C2 Compiler in Postman:
   ```
   http://warp-engine-c2.cloud-coach.ivandelic.com/universe/traverse
   or
   http://ingress.cloud-coach.ivandelic.com/warp-engine-c2/universe/traverse
   ```
3. Inspect Warp Engine based on Helidon and Graal Compiler in Postman:
   ```
   http://warp-engine-graal.cloud-coach.ivandelic.com/universe/traverse
   or
   http://ingress.cloud-coach.ivandelic.com/warp-engine-graal/universe/traverse
   ```
4. Inspect Warp Engine based on Microanut and Native Image in Postman:
   ```
   http://warp-engine-native.cloud-coach.ivandelic.com/universe/traverse
   or
   http://ingress.cloud-coach.ivandelic.com/warp-engine-native/universe/traverse
   ```
5. Forward Blue and Green environments locally by executing following commands:
   ```
   kubectl port-forward svc/helm-ui-service 8081:80 -n blue &
   kubectl port-forward svc/helm-ui-service 8082:80 -n green &
   ```