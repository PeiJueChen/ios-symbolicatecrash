#!/usr/bin/bash
export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"

if [ -z "$1" ]; then
    echo "missing ips name";
    exit 1
fi

ipsPath=$1

dsym=${2:-"App.app.dSYM"}

date="$(date +'%Y%m%d')"
time="$(date +'%Y%m%d-%H-%M-%S')"

echo $date $time

output_dir=$date  
output_file="$output_dir/$time.crash"

if [ ! -d "$output_dir" ]; then  
    mkdir "$output_dir"  
fi  


swift ./convertFromJSON.swift -i "$ipsPath" -o "$output_file"



./symbolicatecrash "$output_file" $dsym > "$output_dir/result-$time.crash"


#use
# bash run.sh App-2024-09-02-171803.ips


# https://cloud.tencent.com/developer/article/2345755