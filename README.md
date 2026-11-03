# Sistema de Gerenciamento - Fab Lab

Trabalho acadêmico desenvolvido para a disciplina de Banco de Dados (2026/2). O objetivo do projeto é a modelagem, implementação e consulta de um sistema completo de gerenciamento de um laboratório de fabricação digital (Fab Lab).

---

##  Tecnologias Utilizadas

* **SGBD:** MySQL 8.0 (MySQL Workbench)
* **Modelagem:** PlantUML & Modelo Relacional em 3ª Forma Normal (3NF)
* **Documentação:** Markdown / PDF

---

## 📁 Estrutura do Repositório

```text
BD-2026-2-fab-lab/
├── docs/
│   ├── Dicionario_de_Dados.md                # Descrição detalhada de tabelas e atributos
│   ├── modelo_relacional.puml               # Código PlantUML do diagrama relacional
│   └── Trabalho Final - Projeto Lógico.pdf  # Documentação do projeto conceitual/lógico
├── scripts/
│   ├── 01_schema_ddl.sql                    # DDL: Criação da base de dados, tabelas e triggers
│   ├── 02_inserts_dml.sql                   # DML: Carga e povoamento inicial de dados
│   ├── 03_updates_deletes.sql               # DML: Scripts de atualização e remoção de registros
│   └── 04_selects_consultas.sql             # DQL: Consultas avançadas (JOINs, Agrupamentos, UNION, View)
└── README.md                                # Apresentação geral do projeto
