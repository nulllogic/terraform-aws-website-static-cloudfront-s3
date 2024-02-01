# Terraform AWS static website module

<p>
   <a href="#">
       <img alt="Logo" src="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/raw/master/.imgs/header.png" />
   </a>
</p>

<!-- Badges -->
<p>
  <a href="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/nulllogic/terraform-aws-website-static-cloudfront-s3" alt="contributors" />
  </a>
  <a href="">
    <img src="https://img.shields.io/github/last-commit/nulllogic/terraform-aws-website-static-cloudfront-s3" alt="last update" />
  </a>
  <a href="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/network/members">
    <img src="https://img.shields.io/github/forks/nulllogic/terraform-aws-website-static-cloudfront-s3" alt="forks" />
  </a>
  <a href="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/stargazers">
    <img src="https://img.shields.io/github/stars/nulllogic/terraform-aws-website-static-cloudfront-s3" alt="stars" />
  </a>
  <a href="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/issues/">
    <img src="https://img.shields.io/github/issues/nulllogic/terraform-aws-website-static-cloudfront-s3" alt="open issues" />
  </a>
  <a href="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/nulllogic/terraform-aws-website-static-cloudfront-s3" alt="license" />
  </a>
</p>

<p align="left">The main objective of this module is to leverage the power of AWS services, specifically CloudFront and S3, to host and deliver your static website efficiently and securely. By utilizing Terraform's infrastructure as code capabilities, this project streamlines the deployment process, making it easy for you to set up and manage your AWS static website.</p>

<p align="center">
  <a href="https://nulllogic.net/">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/raw/master/.imgs/logo.png">
      <img alt="NullLogic" src="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/raw/master/.imgs/logo.png">
    </picture>
  </a>
</p>

## ┌ Table of Contents ┐

- [Requirements](#-requirements-)
- [Key Features](#-key-features-)
- [Quick Start](#-quick-start-)
- [Module Examples](#-module-examples-)

<!-- Requirements -->
<a name="-requirements-" />

## ┌ Requirements ┐

<p>🗯️ <strong>Mandatory</strong></p>

1. 🐳 Docker ( [download](https://docs.docker.com/get-docker/) )
2. 🤖 AWS account + security keys ( [instruction](https://aws.amazon.com/blogs/security/wheres-my-secret-access-key/) )
   1. `aws_access_key_id`
   2. `aws_secret_access_key`

<p>💭️ <strong>Optional</strong></p>

1. Domain, located in [Amazon AWS Route53](https://aws.amazon.com/route53/)

<!-- Key Features -->
<a name="-key-features-" />

## ┌ Key Features ┐

⚙️ Zero-config, **one-minute setup** with a **single CLI command**

🔐 AWS providers for smooth **deployment** and **certificate** generation

⚡ Out-of-the-box support for **static website**

💪 Future-proof, **robust architecture**

🐳 Docker commands under the hood 

✅ Full **test coverage**

🔒 Additional **security** headers

<!-- Quick Start -->
<a name="-quick-start-" />


## ┌ Quick Start ┐

By using this project, you can save time and effort in setting up your AWS static website. Its comprehensive Terraform code and thoughtful configuration options allow you to create a reliable, scalable, and performant static website on AWS without any problems.

Feel free to explore the project on [GitHub](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3). Happy coding!

<strong>1st step</strong>:

Download two files `main.tf` and `provider.tf` from one of examples directories.

<strong>2nd step</strong>:

Run one of the following commands inside directory with those two files. <br />
( it will use docker image with HashiCorp with TerraForm application inside)

If you have used AWS CLI already, you can attach keys by running this command:

```
docker container run -it --rm -v $PWD:/tf -v ~/.aws:/root/.aws --workdir /tf hashicorp/terraform:latest init
```

If you haven't used AWS CLI, you can pass those keys directly, by running this command:
( don't forget to replace XXXX with your AWS keys )
```
docker container run -it --rm -e TF_VAR_aws_access_key_id=XXXXXXXX -e TF_VAR_aws_secret_access_key=XXXXXXX -v $PWD:/tf --workdir /tf hashicorp/terraform:latest init
```

<strong>3rd step</strong>:

Run the command, that you used previously, but instead of `init` at the end of the command, write `apply`

It should look like this :
```
docker container run -it --rm -v $PWD:/tf -v ~/.aws:/root/.aws --workdir /tf hashicorp/terraform:latest apply
```

<strong>4th step</strong>:

Run the command, that you used previously, but instead of `apply` at the end of the command, write `deploy`

It should look like this :
```
docker container run -it --rm -v $PWD:/tf -v ~/.aws:/root/.aws --workdir /tf hashicorp/terraform:latest deploy
```

<strong>5th step</strong>:

Profit ! 💪

<br/>

<!-- Module Examples -->
<a name="-module-examples-" />

## ┌ Module Examples ┐

<details>
  <summary>Example 1 -> CloudFront + S3</summary>
    <p>

   ```hcl
  module "website-static-cloudfront-s3" {
    source  = "nulllogic/website-static-cloudfront-s3/aws"

    tags = {
       Environment = "dev"
       Terraform   = "true"
    }
  } 
   ```
   </p>
  <br />
  <img alt="Example 1" src="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/raw/master/.imgs/example1.png" />
</details>

<details> 
<summary>Example 2 -> CloudFront + S3 + Domain</summary>
  <p>

  ```hcl
  module "website-static-cloudfront-s3" {
    source  = "nulllogic/website-static-cloudfront-s3/aws"

    route53 = {
      domain = "example.com"
    }

    tags = {
       Environment = "dev"
       Terraform   = "true"
    }
  } 
   ```
  </p>
  <br />
  <img alt="Example 2" src="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/raw/master/.imgs/example2.png" />
</details>


## ┌ Contributing ┐

See [Contributing](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/tree/master/CONTRIBUTING.md)

## ┌ Changelog ┐

See [Changelog](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/tree/master/CHANGELOG.md)

## ┌ License ┐

Licensed under the MIT [License](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/tree/master/LICENSE.md)
