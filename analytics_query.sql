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