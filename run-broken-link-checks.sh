#!/bin/bash

function run_blinkr_checks {
  echo "\n Launching blinkr broken-link-checking environment... \n"
  docker-compose -p rhd_blinkr_testing build
  docker-compose -p rhd_blinkr_testing up -d blinkr_chrome
  echo "\n Broken-link-checking environment up and running. Running blinkr checks...\n"
  docker-compose -p rhd_blinkr_testing run --rm --no-deps rhd_blinkr_testing bundle exec blinkr -c $CONFIG -u $RHD_BASE_URL
  echo "\n Completed run of Blinkr checks. \n"
}

function run_dcp_checks {
  echo "\n Building the dcp checking image \n"
  docker-compose -p rhd_dcp_testing build
  echo "\n Broken-link-checking environment up and running. Running dcp checks...\n"
  docker-compose -p rhd_dcp_testing run --rm --no-deps rhd_dcp_testing bundle exec dcp-checker --base-url=$RHD_BASE_URL
  echo "\n Completed run of dcp checks. \n"
}

if [ $1 ==  'blinkr' ]; then
run_blinkr_checks
else
run_dcp_checks
fi
