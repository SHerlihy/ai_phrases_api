#!/bin/bash

TEST_KEY="allow"
ROOT_URL="$(terraform -chdir=./deploy output -raw api_path)"
BUCKET_NAME="$(terraform -chdir=./prepare output -raw bucket_name)"

API_URL=${ROOT_URL}/kbaas

echo -e "Fail on auth"
FAIL_KEY="fail"

echo -e "LIST BUCKET"
LIST_URL="${API_URL}/list/?authKey=${FAIL_KEY}"
echo -e ${LIST_URL}
curl -X GET ${LIST_URL}
echo -e "\n"

echo -e "UPLOAD FILE"
UPLOAD_URL="${API_URL}/phrases/?authKey=${FAIL_KEY}"
echo -e ${UPLOAD_URL}
curl -X PUT --upload-file "./from_test.txt.gz" ${UPLOAD_URL}
echo -e "\n"

echo -e "Should succeed"
echo -e "LIST BUCKET"
LIST_URL="${API_URL}/list/?authKey=${TEST_KEY}"
echo -e ${LIST_URL}
curl -X GET ${LIST_URL}
echo -e "\n"

echo -e "UPLOAD FILE"
UPLOAD_URL="${API_URL}/phrases/?authKey=${TEST_KEY}"
echo -e ${UPLOAD_URL}
curl -X PUT --upload-file "./from_test.txt.gz" ${UPLOAD_URL}
echo -e "\n"
