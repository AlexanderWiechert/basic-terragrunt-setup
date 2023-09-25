resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-${var.env}"

  tags = merge(
    var.tags,
    {
      "Name" = var.project_name
      "Environment" = var.env
    },
  )
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]

  }
}

resource "null_resource" "test_upload" {
  provisioner "local-exec" {
    command = join(" ", [
      "aws s3 cp TESTFILE ${aws_s3_bucket.this.bucket}",
      "aws s3 ls ${aws_s3_bucket.this.bucket}/TESTFILE"
    ])
    interpreter = [
      "bash",
      "-c"
    ]
    working_dir = "${path.cwd}/${path.module}"

  }
}