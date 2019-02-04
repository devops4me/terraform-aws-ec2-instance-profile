
#### Given an input string of IAM policy statements (usually rendered from json formatted policy statements) this terraform module returns an ec2 instance profile that can be attached to an aws_instance thus giving it a role containing all the necessary permissions.


# ec2 instance role profile | iam policy statements

Pass in chunk of AWS (json formatted) policy statements in the variable **`in_policy_stmts`** and reap the **`out_ec2_instance_profile`** that can be fed into the **`iam_instance_profile`** property of the **`aws_instance`** resource.

## Usage

``` hcl
module ec2-instance-profile
{
    source = "github.com/devops4me/terraform-aws-s3-instance-profile"
}
```

After declaring this Terraform module you use its output within the **`aws_instance`** resource block.

``` hcl
resource aws_instance ec2-s3-instance
{

    iam_instance_profile = "${ module.s3-instance-profile.out_profile_name }"

}
```

## Verification

To verify that your instance has access to S3 you

- login to the instance
- list all buckets
- create a new bucket
- add content to the bucket
- read that content
- delete the content
- delete the bucket

See the integration test of this module for a demonstration of the above using the **`aws command line interface`**.
