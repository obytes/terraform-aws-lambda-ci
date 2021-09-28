output "codebuild_project_name" {
  value = module.code_build_project.codebuild_project_name
}

output "codepipeline_project_name" {
  value = module.code_pipeline_project.codepipeline_project_name
}
