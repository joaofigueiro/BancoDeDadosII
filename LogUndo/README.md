# Trabalho Prático - Log Undo - Banco de Dados II
**Aluno: João Leonardo Comiran Figueiró**

O objetivo desse trabalho de Banco de Dados II é implementar o mecanismo de log Undo com checkpoint usando o SGBD.

## Funcionamento
- O código deverá ser capaz de ler o arquivo de log (test_files/log) e o arquivo de Metadado (test_files/metadado.json) e validar as informações no banco de dados através do modelo UNDO.
- O código receberá como entrada o arquivo de metadados (dados salvos) e os dados da tabela que irá operar no banco de dados.

Exemplo de tabela do banco de dados:

  ID  |  A  |  B
 ---- | --- | ---
  1   |  20 | 20
  2   |  20 | 30

Arquivo de log no formato **<transação, “id da tupla”,”coluna”, “valor antigo”, “valor novo”>**

## Exemplo
Arquivo de Metadado (json):

```
{
  "table": {
	“id”:[1,2],
	"A": [20,20],
	"B": [55,30]
  }
}

```

Arquivo de Log:

```
<start T1>
<T1,1, A,20>
<start T2>
<commit T1>
<START CKPT(T2)>
<T2,2, B,20>	
<commit T2>
<END CKPT>
<start T3>
<start T4>
<T4,1, B,55>
```

Saída:

```
“Transação T3 realizou Undo”
“Transação T4 realizou Undo”

{
  "table": {
  "A": [500,20],
  "B": [20,30]
  }
}
```

O checkpoint Undo permite que parte do log já processada seja descartada para evitar o reprocessamento.

## Detalhes
Funções a serem implementadas:
- Carregar o banco de dados com a tabela antes de executar o código do log (para zerar as configurações e dados parciais);
- Carregar o arquivo de log;
- Verifique quais transações devem realizar UNDO. Imprimir o nome das transações que irão sofrer Undo. Observem a questão do checkpoint;
- Checar quais valores estão salvos nas tabelas (com o select) e atualizar valores inconsistentes (update);
- Reportar quais dados foram atualizados;
- Seguir o fluxo de execução conforme o método de Undo, conforme visto em aula;

## Para rodar
- É necessário ter instaladas as seguintes dependências:
  - Python 3.x
  - Postgres 14.x
- É necessária a instalação do pacote psycopg2: **pip install psycopg2**
- É necessária a criação da database db_log: **CREATE DATABASE db_log;**
- Tendo seguido todos os passos anteriores, é possível rodar o projeto através do comando: **python main.py**
