#!/bin/bash

AUTH_KEY=$1

terraform -chdir=./api init

./refreshers/create_dist.sh

cat ./variables/shared.txt > ./api/terraform.tfvars
cat ./variables/production.txt >> ./api/terraform.tfvars

terraform -chdir=./api apply -var="auth_key=${AUTH_KEY}" --auto-approve
terraform -chdir=./api output > ./production/terraform.tfvars
