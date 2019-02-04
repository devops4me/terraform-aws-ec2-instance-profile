
resource aws_iam_role ec2_instance_role
{
    name               = "ec2-role-${ var.in_ecosystem_name }-${ var.in_tag_timestamp }"
    assume_role_policy = "${ file( "${path.module}/ec2.profile-role.json" ) }"
}


resource aws_iam_instance_profile ec2_instance_profile
{
    name  = "ec2-profile-${ var.in_ecosystem_name }-${ var.in_tag_timestamp }"
    role = "${aws_iam_role.ec2_instance_role.name}"
}


resource aws_iam_role_policy rmq_role_policy
{
    name        = "ec2-policy-${ var.in_ecosystem_name }-${ var.in_tag_timestamp }"
    description = "Policy statements giving ec2 instances with role access to AWS resources."

    role = "${ aws_iam_role.ec2_instance_role.id }"
    policy = "${ var.in_policy_stmts }"
}
