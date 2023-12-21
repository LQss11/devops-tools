import os
import json
from datetime import datetime, timezone
from urllib.parse import urljoin, urlparse
import concurrent.futures
import requests
from bs4 import BeautifulSoup

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
}

def format_size(size_in_bytes):
    # Convert file size to human-readable format
    for unit in ['B', 'KB', 'MB', 'GB']:
        if size_in_bytes < 1024.0:
            return f"{size_in_bytes:.2f} {unit}"
        size_in_bytes /= 1024.0

def categorize_files_by_creation_time(files):
    categorized_files = {}
    for file in files:
        # Check if creation_time is 'N/A'
        if file["creation_time"] == "N/A":
            continue  # Skip files with no creation time information

        # Parse the creation_time
        creation_time = datetime.strptime(file["creation_time"], "%Y-%m-%d %H:%M:%S")

        # Extract year, month, and day from the creation_time
        year = str(creation_time.year)
        month = str(creation_time.month).zfill(2)  # Zero-padding for single-digit months
        day = str(creation_time.day).zfill(2)  # Zero-padding for single-digit days

        # Extract file format
        file_format = os.path.splitext(file["file_name"])[1][1:]

        # Create a nested structure for categorization
        # categorized_files.setdefault(year, {}).setdefault(month, {}).setdefault(day, {}).setdefault(file_format, []).append(file)
        categorized_files.setdefault(file_format, []).append(file)

    return categorized_files

def get_file_details(url):
    try:
        with requests.get(url, stream=True, headers=HEADERS) as file_response:
            file_response.raise_for_status()

            # Get file details
            file_stat = file_response.headers.get('content-length')
            last_modified = file_response.headers.get('last-modified')
            if last_modified:
                creation_time = datetime.strptime(last_modified, "%a, %d %b %Y %H:%M:%S %Z").strftime("%Y-%m-%d %H:%M:%S")
            else:
                print(f"Skipping file {url} with no last-modified header.")
                return {}

            return {
                "file_name": os.path.basename(urlparse(url).path),
                "file_url": url,
                "creation_time": creation_time,
                "file_size": format_size(int(file_stat)) if file_stat else "N/A",  # in KB, MB, GB
                "server_last_modified": last_modified,
                "server_expires": ""
            }
    except requests.exceptions.RequestException as e:
        print(f"Error getting details for {url}: {e}")
        return {}

def get_file_formats(url, target_formats):
    try:
        with requests.get(url, headers=HEADERS) as response:
            response.raise_for_status()
            soup = BeautifulSoup(response.text, 'html.parser')

        # Extract links from the soup
        links = [urljoin(url, a['href']) for a in soup.find_all('a', href=True)]

        # Filter links based on target formats
        filtered_links = [link for link in links if os.path.splitext(urlparse(link).path)[1][1:] in target_formats]

        return filtered_links

    except requests.exceptions.RequestException as e:
        print(f"Error fetching content from {url}: {e}")
        return []

# Example usage

url = "https://salem-affes.azurewebsites.net/"

target_formats = {'pdf', 'xlsx'}  # Use a set for faster membership testing

available_formats = get_file_formats(url, target_formats)

if available_formats:
    output_data = []

    with concurrent.futures.ThreadPoolExecutor() as executor:
        # Retrieve file details concurrently
        file_details_list = list(executor.map(get_file_details, available_formats))

    # Filter out empty file details
    file_details_list = [file_details for file_details in file_details_list if file_details]

    # Categorize files by creation_time and file format
    categorized_files = categorize_files_by_creation_time(file_details_list)

    # Save the categorized output to a JSON file
    output_file_path = "categorized_file_details.json"
    with open(output_file_path, 'w', encoding='utf-8') as json_file:
        json.dump(categorized_files, json_file, ensure_ascii=False, indent=2)

    print(f"File details categorized and saved to {output_file_path}")
else:
    print(f"No file formats found at {url}")
