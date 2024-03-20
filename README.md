# Terraform Beginner Bootcamp 2023

The end goal of this bootcamp is to achieve the following architecture:

![architecture](/files/arch.png)

### How to replicate this

In order to use these configurations file, you'll need an AWS account to to configurate programatic access to it.
Set up a user with an access key and either replace the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` with their corresponding values on the `.env` file, or just export them as environment variables within your terminal. Do the same to `AWS_DEFAULT_REGION`. You can leave `PROJECT_ROOT` with that hardcoded path.

If you're using Gitpod, Terraform CLI and AWS CLI will be installed and launched, if not, replicate the steps described in the `.gitpod.yml` file.

---

### Process

To better organize our Terraform configuration, we'll use the `terrahouse_aws` module.

We want to have an S3 bucket with static website hosting, so we'll need to create the S3 bucket first with the [`aws_s3_bucket`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) with the following syntax:

```tf
resource "aws_s3_bucket" "<>" {
  bucket = <>
  tags = {}
}
```

To allow the bucket to [host a static website](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html) we need to create a [`aws_s3_bucket_website_configuration`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration). We can do so with the following approach:

```tf
resource "aws_s3_bucket_website_configuration" "<>" {
  bucket = <name of the bucket to be the host>

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
```

And we'll now add the [`index.html`](/public/index.html) and [`error.html`](/public/error.html) files to the bucket using [`aws_s3_object`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) resource:

```
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath
  content_type = "text/html"
  etag = filemd5(var.index_html_filepath )
  lifecycle {
    replace_triggered_by = [ terraform_data.content_version.output ]
    ignore_changes = [ etag ]
  }
}
```

The [etag](https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Headers/ETag) will provide an ID to the `index.html` and `error.html` files, so that changes to the actual file can be identified. Because any change on the content of the files, will trigger a new etag to be generated. (PS: We're actually ignoring etag on the lifecycle block to guarantee that we don't really re-trigger any replacements of the file once he's on the S3 bucket on the cloud)

We're using `replace_triggered_by` within the lifecycle while using a [`terraform-data`](https://developer.hashicorp.com/terraform/language/resources/terraform-data) resource type and pointing it to a `content_version` to only acknowledge changes to the `index.html` if (and only if) the `content_version` variable has been changed. This means that we can change the file as much as we would like and `terraform apply` will ignore it. But once we increase the `content_version` variable, the `terraform apply` will recognize the change and update the file according to the current contents it has.

---

Now, to make an S3 bucket with website static hosting work, we'll need to configure the bucket policy to allow public access to the objects within the bucket.
The reason for this is that when we enable static website hosting for an S3 bucket, the bucket essentially becomes a web server that serves static content to the internet. Without the appropriate permissions set in the bucket policy, the objects (in our case the `index.html` and `error.html` files) stored in the bucket will not be accessible to users attempting to access the website.

A bucket policy allows you to define who can access the objects in the bucket and under what conditions. We'll achieve this using the [aws_s3_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) resource and providing the policy seen [in this document](https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/).

---

(TO BE CONTINUED...)
