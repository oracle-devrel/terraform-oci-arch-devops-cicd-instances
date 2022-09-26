## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Create Artifact Repository

resource "oci_artifacts_repository" "test_repository" {
  #Required
  compartment_id  = var.compartment_ocid
  is_immutable    = true
  display_name    = "${var.app_name}_artifact_repo"
  repository_type = "GENERIC"
  defined_tags    = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_devops_deploy_artifact" "devops_instance_deploy_spec" {
  argument_substitution_mode = "SUBSTITUTE_PLACEHOLDERS"
  defined_tags               = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
  deploy_artifact_type       = "DEPLOYMENT_SPEC"
  display_name               = var.devops_instance_deploy_spec_artifact_name
  freeform_tags              = {}
  project_id                 = oci_devops_project.test_project.id

  deploy_artifact_source {
    deploy_artifact_path        = var.devops_instance_deploy_spec_path
    deploy_artifact_source_type = "GENERIC_ARTIFACT"
    deploy_artifact_version     = "$${BUILDRUN_HASH}"
    repository_id               = oci_artifacts_repository.test_repository.id
  }

}

resource "oci_devops_deploy_artifact" "devops_app_executable" {
  argument_substitution_mode = "SUBSTITUTE_PLACEHOLDERS"
  defined_tags               = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
  deploy_artifact_type       = "GENERIC_FILE"
  display_name               = var.devops_app_executable_name
  freeform_tags              = {}
  project_id                 = oci_devops_project.test_project.id

  deploy_artifact_source {
    deploy_artifact_path        = var.devops_app_executable_path
    deploy_artifact_source_type = "GENERIC_ARTIFACT"
    deploy_artifact_version     = "$${BUILDRUN_HASH}"
    repository_id               = oci_artifacts_repository.test_repository.id
  }

  timeouts {}
}
