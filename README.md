# FC3-Terraform
Creating an EKS Cluster in AWS using Terraform 

## How to use it
Initialize the modules:
```
terraform init
```

To create the infrastructure (it should take ~15min)
```
terraform apply 
```

To destroy the infrastructure (it should take ~10min)
```
terraform destroy 
```

## Folder Structure

    ├── README.md                       # this file
    ├── modules                         # the modules folder
    │   ├── eks                         # EKS module
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── iam                         # IAM module
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   └── vpc                         # VPC module
    │       ├── main.tf
    │       ├── outputs.tf
    │       └── variables.tf
    ├── main.tf                         # The main terraform script
    ├── providers.tf                    # The terraform providers file
    ├── terraform.tfvars                # The variables definition
    └── variables.tf                    # The variables declaration