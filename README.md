# terraform-oci-arch-devops-cicd-instances

Rapid delivery of software is essential for efficiently running your applications in the cloud. Oracle DevOps service provides a continuous integration and deployment (CI/CD) platform for developers. You can use the DevOps service to easily build, test, and deploy software and applications on Oracle Cloud. DevOps build and deployment pipelines reduce change-driven errors and decrease the time customers spend on building and deploying releases. The service also provides a private Git repositories to store your code and supports connections to external code repositories.

Whether you're migrating workloads to OCI (from on-premises or other clouds) or developing new applications on OCI, you can use the DevOps service to simplify your software delivery lifecycle!

In this reference architecture , we will be building and deploying a modern application to OCI compute instances.We will be using an application based on Graal Enterprise - Micronaut enabled java application.The application is exposed via an OCI loadbalancer to ensure a smooth shift of traffic during an active deployments.


For details of the architecture, see [Build a CI/CD pipeline by using Oracle Cloud Infrastructure DevOps service and OCI Instances](TBD)

## Terraform Provider for Oracle Cloud Infrastructure
The OCI Terraform Provider is now available for automatic download through the Terraform Provider Registry.
For more information on how to get started view the [documentation](https://www.terraform.io/docs/providers/oci/index.html)
and [setup guide](https://www.terraform.io/docs/providers/oci/guides/version-3-upgrade.html).

* [Documentation](https://www.terraform.io/docs/providers/oci/index.html)
* [OCI forums](https://cloudcustomerconnect.oracle.com/resources/9c8fa8f96f/summary)
* [Github issues](https://github.com/terraform-providers/terraform-provider-oci/issues)
* [Troubleshooting](https://www.terraform.io/docs/providers/oci/guides/guides/troubleshooting.html)

## Deploy Using Oracle Resource Manager

1. Click [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/oracle-devrel/terraform-oci-arch-devops-cicd-instances/releases/latest/download/terraform-oci-arch-devops-cicd-instances-stack-latest.zip)

   If you aren't already signed in, when prompted, enter the tenancy and user credentials.

2. Review and accept the terms and conditions.

3. Select the region where you want to deploy the stack.

4. Follow the on-screen prompts and instructions to create the stack.

5. After creating the stack, click **Terraform Actions**, and select **Plan**.

6. Wait for the job to be completed, and review the plan.

   To make any changes, return to the Stack Details page, click **Edit Stack**, and make the required changes. Then, run the **Plan** action again.

7. If no further changes are necessary, return to the Stack Details page, click **Terraform Actions**, and select **Apply**.

### Validate the Deployment

- Post the infra deployment , run a build run using `OCI Console` >`Developer service`>`OCI Devops project`>`Project Name ` > `Build pipeline` > `Name of the build pipeline`

- Validate the application using the loadbalancer's public ip address.


## Deploy Using the Terraform CLI

### Clone the Module

Now, you'll want a local copy of this repo. You can make that with the commands:

    git clone https://github.com/oracle-devrel/terraform-oci-arch-devops-cicd-with-functions
    cd terraform-oci-arch-devops-cicd-with-functions
    ls

### Prerequisites
First off, you'll need to do some pre-deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

Secondly, create a `terraform.tfvars` file and populate with the following information:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"

# Region
region = "<oci_region>"

# Compartment
compartment_ocid = "<compartment_ocid>"

# OCI User and Authtoken
oci_user_name       = "<oci_username> 
# For a federated user (single sign-on with an identity provider), enter the username in the following format: TenancyName/Federation/UserName. 
# For example, if you use OCI's identity provider, your login would be, Acme/oracleidentitycloudservice/alice.jones@acme.com. 
#If you are using OCI's direct sign-in, enter the username in the following format: TenancyName/YourUserName. For example, Acme/alice_jones. Your password is the auth token you created previously.

oci_user_authtoken = "<oci_user_authtoken>" 
# You can get the auth token from your Profile menu -> click User Settings -> On left side  click *Auth Tokens -> Generate Token

````

Deploy:

    terraform init
    terraform plan
    terraform apply


### Validate the Deployment

- Post the infra deployment , run a build run using `OCI Console` >`Developer service`>`OCI Devops project`>`Project Name ` > `Build pipeline` > `Name of the build pipeline`

- Validate the application using the loadbalancer's public ip address.


## Destroy the Deployment
Delete all the artifacts with in the `OCI Artifact repository` then follow terraform command and destroy.

    terraform destroy

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

### Attribution & Credits
- Rahul M R (https://github.com/RahulMR42)

## License
Copyright (c) 2024 Oracle and/or its affiliates.
Licensed under the Universal Permissive License (UPL), Version 1.0.
See [LICENSE](LICENSE) for more details.
