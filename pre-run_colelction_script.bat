@echo off
  newman run Pre-run.postman_collection.json ^
      -e WEare.postman_environment.json ^
      --iteration-data post_data.csv ^
      --iteration-data user-data.csv

