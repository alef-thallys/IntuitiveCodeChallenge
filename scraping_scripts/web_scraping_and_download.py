import requests
from bs4 import BeautifulSoup
import os
import tempfile
import zipfile
import shutil

url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"

ZIP_DIR = "anexos"
ZIP_PATH = os.path.join(ZIP_DIR, "anexos.zip")

def scrape_pdfs(url):
    print(f"Iniciando o scraping na URL: {url}")
    response = requests.get(url)

    if response.status_code != 200:
        print(f"Erro ao acessar a URL: {url}. Status code: {response.status_code}")
        return []

    soup = BeautifulSoup(response.text, 'html.parser')
    links = soup.find_all('a')
    pdf_links = []

    for link in links:
        if 'href' in link.attrs and (link.text.strip().lower().startswith('anexo i') or link.text.strip().lower().startswith('anexo ii')):
            pdf_links.append(link['href'])

    print(f"Encontrados {len(pdf_links)} links para PDFs")
    return pdf_links

def download_file(url, dest_folder):
    local_filename = os.path.join(dest_folder, os.path.basename(url))
    print(f"Baixando o arquivo: {url}")
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(local_filename, 'wb') as f:
            for chunk in r.iter_content(chunk_size=8192):
                if chunk:
                    f.write(chunk)
    print(f"Download concluído para o arquivo: {local_filename}")
    return local_filename

def create_zip(files, zip_filename):
    os.makedirs(os.path.dirname(zip_filename), exist_ok=True)

    print(f"Iniciando a compactação dos arquivos em: {zip_filename}")
    with zipfile.ZipFile(zip_filename, 'w') as zipf:
        for file in files:
            zipf.write(file, os.path.basename(file))
            print(f"Arquivo adicionado ao ZIP: {file}")
    print(f"Compactação concluída: {zip_filename}")

def limpar_temp_dir(diretorio):
    if os.path.exists(diretorio):
        shutil.rmtree(diretorio)
        print(f"Diretório temporário {diretorio} limpo.")

def main():
    temp_dir = tempfile.mkdtemp()
    limpar_temp_dir(temp_dir)  

    pdf_urls = scrape_pdfs(url)

    if not pdf_urls:
        print("Nenhum PDF encontrado para download.")
        return

    temp_dir = tempfile.mkdtemp()
    downloaded_files = []

    try:
        for pdf_url in pdf_urls:
            local_file = download_file(pdf_url, temp_dir)
            downloaded_files.append(local_file)

        create_zip(downloaded_files, ZIP_PATH)
    finally:
        print("Removendo arquivos temporários.")
        for file in downloaded_files:
            os.remove(file)
        shutil.rmtree(temp_dir, ignore_errors=True) 
        print("Arquivos temporários removidos.")

if __name__ == "__main__":
    main()
