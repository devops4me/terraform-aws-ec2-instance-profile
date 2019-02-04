
### ########################################## ###
### ec2 instance profile [mandatory] variables ###
### ########################################## ###

variable in_policy_stmts    { description = "A string of AWS policy statements defining the AWS resource access the ec2 instances will enjoy."     }
variable in_ecosystem_name  { description = "Creational stamp binding all infrastructure components created on behalf of this ecosystem instance." }
variable in_tag_timestamp   { description = "A timestamp for resource tags in the format ymmdd-hhmm like 80911-1435"                               }
variable in_tag_description { description = "Ubiquitous note detailing who, when, where and why for every infrastructure component."               }
