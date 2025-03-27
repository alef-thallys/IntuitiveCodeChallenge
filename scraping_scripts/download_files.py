import os
import requests
import zipfile
from datetime import datetime
from bs4 import BeautifulSoup

def download_file(url, dest_folder):
    if not os.path.exists(dest_folder):
        os.makedirs(dest_folder)
    response = requests.get(url)

    if response.status_code == 200:
        file_name = url.split("/")[-1]
        file_path = os.path.join(dest_folder, file_name)
        with open(file_path, "wb") as file:
            file.write(response.content)
        print(f"Arquivo {file_name} baixado com sucesso.")
        return file_path  
    else:
        print(f"Falha ao tentar baixar o arquivo de {url}.")
        return None

def get_file_links_from_directory(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.text, "html.parser")
    links = []

    for link in soup.find_all("a"):
        href = link.get("href")
        if href and href.endswith(".zip"):  
            links.append(url + href)
    return links

def extract_zip_file(zip_file_path, dest_folder):
    try:
        with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
            zip_ref.extractall(dest_folder)
            print(f"Arquivos extraídos com sucesso para {dest_folder}.")

        os.remove(zip_file_path)
        print(f"Arquivo {zip_file_path} apagado com sucesso.")

    except Exception as e:
        print(f"Erro ao extrair o arquivo {zip_file_path}: {e}")

demonstracoes_url = "https://dadosabertos.ans.gov.br/FTP/PDA/demonstracoes_contabeis/"
operadoras_url = "https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/"

dest_folder_demonstracoes = "demonstracoes_contabeis"
dest_folder_operadoras = "operadoras_ativas"

current_year = datetime.now().year
for year in range(current_year - 2, current_year):
    year_url = f"{demonstracoes_url}{year}/"

    file_links = get_file_links_from_directory(year_url)

    for file_url in file_links:
        zip_file_path = download_file(file_url, dest_folder_demonstracoes)
        if zip_file_path:
            extract_zip_file(zip_file_path, dest_folder_demonstracoes)

operadoras_file_url = f"{operadoras_url}Relatorio_cadop.csv"
download_file(operadoras_file_url, dest_folder_operadoras)
