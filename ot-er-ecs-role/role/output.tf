output "aws_iam_profile_output" {
  value = aws_iam_role.ecs-instance-role
}
output "aws_iam_instance_profile_ouput" {
  value = aws_iam_instance_profile.ecs_service_role
}
output "aws_iam_role_policy_attachment_output" {
  value = aws_iam_role_policy_attachment.ecs-instance-role-attachment
}