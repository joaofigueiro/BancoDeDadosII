1  Listar os empregados (nomes) que tem salário maior que seu chefe (usar o join):

  --  empregado | 
  -- -----------+
  --  Maria     |
  --  Claudia   |
  --  Ana       |
  --  Luiz      |

  SELECT e.nome AS empregado FROM empregados e JOIN empregados es ON e.supervisor_id = es.emp_id WHERE e.salario > es.salario;

2 Listar o maior salario de cada departamento (usa o group by): 

  --  dep_id |  max  
  -- --------+-------
  --       1 | 10000
  --       2 |  8000
  --       3 |  6000
  --       4 | 12200

SELECT e.dep_id, MAX(e.salario) FROM empregados e GROUP BY e.dep_id ORDER BY e.dep_id; 

3 Listar o dep_id, nome e o salario do funcionario com maior salario dentro de cada departamento (usar o with):
    
    --  dep_id |  nome   | salario 
    -- --------+---------+---------
    --       3 | Joao    |    6000
    --       1 | Claudia |   10000
    --       4 | Ana     |   12200
    --       2 | Luiz    |    8000

WITH maiores_salarios AS (
  SELECT 
    e.emp_id, 
    e.dep_id, 
    e.nome, 
    e.salario, 
    ROW_NUMBER() OVER (PARTITION BY e.dep_id ORDER BY e.salario DESC) AS ranking_salario 
  FROM empregados e
) SELECT 
    dep_id,   
    nome, 
    salario
  FROM 
    maiores_salarios
  WHERE 
    ranking_salario = 1;

