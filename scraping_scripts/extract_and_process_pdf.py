import zipfile
import pdfplumber
import pandas as pd
import os
import tempfile
import shutil

def extrair_pdf_do_zip(zip_path, extract_to, pdf_filename):
    print(f"Extraindo o PDF do arquivo ZIP: {zip_path}")
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extract_to)
    print("Extração concluída.")
    return os.path.join(extract_to, pdf_filename)

def substituir_abreviacoes(df):
    df['OD'] = df['OD'].replace({'S': 'Sim', 'N': 'Não'})
    df['AMB'] = df['AMB'].replace({'S': 'Sim', 'N': 'Não'})
    df = df.rename(columns={'OD': 'Seg. Odontológica', 'AMB': 'Seg. Ambulatorial'})
    return df

def extrair_dados_do_pdf(pdf_path):
    print(f"Iniciando extração de dados do PDF: {pdf_path}")
    with pdfplumber.open(pdf_path) as pdf:
        paginas = pdf.pages
        tabelas = []
        for pagina in paginas:
            tabelas += pagina.extract_tables()

    colunas = tabelas[0][0]
    dados = [linha for tabela in tabelas for linha in tabela[1:]]
    df = pd.DataFrame(dados, columns=colunas)

    df = substituir_abreviacoes(df)

    print("Extração de dados concluída.")
    return df

def salvar_em_csv(df, nome_arquivo):
    print(f"Salvando dados em CSV: {nome_arquivo}")
    df.to_csv(nome_arquivo, index=False)
    print("Dados salvos em CSV.")

def compactar_em_zip(nome_arquivo, nome_zip):
    print(f"Iniciando a compactação dos arquivos em: {nome_zip}")
    with zipfile.ZipFile(nome_zip, 'w') as zipf:
        zipf.write(nome_arquivo, os.path.basename(nome_arquivo))
    print(f"Compactação concluída: {nome_zip}")

def limpar_temp_dir(diretorio):
    if os.path.exists(diretorio):
        shutil.rmtree(diretorio)
        print(f"Diretório temporário {diretorio} limpo.")

def main():
    zip_path = "anexos.zip"
    pdf_filename = "Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"
    temp_dir = tempfile.mkdtemp()
    limpar_temp_dir(temp_dir)  

    pdf_path = extrair_pdf_do_zip(zip_path, temp_dir, pdf_filename)
    df = extrair_dados_do_pdf(pdf_path)
    nome_csv = os.path.join(temp_dir, "Rol_de_Procedimentos.csv")
    salvar_em_csv(df, nome_csv)

    nome_zip = "Teste_alef_thallys.zip"
    compactar_em_zip(nome_csv, nome_zip)

    print("Removendo arquivos temporários.")
    limpar_temp_dir(temp_dir)

if __name__ == "__main__":
    main()
