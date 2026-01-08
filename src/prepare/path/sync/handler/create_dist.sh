#!/bin/bash

rm -rf ./dist

mkdir ./dist

pip install --target ./dist datetime

cp ./lambda_function.py ./dist
