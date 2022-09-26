## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_devops_repository" "test_repository" {
  #Required
  name       = var.repository_name
  project_id = oci_devops_project.test_project.id

  #Optional
  default_branch = var.repository_default_branch
  description    = var.repository_description

  repository_type = var.repository_repository_type
}


resource "null_resource" "clonerepo" {

  depends_on = [oci_devops_project.test_project, oci_devops_repository.test_repository]

  provisioner "local-exec" {
    command = "echo ' Cleaning local repo: '; rm -rf ${oci_devops_repository.test_repository.name}"
  }

  provisioner  "local-exec" {
    command = "echo 'Git init: '; git init ${var.git_repo_name};cd ${var.git_repo_name};git remote add pgit ${var.git_repo};git config core.sparsecheckout true;echo 'oci-pipeline-examples/oci-devops-graal-micronaut-deploy-to-instances/*'>>.git/info/sparse-checkout;git pull --depth=1 pgit main"
  }

  provisioner "local-exec" {
    command = "cd ..;echo 'Repo to clone: https://devops.scmservice.${var.region}.oci.oraclecloud.com/namespaces/${local.ocir_namespace}/projects/${oci_devops_project.test_project.name}/repositories/${oci_devops_repository.test_repository.name}'"
  }

  provisioner "local-exec" {
    command = "echo 'Starting git clone command... '; echo 'Username: Before' ${var.oci_user_name}; echo 'Username: After' ${local.encode_user}; echo 'auth_token' ${local.auth_token}; git clone https://${local.encode_user}:${local.auth_token}@devops.scmservice.${var.region}.oci.oraclecloud.com/namespaces/${local.ocir_namespace}/projects/${oci_devops_project.test_project.name}/repositories/${oci_devops_repository.test_repository.name};"
  }

  provisioner "local-exec" {
    command = "echo 'Finishing git clone command: '; ls -latr ${oci_devops_repository.test_repository.name}"
  }
}

resource "null_resource" "custom_buildspec_config"{
  depends_on = [null_resource.clonerepo,oci_artifacts_repository.test_repository]
  provisioner "local-exec" {
    command = "echo 'Replacing build spec';sed 's/ARTIFACT-REPO-OCID/${oci_artifacts_repository.test_repository.id}/g' manifest/custom_build_spec.yaml >${var.git_repo_name}/oci-pipeline-examples/oci-devops-graal-micronaut-deploy-to-instances/build_spec.yaml"
  }

}

resource "null_resource" "copyfiles" {

  depends_on = [null_resource.clonerepo]

  provisioner "local-exec" {
    command = "rm -rf ${var.git_repo_name}/.git; cp -pr ${var.git_repo_name}/oci-pipeline-examples/oci-devops-graal-micronaut-deploy-to-instances/* ${oci_devops_repository.test_repository.name}/"
  }
}


resource "null_resource" "pushcode" {

  depends_on = [null_resource.copyfiles]

  provisioner "local-exec" {
    command = "cd ./${oci_devops_repository.test_repository.name}; git config --global user.email 'test@example.com'; git config --global user.name '${var.oci_user_name}';git add .; git commit -m 'added latest files'; git push origin '${var.repository_default_branch}'"
  }
}



locals {
  encode_user = urlencode(var.oci_user_name)
  auth_token  = urlencode(var.oci_user_authtoken)
}