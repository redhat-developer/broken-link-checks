#!/bin/bash

function run_blinkr_checks {
  printf "\n Launching blinkr broken-link-checking environment... \n"
  cd website && docker-compose -p rhd_blinkr_testing build --no-cache
  docker-compose -p rhd_blinkr_testing up -d blinkr_chrome
  printf "\n Broken-link-checking environment up and running. Running blinkr checks...\n"
  docker-compose -p rhd_blinkr_testing run --rm --no-deps rhd_blinkr_testing bundle exec blinkr -c $CONFIG -u $RHD_BASE_URL
  printf "\n Completed run of Blinkr checks. \n"
}

run_blinkr_checks
