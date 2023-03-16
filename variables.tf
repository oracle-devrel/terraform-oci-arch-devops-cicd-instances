## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "ssh_public_key" {
  default = ""
}

variable oci_user_name {
  default = ""
}

variable oci_user_authtoken {
  default = ""
}

variable "app_name" {
  default     = "DevopsInstances"
  description = "Application name. Will be used as prefix to identify resources, such as OKE, VCN, DevOps, and others"
}


variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "0.2"
}

variable "project_logging_config_retention_period_in_days" {
  default = 30
}

variable "project_description" {
  default = "DevOps CI/CD Sample Project for Instance "
}


variable "compute_instance_1_name" {
  default = "prod-devops-instance-1"
}

variable "compute_instance_2_name" {
  default = "prod-devops-instance-2"
}

variable "instance_shape" {
  description = "Instance Shape"
  default     = "VM.Standard.E4.Flex"
}

variable "instance_shape_ocpus" {
  default = 1
}

variable "instance_shape_memory_in_gbs" {
  default = 1
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "8"
}

variable "availability_domain_name" {
  default = ""
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "Subnet-CIDR" {
  default = "10.0.1.0/24"
}

variable "repository_name" {
  default = "oci-devops-instances-with-graal"
}

variable "repository_default_branch" {
  default = "main"
}

variable "repository_description" {
  default = "OCI Devops  instance sample application"
}

variable "repository_repository_type" {
  default = "HOSTED"
}

variable "git_repo" {
  default = "https://github.com/oracle-devrel/oci-devops-examples.git"
}

variable "git_repo_name" {
  default = "oci-devops-graal-micronaut-deploy-to-instances"
}



locals {
  ocir_namespace = lookup(data.oci_objectstorage_namespace.ns, "namespace")
}


variable "build_pipeline_description" {
  default = "build pipeline for  application with Graal Micronaut"
}

variable "build_pipeline_display_name" {
  default = "oci_devops_with_instances"
}

variable "build_pipeline_stage_build_pipeline_stage_type" {
  default = "BUILD"
}

variable "build_pipeline_stage_build_source_collection_items_connection_type" {
  default = "DEVOPS_CODE_REPOSITORY"
}


variable "build_pipeline_stage_build_source_collection_items_branch" {
  default = "main"
}

variable "build_pipeline_stage_build_source_collection_items_name" {
  default = "deploy_instances"
}

variable "build_pipeline_stage_build_spec_file" {
  default = ""
}

variable "build_pipeline_stage_display_name" {
  default = "Graal_Micronaut_build_stage"
}

variable "build_pipeline_stage_image" {
  default = "OL7_X86_64_STANDARD_10"
}

variable "build_pipeline_stage_wait_criteria_wait_duration" {
  default = "waitDuration"
}

variable "build_pipeline_stage_wait_criteria_wait_type" {
  default = "ABSOLUTE_WAIT"
}

variable "build_pipeline_stage_stage_execution_timeout_in_seconds" {
  default = 36000
}

variable "devops_instance_deploy_spec_artifact_name" {
  default = "devops_instance_deploy_spec"
}

variable "devops_instance_deploy_spec_path" {
  default = "deployment_manfiest.yaml"
}

variable "devops_app_executable_name" {
  default = "devops_app_executable"
}

variable "devops_app_executable_path" {
  default = "exec-app"
}
variable "build_pipeline_stage_deliver_artifact_stage_type" {
  default = "DELIVER_ARTIFACT"
}

variable "deliver_artifact_stage_display_name" {
  default = "upload_artifacts"
}

variable "loadbalancer_display_name"{
  default = "lb_devops_instances"
}

variable "loadbalancer_listner_name"{
  default = "devops_lb_listner"
}

variable "loadbalancer_shape" {
  default = "flexible"
}

variable "loadbalancer_maximum_bandwidth_in_mbps" {
  default = 10
}

variable "loadbalancer_minimum_bandwidth_in_mbps" {
  default = 10
}

variable "loadbalancer_backend_set_name" {
  default = "lb_backendset_for_instance"
}

variable "loadbalancer_backendset_policy" {
  default = "ROUND_ROBIN"
}

variable "loadbalancer_backendset_port" {
  default = 8080
}

variable "loadbalancer_backend_port" {
  default = 8080
}

variable "loadbalancer_listener_port" {
  default = 8080
}


variable "deploy_pipeline_name" {
  default = "devops_instances"
}
variable "deploy_pipeline_description" {
  default = "Devops CI/CD Pipleline demo for Instances  "
}
variable "build_pipeline_stage_deploy_stage_type" {
  default = "TRIGGER_DEPLOYMENT_PIPELINE"
}

variable "deploy_stage_display_name" {
  default = "deploy_to_instances"
}

variable "deploy_stage_type" {
  default = "COMPUTE_INSTANCE_GROUP_ROLLING_DEPLOYMENT"
}

variable "deploy_display_name" {
  default = "Deploy to OCI Instances"
}

variable "deploy_description" {
  default = "Deploy to OCI Instances"
}

variable "deploy_failure_count" {
  default = 1
}

variable "deploy_backend_port" {
  default = 8080
}

variable "deploy_batch_count" {
  default = 1
}

variable "deploy_batch_delay_in_seconds" {
  default = 2
}

variable "build_pipeline_stage_is_pass_all_parameters_enabled" {
  default = true
}


variable "devops_env_prod_displayname"{
  default = "env_instances_prod"
}


locals {
  instance_shape = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Standard.A1.Flex",
    "VM.Optimized3.Flex"
  ]
  is_flexible_node_shape = contains(local.instance_shape, var.instance_shape)
  is_flexible_lb_shape   = var.loadbalancer_shape == "flexible" ? true : false
}
