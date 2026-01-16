#!/bin/bash

AUTH_KEY=$1
API_ID=""
API_ROOT_ID=""

terraform -chdir=./dev_fakes init
terraform -chdir=./api init
terraform -chdir=./develop init

./refreshers/create_dist.sh

terraform -chdir=./dev_fakes apply --auto-approve

terraform -chdir=./dev_fakes output > ./api/terraform.tfvars
cat ./variables/develop.txt >> ./api/terraform.tfvars
cat ./variables/shared.txt >> ./api/terraform.tfvars

echo "build_uid = \"dev\"" >> ./api/terraform.tfvars
echo "auth_key = \"${AUTH_KEY}\"" >> ./api/terraform.tfvars

terraform -chdir=./api apply --auto-approve
terraform -chdir=./api output > ./develop/terraform.tfvars

echo "api_id = \"${API_ID}\"" >> ./develop/terraform.tfvars
echo "api_root_id = \"${API_ROOT_ID}\"" >> ./develop/terraform.tfvars
terraform -chdir=./develop apply --auto-approve
