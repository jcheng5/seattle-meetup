#!/bin/bash

mkdir -p health/data
curl http://databank.worldbank.org/data/download/hnp_stats_csv.zip > health/data/hnp_stats_csv.zip
(cd health/data; unzip hnp_stats_csv.zip)

