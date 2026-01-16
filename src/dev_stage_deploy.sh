#!/bin/bash

terraform -chdir=./api output > ./develop/terraform.tfvars

cat ./variables/shared.txt >> ./develop/terraform.tfvars
terraform -chdir=./develop apply --auto-approve
