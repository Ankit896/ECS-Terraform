output "aws_ecs_capacity_provider_output" {
  value = aws_ecs_capacity_provider.test
}
output "aws_ecs_cluster_output" {
  value = aws_ecs_cluster.web-cluster
}
output "aws_ecs_task_definition" {
  value = aws_ecs_task_definition.task-definition-test
}
output "aws_ecs_service" {
  value = aws_ecs_service.service
}