# Dicionário de Dados — Sistema Fab Lab

descrição da estrutura das tabelas do banco de dados relacional do Fab Lab, incluindo tipos de dados, chaves primárias (PK), chaves estrangeiras (FK) e restrições de integridade.

---

## 1. Tabela: `Usuario`
Armazena as informações de identificação e contato dos usuários cadastrados no Fab Lab.

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_usuario` | INT | Não | PK | Código identificador único do usuário |
| `nome` | VARCHAR(100) | Não | - | Nome completo do usuário |
| `email` | VARCHAR(100) | Não | - | E-mail de contato / acadêmico |
| `perfil` | VARCHAR(20) | Não | - | Categoria do usuário (Estudante, Professor, Pesquisador, Visitante) |
| `telefone` | VARCHAR(20) | Sim | - | Número de telefone de contato |
| `data_inclusao` | DATETIME | Não | - | Data e hora de criação do registro (atualizado via Trigger) |
| `data_alteracao` | DATETIME | Sim | - | Data e hora da última modificação (atualizado via Trigger) |

---

## 2. Tabela: `Equipamento`
Registra os equipamentos e máquinas disponíveis no Fab Lab.

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_equipamento` | INT | Não | PK | Código identificador único do equipamento |
| `nome` | VARCHAR(100) | Não | - | Nome ou modelo do equipamento |
| `categoria` | VARCHAR(50) | Não | - | Categoria (Impressora 3D, Cortadora a Laser, CNC, Eletrônica) |
| `descricao` | TEXT | Sim | - | Descrição detalhada do equipamento |
| `requer_autorizacao`| BOOLEAN | Não | - | Indica se exige treinamento/autorização prévia (1 = Sim, 0 = Não) |
| `status` | VARCHAR(20) | Não | - | Situação operacional (Disponível, Em uso, Indisponível, Em manutenção) |
| `data_inclusao` | DATETIME | Não | - | Data e hora de criação do registro (atualizado via Trigger) |
| `data_alteracao` | DATETIME | Sim | - | Data e hora da última modificação (atualizado via Trigger) |

---

## 3. Tabela: `Autorizacao`
Registra as permissões concedidas a usuários para operar equipamentos de uso restrito.

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_autorizacao` | INT | Não | PK | Código identificador da autorização |
| `id_usuario` | INT | Não | FK | Referência ao usuário autorizado (`Usuario.id_usuario`) |
| `id_equipamento` | INT | Não | FK | Referência ao equipamento restrito (`Equipamento.id_equipamento`) |
| `data_autorizacao` | DATE | Não | - | Data em que a permissão foi concedida |

---

## 4. Tabela: `Reserva`
Gerencia o agendamento de equipamentos pelos usuários.

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_reserva` | INT | Não | PK | Código identificador da reserva |
| `id_usuario` | INT | Não | FK | Referência ao usuário solicitante (`Usuario.id_usuario`) |
| `id_equipamento` | INT | Não | FK | Referência ao equipamento reservado (`Equipamento.id_equipamento`) |
| `data_hora_inicio` | DATETIME | Não | - | Data e horário de início da reserva |
| `data_hora_fim` | DATETIME | Não | - | Data e horário de término da reserva |
| `status` | VARCHAR(20) | Não | - | Situação da reserva (Confirmada, Cancelada, Concluída) |

---

## 5. Tabela: `Projeto`
Registra os projetos desenvolvidos dentro do laboratório.

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_projeto` | INT | Não | PK | Código identificador único do projeto |
| `nome` | VARCHAR(100) | Não | - | Título do projeto |
| `descricao` | TEXT | Sim | - | Descrição dos objetivos e escopo do projeto |
| `data_inicio` | DATE | Não | - | Data de início das atividades do projeto |
| `data_fim` | DATE | Sim | - | Data de encerramento do projeto |

---

## 6. Tabela Associativa: `Projeto_Usuario`
Mapeia a participação dos usuários em projetos (Relacionamento N:N).

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_projeto` | INT | Não | PK, FK | Referência ao projeto (`Projeto.id_projeto`) |
| `id_usuario` | INT | Não | PK, FK | Referência ao participante (`Usuario.id_usuario`) |
| `data_inicio` | DATE | Não | - | Data em que o usuário ingressou no projeto |

---

## 7. Tabela Associativa: `Projeto_Equipamento`
Registra os equipamentos utilizados no desenvolvimento de cada projeto (Relacionamento N:N).

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_projeto` | INT | Não | PK, FK | Referência ao projeto (`Projeto.id_projeto`) |
| `id_equipamento` | INT | Não | PK, FK | Referência ao equipamento utilizado (`Equipamento.id_equipamento`) |

---

## 8. Tabela: `Material`
Cadastra os materiais de consumo fornecidos pelo Fab Lab.

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_material` | INT | Não | PK | Código identificador do material |
| `nome` | VARCHAR(100) | Não | - | Nome do material (ex: Filamento PLA, Chapa MDF) |
| `unidade_medida` | VARCHAR(20) | Não | - | Unidade de consumo (kg, metros, unidades, gramas) |
| `quantidade_disponivel`| DECIMAL(10,2)| Não | - | Quantidade atual em estoque |

---

## 9. Tabela Associativa: `Projeto_Material`
Controla o consumo de materiais em cada projeto (Relacionamento N:N).

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_projeto` | INT | Não | PK, FK | Referência ao projeto (`Projeto.id_projeto`) |
| `id_material` | INT | Não | PK, FK | Referência ao material utilizado (`Material.id_material`) |
| `quantidade` | DECIMAL(10,2)| Não | - | Quantidade consumida do material |

---

## 10. Tabela: `Ocorrencia`
Registra falhas, danos ou incidentes com os equipamentos durante seu uso.

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_ocorrencia` | INT | Não | PK | Código identificador do registro de ocorrência |
| `id_equipamento` | INT | Não | FK | Referência ao equipamento com problema (`Equipamento.id_equipamento`) |
| `data_hora` | DATETIME | Não | - | Data e horário do registro |
| `descricao` | TEXT | Não | - | Relato do problema ou incidente ocorrido |

---

## 11. Tabela: `Manutencao`
Registra os serviços de manutenção preventiva e corretiva realizados nos equipamentos.

| Campo | Tipo de Dado | Nulo | Chave | Descrição |
| :--- | :--- | :--- | :--- | :--- |
| `id_manutencao` | INT | Não | PK | Código identificador do registro de manutenção |
| `id_equipamento` | INT | Não | FK | Referência ao equipamento em manutenção (`Equipamento.id_equipamento`) |
| `id_ocorrencia` | INT | Sim | FK | Referência à ocorrência relacionada, se houver (`Ocorrencia.id_ocorrencia`) |
| `data_hora_inicio` | DATETIME | Não | - | Início do período de manutenção |
| `data_hora_fim` | DATETIME | Sim | - | Término do período de manutenção |
| `descricao_servico`| TEXT | Não | - | Detalhamento dos serviços e reparos realizados |
