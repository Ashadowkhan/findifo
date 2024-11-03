How to Use the Script:
Make the script executable:

bash
Copy code
chmod +x findinfo.sh
Run with a single domain:

bash
Copy code
./findinfo.sh -u domain.com -o output.txt
Run with a list of domains:

bash
Copy code
./findinfo.sh -d domainlist.txt -o output.txt
Explanation:
-u domain.com: Scans a single domain.
-d domainlist.txt: Scans domains from a file.
-o output_file.txt: Outputs results to a specified file (defaults to scan_results.txt if not provided).
httpx and gau: These tools gather URLs and check the HTTP status codes.
Ensure these tools are installed:
Install httpx with:

bash
Copy code
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
Install gau with:

bash
Copy code
go install github.com/lc/gau/v2/cmd/gau@latest
This script helps automate scanning for common information disclosure vulnerabilities across single or multiple domains and outputs the results to a specified file.
