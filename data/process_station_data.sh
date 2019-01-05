#!/bin/bash

for file in raw/*.txt; do
    echo Processing $file '->' processed/$(basename ${file%txt}csv)
    ./process_raw_data.py $file > processed/$(basename ${file%txt}csv)
done
