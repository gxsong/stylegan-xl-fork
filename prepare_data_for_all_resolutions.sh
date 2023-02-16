#!/bin/bash

# Parse command line options
while getopts ":t:r:" opt; do
  case ${opt} in
    t)
      image_type=$OPTARG
      ;;
    r)
      resolutions=($OPTARG)
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND -1))

# Loop over resolutions and create zip files
for res in "${resolutions[@]}"; do
  zip_name="${image_type}_${res}.zip"
  echo "python dataset_tool.py --source=./data/$image_type --dest=./data/$zip_name --resolution=${res}x${res} --transform=center-crop"
done
