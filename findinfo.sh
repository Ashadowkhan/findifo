#!/bin/bash

# Check if required tools are installed
if ! command -v httpx &> /dev/null || ! command -v gau &> /dev/null; then
    echo "Required tools (httpx, gau) are not installed. Please install them first."
    exit 1
fi

# Function to process a single domain
process_domain() {
    local domain=$1
    local output_file=$2

    echo "Scanning domain: $domain" | tee -a "$output_file"

    # Find common files
    gau "$domain" | grep -E '\.xml|\.conf|\.cnf|\.reg|\.inf|\.rdp|\.cfg|\.txt|\.ora|\.ini|\.sql|\.dbf|\.mdb|\.log|\.bak|\.old|\.backup|\.doc|\.docx|\.pdf|\.rtf|\.ppt|\.pptx|\.csv' | httpx -silent -status-code -mc 200 | tee -a "$output_file"

    # Check for exposed .git/config
    echo "$domain" | httpx -path /.git/config -silent -status-code -mc 200 | tee -a "$output_file"

    # Check for robots.txt
    echo "$domain" | httpx -path /robots.txt -silent -status-code -mc 200 | tee -a "$output_file"

    echo "Scan completed for $domain. Results saved in $output_file"
    echo "---------------------------------" | tee -a "$output_file"
}

# Parse input arguments
while getopts ":u:d:o:" opt; do
    case $opt in
        u) domain="$OPTARG";;
        d) domain_list="$OPTARG";;
        o) output_file="$OPTARG";;
        \?) echo "Invalid option -$OPTARG" >&2; exit 1;;
    esac
done

# Validate input
if [ -z "$domain" ] && [ -z "$domain_list" ]; then
    echo "Usage: $0 -u domain.com or -d domainlist.txt -o output_file.txt"
    exit 1
fi

# Set default output file if not specified
output_file=${output_file:-"scan_results.txt"}

# Process a single domain
if [ -n "$domain" ]; then
    process_domain "$domain" "$output_file"
fi

# Process a list of domains
if [ -n "$domain_list" ] && [ -f "$domain_list" ]; then
    while IFS= read -r line; do
        process_domain "$line" "$output_file"
    done < "$domain_list"
else
    if [ -n "$domain_list" ]; then
        echo "File $domain_list not found!"
    fi
fi
