-- Create the 'operadoras_ativas' table with unique constraint on 'registro_ans'
CREATE TABLE IF NOT EXISTS operadoras_ativas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registro_ans INT NOT NULL,
    cnpj VARCHAR(18) NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(50),
    logradouro VARCHAR(255),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(3),
    telefone VARCHAR(15),
    fax VARCHAR(15),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_de_comercializacao VARCHAR(255),
    data_registro_ans DATE,
    UNIQUE (registro_ans)  -- Add unique constraint to 'registro_ans'
);

-- Create the 'demonstracoes_contabeis' table with foreign key reference to 'operadoras_ativas'
CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    reg_ans INT NOT NULL,
    cd_conta_contabil VARCHAR(50) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    vl_saldo_inicial DECIMAL(15, 2) NOT NULL,
    vl_saldo_final DECIMAL(15, 2) NOT NULL,
    CONSTRAINT fk_registro_ans FOREIGN KEY (reg_ans) REFERENCES operadoras_ativas (registro_ans)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Importação de dados para a tabela 'operadoras_ativas' a partir do arquivo CSV
LOAD DATA LOCAL INFILE 'operadoras_ativas/Relatorio_cadop.csv'
INTO TABLE operadoras_ativas
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@registro_ans, @cnpj, @razao_social, @nome_fantasia, @modalidade, @logradouro, @numero, @complemento, @bairro, @cidade, @uf, @cep, @ddd, @telefone, @fax, @endereco_eletronico, @representante, @cargo_representante, @regiao_de_comercializacao, @data_registro_ans)
SET
    registro_ans = NULLIF(@registro_ans, ''),
    cnpj = NULLIF(@cnpj, ''),
    razao_social = NULLIF(@razao_social, ''),
    nome_fantasia = NULLIF(@nome_fantasia, ''),
    modalidade = NULLIF(@modalidade, ''),
    logradouro = NULLIF(@logradouro, ''),
    numero = NULLIF(@numero, ''),
    complemento = NULLIF(@complemento, ''),
    bairro = NULLIF(@bairro, ''),
    cidade = NULLIF(@cidade, ''),
    uf = NULLIF(@uf, ''),
    cep = NULLIF(@cep, ''),
    ddd = NULLIF(@ddd, ''),
    telefone = NULLIF(@telefone, ''),
    fax = NULLIF(@fax, ''),
    endereco_eletronico = NULLIF(@endereco_eletronico, ''),
    representante = NULLIF(@representante, ''),
    cargo_representante = NULLIF(@cargo_representante, ''),
    regiao_de_comercializacao = NULLIF(@regiao_de_comercializacao, ''),
    data_registro_ans = STR_TO_DATE(@data_registro_ans, '%d/%m/%Y');

-- Carregar arquivos CSV da pasta demonstracoes_contabeis
LOAD DATA LOCAL INFILE 'demonstracoes_contabeis/1T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
   data = NULLIF(@data, ''), 
    reg_ans = NULLIF(@reg_ans, ''),     
    cd_conta_contabil = TRIM(NULLIF(@cd_conta_contabil, '')),
    descricao = TRIM(NULLIF(@descricao, '')),  
    vl_saldo_inicial = REPLACE(NULLIF(@vl_saldo_inicial, ''), ',', '.'),
    vl_saldo_final = REPLACE(NULLIF(@vl_saldo_final, ''), ',', '.');


LOAD DATA LOCAL INFILE 'demonstracoes_contabeis/1T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = NULLIF(@data, ''), 
    reg_ans = NULLIF(@reg_ans, ''),     
    cd_conta_contabil = TRIM(NULLIF(@cd_conta_contabil, '')),
    descricao = TRIM(NULLIF(@descricao, '')),  
    vl_saldo_inicial = REPLACE(NULLIF(@vl_saldo_inicial, ''), ',', '.'),
    vl_saldo_final = REPLACE(NULLIF(@vl_saldo_final, ''), ',', '.');

