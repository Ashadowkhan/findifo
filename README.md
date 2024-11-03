Here's a bash script named `findinfo.sh` that can take a domain or a list of domains as input and output the results to a specified file. This script will use `httpx`, `gau`, and other tools to identify potential information disclosures.

Save this script as `findinfo.sh`:

### How to Use the Script:
1. **Make the script executable:**
   ```bash
   chmod +x findinfo.sh
   ```

2. **Run with a single domain:**
   ```bash
   ./findinfo.sh -u domain.com -o output.txt
   ```

3. **Run with a list of domains:**
   ```bash
   ./findinfo.sh -d domainlist.txt -o output.txt
   ```

### Explanation:
- **`-u domain.com`**: Scans a single domain.
- **`-d domainlist.txt`**: Scans domains from a file.
- **`-o output_file.txt`**: Outputs results to a specified file (defaults to `scan_results.txt` if not provided).
- **`httpx` and `gau`**: These tools gather URLs and check the HTTP status codes.

### Ensure these tools are installed:
- Install `httpx` with:
  ```bash
  go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
  ```

- Install `gau` with:
  ```bash
  go install github.com/lc/gau/v2/cmd/gau@latest
  ```

This script helps automate scanning for common information disclosure vulnerabilities across single or multiple domains and outputs the results to a specified file.
