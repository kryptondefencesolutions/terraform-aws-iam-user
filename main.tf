/**
 * The module creates an IAM user.
 *
 * Usage:
 *
 *     module "my_user" {
 *     source  = "github.com/anub1s187/core_modules?ref=0.12.6/iam-user"
 *     name    = "name"
 *       groups   = [""]
 *   }
 */

variable "name" {
  description = "The user name, e.g my-user"
}

variable "groups" {
  type = list(string)
}

/**
 * IAM User.
 */

resource "aws_iam_user" "main" {
  name = var.name

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    terraform = true
  }
}

/**
 * Access Key.
 */

# resource "aws_iam_access_key" "main" {
#   user = "${aws_iam_user.main.name}"
#
#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "aws_iam_user_group_membership" "main" {
  user = aws_iam_user.main.name

  groups = var.groups
}

/**
 * Outputs.
 */
// The aws access key id.
# output "access_key" {
#   value = "${aws_iam_access_key.main.id}"
# }
#
# // The aws secret access key.
# output "secret_key" {
#   value = "${aws_iam_access_key.main.secret}"
# }
#
# // The user ARN
# output "arn" {
#   value = "${aws_iam_user.main.arn}"
# }
