import subprocess

def run_script(script_name):
    print(f"Starting execution of {script_name}...")
    try:
        result = subprocess.run(['python3', script_name], check=True, capture_output=True, text=True)
        print(f"Successfully executed {script_name}.\nOutput:\n{result.stdout}")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running {script_name}:\n{e.stderr}")
    finally:
        print(f"Finished execution of {script_name}.")

if __name__ == "__main__":
    print("Running all scraping scripts...")
    run_script('scraping_scripts/web_scraping_and_download.py')
    run_script('scraping_scripts/extract_and_process_pdf.py')
    run_script('scraping_scripts/download_files.py')
    print("All scraping scripts have been executed.")