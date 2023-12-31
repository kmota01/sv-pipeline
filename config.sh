#!/bin/bash

# This module helps to parse command-line arguments in bash scripts. 
# To Execute: ./script.sh -i sample -w work_dir -s software

sample=""
work_dir=""
software=""
verbose=false

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--input)
            sample="$2"
            shift 2
            ;;
        -w|--workdir)
            work_dir="$2"
            shift 2
            ;;
    	-s|--software)
	    software="$2"
	    shift 2
	    ;;
    	-v|--verbose)
            verbose=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done


