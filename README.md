# Sistema de Gerenciamento - Fab Lab

Trabalho acadêmico desenvolvido para a disciplina de Banco de Dados (2026/2). O objetivo do projeto é a modelagem, implementação e consulta de um sistema completo de gerenciamento de um laboratório de fabricação digital (Fab Lab).

- **SGBD:** PostgreSQL 12 ou superior (pgAdmin / psql).
- **Autores:** João Emanuel Marinho Sousa e Mirela Emilly Pereira de Souza

## Estrutura

```text
bd/
├── Trabalho Final - Projeto Lógico Conceitual.pdf
├── Trabalho Final - Projeto Lógico Relacional.pdf
├── Modelo entidade-relacionamento.png
├── modelo_relacional.png
└── scripts/
    ├── 00_criar_banco.sql             # CREATE DATABASE (rodar conectado ao banco postgres)
    ├── 01_schema_ddl.sql              # 13 tabelas, índices, funções e triggers
    ├── 02_inserts_dml.sql             # INSERTs em todas as tabelas
    ├── 03_updates_deletes.sql         # UPDATE e DELETE em todas as tabelas
    ├── 04_selects_consultas.sql       # 58 consultas (Q01 a Q58)
    ├── 05_views.sql                   # 2 views (JOIN + UNION / NOT EXISTS)
    └── 06_testes_triggers.sql         # Testes dos triggers e das regras de negócio
```

Executar na ordem **00 → 06**. Após o 00, conecte-se ao banco `fablab_db` antes de rodar o 01.

## Conferência com o enunciado

| Exigência | Onde |
|---|---|
| Criação das tabelas com toda a estrutura | 01 (13 tabelas conforme o dicionário de dados) |
| Inserts para cada tabela | 02 |
| Updates para cada tabela | 03 |
| Deletes para cada tabela | 03 |
| Selects básicos das tabelas | Q01-Q13 |
| Selects renomeando campos (2) | Q14-Q15 |
| Inner join com 2 ou mais tabelas (5) | Q16-Q20 |
| Inner join com mais de 2 tabelas e condições (5) | Q21-Q25 |
| Union com 2 ou mais tabelas (5) | Q26-Q30 |
| Left join (5) | Q31-Q35 |
| Outer join (5) - 2 RIGHT + 3 FULL OUTER (nativo no PostgreSQL) | Q36-Q40 |
| Ordenação com joins (5) | Q41-Q45 |
| Agrupamento com condições (5) | Q46-Q50 |
| Ordenação com agrupamento e HAVING (5) | Q51-Q55 |
| 2 views com join + union / in / not exists | 05 (`vw_historico_equipamento`, `vw_equipamentos_liberados`) |
| 2 tabelas com data_inclusao / data_alteracao + triggers | `usuario` e `equipamento` (01, testes em 06) |

## Regras de negócio implementadas por trigger (funções PL/pgSQL)

- **RF07:** impede reserva/utilização de equipamento restrito por usuário sem autorização.
- **RF10:** impede reservas sobrepostas para o mesmo equipamento.
- **RF11:** impede reserva em período de manutenção.
