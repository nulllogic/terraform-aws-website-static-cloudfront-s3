# Terraform AWS static website module

<a href="#">
    <img alt="Logo" src="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/raw/master/.imgs/header.png" />
</a>

<br/>

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

<div align="left">The main objective of this module is to leverage the power of AWS services, specifically CloudFront and S3, to host and deliver your static website efficiently and securely. By utilizing Terraform's infrastructure as code capabilities, this project streamlines the deployment process, making it easy for you to set up and manage your AWS static website.</div>

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
- [Module Architecture Examples Diagrams](#-module-architecture-examples-diagrams-)

<!-- Requirements -->
## ┌ Requirements ┐

1. 🐳 Docker ( [download](https://docs.docker.com/get-docker/) )
2. 🤖 AWS account + security keys ( [instruction](https://aws.amazon.com/blogs/security/wheres-my-secret-access-key/) ) 
   1. `aws_access_key_id`
   2. `aws_secret_access_key`

<!-- Key Features -->
## ┌ Key Features ┐

⚙️ Zero-config, **one-minute setup** with a **single CLI command**

🔐 AWS providers for smooth **deployment** and **certificate** generation

⚡ Out-of-the-box for **static website**

💪 Future-proof, **robust architecture**

🐳 Docker commands under the hood 

✅ Full **test coverage**

<!-- Quick Start -->
## ┌ Quick Start ┐
By using this project, you can save time and effort in setting up your AWS static website. Its comprehensive Terraform code and thoughtful configuration options allow you to create a reliable, scalable, and performant static website on AWS without any problems.

Feel free to explore the project on [GitHub](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3). Happy coding!

1st step
```
docker container run -it --rm -v $PWD:/tf -v ~/.aws:/root/.aws --workdir /tf hashicorp/terraform:latest init
```

2nd step
```
docker container run -it --rm -v $PWD:/tf -v ~/.aws:/root/.aws --workdir /tf hashicorp/terraform:latest plan
```

3rd step

```
docker container run -it --rm -v $PWD:/tf -v ~/.aws:/root/.aws --workdir /tf hashicorp/terraform:latest apply
```

<br/>

<!-- Module Architecture Examples Diagrams -->
## ┌ Module Architecture Examples Diagrams ┐

<details> 
  <summary>Example 1 structure</summary>
    <img alt="Example 1" src="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/raw/master/.imgs/example2.png" />
</details>

<details> 
  <summary>Example 2 structure</summary>
    <img alt="Example 2" src="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/raw/master/.imgs/example2.png" />
</details>


## ┌ Contributing ┐

See [Contributing](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/tree/master/CONTRIBUTING.md)

## ┌ Changelog ┐

See [Changelog](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/tree/master/CHANGELOG.md)

## ┌ License ┐

Licensed under the MIT [License](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/tree/master/LICENSE.md)