LOAD DATA LOCAL INFILE 'demonstracoes_contabeis/2t2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
   data = NULLIF(@data, ''), 
    reg_ans = NULLIF(@reg_ans, ''),     
    cd_conta_contabil = TRIM(NULLIF(@cd_conta_contabil, '')),
    descricao = TRIM(NULLIF(@descricao, '')),  
    vl_saldo_inicial = REPLACE(NULLIF(@vl_saldo_inicial, ''), ',', '.'),
    vl_saldo_final = REPLACE(NULLIF(@vl_saldo_final, ''), ',', '.');


LOAD DATA LOCAL INFILE 'demonstracoes_contabeis/2T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
     data = NULLIF(@data, ''), 
    reg_ans = NULLIF(@reg_ans, ''),     
    cd_conta_contabil = TRIM(NULLIF(@cd_conta_contabil, '')),
    descricao = TRIM(NULLIF(@descricao, '')),  
    vl_saldo_inicial = REPLACE(NULLIF(@vl_saldo_inicial, ''), ',', '.'),
    vl_saldo_final = REPLACE(NULLIF(@vl_saldo_final, ''), ',', '.');

LOAD DATA LOCAL INFILE 'demonstracoes_contabeis/3T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = NULLIF(@data, ''), 
    reg_ans = NULLIF(@reg_ans, ''),     
    cd_conta_contabil = TRIM(NULLIF(@cd_conta_contabil, '')),
    descricao = TRIM(NULLIF(@descricao, '')),  
    vl_saldo_inicial = REPLACE(NULLIF(@vl_saldo_inicial, ''), ',', '.'),
    vl_saldo_final = REPLACE(NULLIF(@vl_saldo_final, ''), ',', '.');


LOAD DATA LOCAL INFILE 'demonstracoes_contabeis/3T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = NULLIF(@data, ''), 
    reg_ans = NULLIF(@reg_ans, ''),     
    cd_conta_contabil = TRIM(NULLIF(@cd_conta_contabil, '')),
    descricao = TRIM(NULLIF(@descricao, '')),  
    vl_saldo_inicial = REPLACE(NULLIF(@vl_saldo_inicial, ''), ',', '.'),
    vl_saldo_final = REPLACE(NULLIF(@vl_saldo_final, ''), ',', '.');


LOAD DATA LOCAL INFILE 'demonstracoes_contabeis/4T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = NULLIF(@data, ''), 
    reg_ans = NULLIF(@reg_ans, ''),     
    cd_conta_contabil = TRIM(NULLIF(@cd_conta_contabil, '')),
    descricao = TRIM(NULLIF(@descricao, '')),  
    vl_saldo_inicial = REPLACE(NULLIF(@vl_saldo_inicial, ''), ',', '.'),
    vl_saldo_final = REPLACE(NULLIF(@vl_saldo_final, ''), ',', '.');

LOAD DATA LOCAL INFILE 'demonstracoes_contabeis/4T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = NULLIF(@data, ''), 
    reg_ans = NULLIF(@reg_ans, ''),     
    cd_conta_contabil = TRIM(NULLIF(@cd_conta_contabil, '')),
    descricao = TRIM(NULLIF(@descricao, '')),  
    vl_saldo_inicial = REPLACE(NULLIF(@vl_saldo_inicial, ''), ',', '.'),
    vl_saldo_final = REPLACE(NULLIF(@vl_saldo_final, ''), ',', '.');


-- Consulta para obter as 10 operadoras com as maiores despesas no último trimestre
SELECT 
    o.razao_social, 
    SUM(d.vl_saldo_final) AS total_despesas
FROM 
    demonstracoes_contabeis d
JOIN 
    operadoras_ativas o ON d.reg_ans = o.registro_ans
WHERE 
    REGEXP_REPLACE(d.descricao, '\\s+', ' ') LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MÉDICO HOSPITALAR%'
    AND d.data = '2024-10-01'
GROUP BY 
    o.razao_social
ORDER BY 
    total_despesas DESC
LIMIT 10;


-- Consulta para obter as 10 operadoras com as maiores despesas no último ano
SELECT 
    d.data,
    o.razao_social, 
    SUM(d.vl_saldo_final) AS total_despesas
FROM 
    demonstracoes_contabeis d
JOIN 
    operadoras_ativas o ON d.reg_ans = o.registro_ans
WHERE 
     d.data >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY 
    o.razao_social
ORDER BY 
    total_despesas DESC
LIMIT 10;
