import subprocess

def run_script(script_name):
    try:
        result = subprocess.run(['python3', script_name], check=True, capture_output=True, text=True)
        print(f"Output of {script_name}:\n{result.stdout}")
    except subprocess.CalledProcessError as e:
        print(f"Error running {script_name}:\n{e.stderr}")

if __name__ == "__main__":
    run_script('scraping_scripts/web_scraping_and_download.py')
    run_script('scraping_scripts/extract_and_process_pdf.py')
    run_script('scraping_scripts/download_files.py')