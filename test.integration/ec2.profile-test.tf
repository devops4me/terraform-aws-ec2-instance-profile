
### ################################################# ###
### [[test-module]] testing ec2 instance role profile ###
### ################################################# ###

locals
{
    ecosystem_id = "ec2role-test"
}


module ec2-instance-role-profile
{
    source = ".."

    in_policy_stmts    = "${ data.template_file.iam_policy_stmts.rendered }"

    in_ecosystem_name  = "${local.ecosystem_id}"
    in_tag_timestamp   = "${ module.resource-tags.out_tag_timestamp }"
    in_tag_description = "${ module.resource-tags.out_tag_description }"
}


resource aws_instance server
{
    count = "3"

    ami                    = "${ data.aws_ami.ubuntu-1804.id }"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [ "${ module.security-group.out_security_group_id }" ]
    subnet_id              = "${ element( module.vpc-network.out_subnet_ids, count.index ) }"
    iam_instance_profile   = "${ module.s3-instance-profile.out_profile_name }"
###############    user_data              = "${ data.template_file.cloud_config.rendered }"

    tags
    {
        Name   = "ec2-0${ ( count.index + 1 ) }-${ local.ecosystem_id }-${ module.resource-tags.out_tag_timestamp }"
        Class = "${ local.ecosystem_id }"
        Instance = "${ local.ecosystem_id }-${ module.resource-tags.out_tag_timestamp }"
        Desc   = "This ec2 instance no.${ ( count.index + 1 ) } for ${ local.ecosystem_id } ${ module.resource-tags.out_tag_description }"
    }

}


data template_file iam_policy_stmts
{
    template = "${ file( "${path.module}/ec2.profile-policy-stmts.json" ) }"
}


module vpc-network
{
    source                 = "github.com/devops4me/terraform-aws-vpc-network"
    in_vpc_cidr            = "10.191.0.0/16"
    in_num_private_subnets = 0
    in_num_public_subnets  = 3

    in_ecosystem_name     = "${local.ecosystem_id}"
    in_tag_timestamp      = "${ module.resource-tags.out_tag_timestamp }"
    in_tag_description    = "${ module.resource-tags.out_tag_description }"
}


module security-group
{
    source         = "github.com/devops4me/terraform-aws-security-group"
    in_ingress     = [ "ssh", "http", "https" ]
    in_vpc_id      = "${ module.vpc-network.out_vpc_id }"

    in_ecosystem_name     = "${local.ecosystem_id}"
    in_tag_timestamp      = "${ module.resource-tags.out_tag_timestamp }"
    in_tag_description    = "${ module.resource-tags.out_tag_description }"
}


module resource-tags
{
    source = "github.com/devops4me/terraform-aws-resource-tags"
}
