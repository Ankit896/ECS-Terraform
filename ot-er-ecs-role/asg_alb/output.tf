output "aws_security_group_lb_output" {
  value = aws_security_group.lb
}
output "aws_lb_output" {
  value = aws_lb.test-lb
}
output "aws_lb_target_group_output" {
  value = aws_lb_target_group.lb_target_group
}
output "aws_lb_listener_output" {
  value = aws_lb_listener.web-listener
}
output "aws_security_group_sg_output" {
  value = aws_security_group.ec2-sg
}
output "aws_launch_configuration_output" {
  value = aws_launch_configuration.lc
}
output "aws_autoscaling_group_output" {
  value = aws_autoscaling_group.asg
}