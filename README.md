# Terraform AWS static website module

<a href="#">
    <img alt="Logo" src="https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/raw/master/.imgs/header.png" />
</a>

<br/>
<br/>

<div align="left">Some cool description here</div>

<br />
<br />

## ┌ Table of Contents ┐

- [Requirements](#-requirements-)
- [Module Architecture Examples Diagrams](#-module-architecture-examples-diagrams-)
- [Key Features](#-key-features-)
- [Quick Start](#-quick-start-)

<!-- Requirements -->
## ┌ Requirements ┐

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

## ┌ Contributing ┐

See [Contributing](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/tree/master/CONTRIBUTING.md)

## ┌ Changelog ┐

See [Changelog](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/tree/master/CHANGELOG.md)

## ┌ License ┐

Licensed under the MIT [License](https://github.com/nulllogic/terraform-aws-website-static-cloudfront-s3/tree/master/LICENSE.md)