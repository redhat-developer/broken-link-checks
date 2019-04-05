#!/bin/bash

function run_blinkr_checks {
  printf "\n Launching blinkr broken-link-checking environment... \n"
  cd website && docker-compose -p rhd_blinkr_testing build --no-cache
  docker-compose -p rhd_blinkr_testing up -d blinkr_chrome
  printf "\n Broken-link-checking environment up and running. Running blinkr checks...\n"
  docker-compose -p rhd_blinkr_testing run --rm --no-deps rhd_blinkr_testing bundle exec blinkr -c $CONFIG -u $RHD_BASE_URL
  printf "\n Completed run of Blinkr checks. \n"
}

function run_dcp_checks {
  printf "\n Building the dcp checking image \n"
  cd dcp && docker-compose -p rhd_dcp_testing build
  printf "\n Broken-link-checking environment up and running. Running dcp checks...\n"
  docker-compose -p rhd_dcp_testing run --rm --no-deps rhd_dcp_testing bundle exec dcp-checker --base-url=$RHD_BASE_URL
  printf "\n Completed run of dcp checks. \n"
}

if [ $1 ==  'blinkr' ]; then
run_blinkr_checks
else
run_dcp_checks
fi
