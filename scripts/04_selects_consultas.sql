-- =====================================================================
-- PROJETO FÍSICO - FAB LAB
-- Script 04: SELECTs (cada consulta está numerada: Q01, Q02, ...)
-- Execute DEPOIS dos scripts 01, 02 e 03.
-- =====================================================================

-- =====================================================================
-- A) SELECTs BÁSICOS DAS TABELAS (uma consulta por tabela)
-- =====================================================================
-- Q01. Todos os usuários
SELECT * FROM usuario;
-- Q02. Todos os equipamentos
SELECT * FROM equipamento;
-- Q03. Todos os projetos
SELECT * FROM projeto;
-- Q04. Todos os materiais
SELECT * FROM material;
-- Q05. Todas as autorizações
SELECT * FROM autorizacao;
-- Q06. Todas as reservas
SELECT * FROM reserva;
-- Q07. Todas as ocorrências
SELECT * FROM ocorrencia;
-- Q08. Todas as manutenções
SELECT * FROM manutencao;
-- Q09. Todas as participações em projetos
SELECT * FROM participacao ORDER BY id_projeto, id_usuario;
-- Q10. Todo o consumo de materiais
SELECT * FROM consumo_material ORDER BY id_projeto, id_material;
-- Q11. Equipamentos usados em projetos
SELECT * FROM projeto_equipamento ORDER BY id_projeto, id_equipamento;
-- Q12. Histórico de utilização
SELECT * FROM utilizacao ORDER BY data_inicio;
-- Q13. Vínculos entre manutenções e ocorrências
SELECT * FROM manutencao_ocorrencia ORDER BY id_manutencao, id_ocorrencia;

-- =====================================================================
-- B) SELECTs BÁSICOS RENOMEANDO CAMPOS (2)
-- =====================================================================
-- Q14. Usuários com colunas renomeadas
SELECT id_usuario AS codigo,
       nome       AS nome_completo,
       email      AS email_contato,
       perfil     AS tipo_perfil
FROM usuario;

-- Q15. Equipamentos com colunas renomeadas
SELECT id_equipamento     AS codigo,
       nome               AS equipamento,
       categoria          AS tipo,
       status             AS situacao_atual,
       requer_autorizacao AS uso_restrito
FROM equipamento;

-- =====================================================================
-- C) INNER JOIN COM 2 OU MAIS TABELAS (5)
-- =====================================================================
-- Q16. Reservas com o nome do usuário
SELECT u.nome AS usuario, r.data_hora_inicio, r.data_hora_fim, r.status
FROM usuario u
INNER JOIN reserva r ON r.id_usuario = u.id_usuario
ORDER BY r.data_hora_inicio;

-- Q17. Equipamentos e a data de cada autorização concedida
SELECT e.nome AS equipamento, a.id_usuario, a.data_autorizacao
FROM equipamento e
INNER JOIN autorizacao a ON a.id_equipamento = e.id_equipamento
ORDER BY e.nome, a.id_usuario;

-- Q18. Participantes de cada projeto (3 tabelas)
SELECT p.nome AS projeto, u.nome AS participante, pa.data_inicio AS entrada_no_projeto
FROM projeto p
INNER JOIN participacao pa ON pa.id_projeto = p.id_projeto
INNER JOIN usuario u       ON u.id_usuario  = pa.id_usuario
ORDER BY p.nome, u.nome;

-- Q19. Ocorrências registradas por equipamento
SELECT e.nome AS equipamento, o.data_hora, o.descricao
FROM equipamento e
INNER JOIN ocorrencia o ON o.id_equipamento = e.id_equipamento
ORDER BY o.data_hora;

-- Q20. Materiais consumidos em cada projeto (3 tabelas)
SELECT p.nome AS projeto, m.nome AS material, cm.quantidade, m.unidade_medida
FROM consumo_material cm
INNER JOIN projeto p  ON p.id_projeto  = cm.id_projeto
INNER JOIN material m ON m.id_material = cm.id_material
ORDER BY p.nome, m.nome;

-- =====================================================================
-- D) INNER JOIN COM MAIS DE 2 TABELAS E CONDIÇÕES (5)
-- =====================================================================
-- Q21. Reservas ativas de equipamentos de uso restrito
SELECT u.nome AS usuario, e.nome AS equipamento, r.data_hora_inicio, r.data_hora_fim
FROM reserva r
INNER JOIN usuario u      ON u.id_usuario      = r.id_usuario
INNER JOIN equipamento e  ON e.id_equipamento  = r.id_equipamento
WHERE r.status = 'Ativa'
  AND e.requer_autorizacao = TRUE
ORDER BY r.data_hora_inicio;

-- Q22. Estudantes autorizados em equipamentos de uso restrito
SELECT u.nome AS usuario, u.perfil, e.nome AS equipamento, a.data_autorizacao
FROM autorizacao a
INNER JOIN usuario u     ON u.id_usuario     = a.id_usuario
INNER JOIN equipamento e ON e.id_equipamento = a.id_equipamento
WHERE e.requer_autorizacao = TRUE
  AND u.perfil = 'Estudante'
ORDER BY e.nome, u.nome;

-- Q23. Projetos em andamento (sem data de fim) com participantes e equipamentos (5 tabelas)
SELECT p.nome AS projeto, u.nome AS participante, e.nome AS equipamento
FROM projeto p
INNER JOIN participacao pa         ON pa.id_projeto     = p.id_projeto
INNER JOIN usuario u               ON u.id_usuario      = pa.id_usuario
INNER JOIN projeto_equipamento pe  ON pe.id_projeto     = p.id_projeto
INNER JOIN equipamento e           ON e.id_equipamento  = pe.id_equipamento
WHERE p.data_fim IS NULL
ORDER BY p.nome, u.nome, e.nome;

-- Q24. Manutenções concluídas com o problema que as originou (4 tabelas)
SELECT e.nome AS equipamento, o.descricao AS problema,
       m.descricao_servico AS servico_realizado, m.data_hora_fim AS concluida_em
FROM manutencao m
INNER JOIN equipamento e            ON e.id_equipamento = m.id_equipamento
INNER JOIN manutencao_ocorrencia mo ON mo.id_manutencao = m.id_manutencao
INNER JOIN ocorrencia o             ON o.id_ocorrencia  = mo.id_ocorrencia
WHERE m.data_hora_fim IS NOT NULL
ORDER BY m.data_hora_fim;

-- Q25. Utilizações finalizadas com mais de 2 horas de duração
SELECT u.nome AS usuario, e.nome AS equipamento, ut.data_inicio, ut.data_fim,
       minutos_entre(ut.data_inicio, ut.data_fim) AS minutos_de_uso
FROM utilizacao ut
INNER JOIN usuario u     ON u.id_usuario     = ut.id_usuario
INNER JOIN equipamento e ON e.id_equipamento = ut.id_equipamento
WHERE ut.data_fim IS NOT NULL
  AND minutos_entre(ut.data_inicio, ut.data_fim) > 120
ORDER BY ut.data_inicio;

-- =====================================================================
-- E) UNION COM 2 OU MAIS TABELAS (5)
-- =====================================================================
-- Q26. Catálogo geral: equipamentos e materiais
SELECT nome AS item, 'Equipamento' AS tipo FROM equipamento
UNION
SELECT nome AS item, 'Material'    AS tipo FROM material
ORDER BY tipo, item;

-- Q27. Linha do tempo de problemas: ocorrências e manutenções
SELECT e.nome AS equipamento, o.data_hora AS data_evento, 'Ocorrência' AS tipo, o.descricao AS detalhe
FROM ocorrencia o INNER JOIN equipamento e ON e.id_equipamento = o.id_equipamento
UNION
SELECT e.nome, m.data_hora_inicio, 'Manutenção', m.descricao_servico
FROM manutencao m INNER JOIN equipamento e ON e.id_equipamento = m.id_equipamento
ORDER BY equipamento, data_evento;

-- Q28. Usuários e o motivo de seu vínculo com o laboratório (3 tabelas)
SELECT u.nome AS usuario, 'Reserva ativa' AS vinculo
FROM usuario u INNER JOIN reserva r ON r.id_usuario = u.id_usuario WHERE r.status = 'Ativa'
UNION
SELECT u.nome, 'Autorizado em equipamento restrito'
FROM usuario u INNER JOIN autorizacao a ON a.id_usuario = u.id_usuario
UNION
SELECT u.nome, 'Participa de projeto'
FROM usuario u INNER JOIN participacao pa ON pa.id_usuario = u.id_usuario
ORDER BY usuario, vinculo;

-- Q29. Equipamentos que já tiveram ocorrência ou manutenção (sem repetição)
SELECT e.id_equipamento AS id_equipamento, e.nome AS equipamento FROM equipamento e INNER JOIN ocorrencia o ON o.id_equipamento = e.id_equipamento
UNION
SELECT e.id_equipamento, e.nome FROM equipamento e INNER JOIN manutencao m ON m.id_equipamento = e.id_equipamento
ORDER BY id_equipamento;

-- Q30. Histórico de atividades do usuário 1: reservas, utilizações e projetos
SELECT CAST(r.data_hora_inicio AS TEXT) AS data_evento, 'Reserva' AS tipo, e.nome AS detalhe
FROM reserva r INNER JOIN equipamento e ON e.id_equipamento = r.id_equipamento
WHERE r.id_usuario = 1
UNION
SELECT CAST(ut.data_inicio AS TEXT), 'Utilização', e.nome
FROM utilizacao ut INNER JOIN equipamento e ON e.id_equipamento = ut.id_equipamento
WHERE ut.id_usuario = 1
UNION
SELECT CAST(pa.data_inicio AS TEXT), 'Entrada em projeto', p.nome
FROM participacao pa INNER JOIN projeto p ON p.id_projeto = pa.id_projeto
WHERE pa.id_usuario = 1
ORDER BY data_evento;

-- =====================================================================
-- F) LEFT JOIN (5)
-- =====================================================================
-- Q31. Todos os usuários e suas reservas (inclui quem nunca reservou)
SELECT u.nome AS usuario, r.id_reserva, r.status
FROM usuario u
LEFT JOIN reserva r ON r.id_usuario = u.id_usuario
ORDER BY u.nome, r.id_reserva;

-- Q32. Todos os equipamentos e suas ocorrências
SELECT e.nome AS equipamento, o.data_hora, o.descricao AS ocorrencia
FROM equipamento e
LEFT JOIN ocorrencia o ON o.id_equipamento = e.id_equipamento
ORDER BY e.nome, o.data_hora;

-- Q33. Projetos e participantes (inclui projeto sem participante)
SELECT p.nome AS projeto, u.nome AS participante
FROM projeto p
LEFT JOIN participacao pa ON pa.id_projeto = p.id_projeto
LEFT JOIN usuario u       ON u.id_usuario  = pa.id_usuario
ORDER BY p.nome, u.nome;

-- Q34. Materiais que nunca foram consumidos em nenhum projeto
SELECT m.nome AS material, m.quantidade_disponivel
FROM material m
LEFT JOIN consumo_material cm ON cm.id_material = m.id_material
WHERE cm.id_projeto IS NULL
ORDER BY m.nome;

-- Q35. Equipamentos de uso restrito e os usuários autorizados (inclui sem nenhum autorizado)
SELECT e.nome AS equipamento, u.nome AS usuario_autorizado
FROM equipamento e
LEFT JOIN autorizacao a ON a.id_equipamento = e.id_equipamento
LEFT JOIN usuario u     ON u.id_usuario     = a.id_usuario
WHERE e.requer_autorizacao = TRUE
ORDER BY e.nome, u.nome;

-- =====================================================================
-- G) OUTER JOIN (5)
-- O PostgreSQL possui FULL OUTER JOIN nativo.
-- =====================================================================
-- Q36. RIGHT JOIN: todos os equipamentos e suas reservas
SELECT e.nome AS equipamento, r.id_reserva, r.status
FROM reserva r
RIGHT JOIN equipamento e ON e.id_equipamento = r.id_equipamento
ORDER BY e.nome, r.id_reserva;

-- Q37. RIGHT JOIN: todos os usuários e as participações em projetos
SELECT u.nome AS usuario, pa.id_projeto
FROM participacao pa
RIGHT JOIN usuario u ON u.id_usuario = pa.id_usuario
ORDER BY u.nome, pa.id_projeto;

-- Q38. FULL OUTER JOIN: equipamentos x projetos que os utilizam
SELECT e.nome AS equipamento, pe.id_projeto
FROM equipamento e
FULL OUTER JOIN projeto_equipamento pe ON pe.id_equipamento = e.id_equipamento
ORDER BY e.nome, pe.id_projeto;

-- Q39. FULL OUTER JOIN: materiais x consumo nos projetos
SELECT m.nome AS material, cm.id_projeto, cm.quantidade
FROM material m
FULL OUTER JOIN consumo_material cm ON cm.id_material = m.id_material
ORDER BY m.nome, cm.id_projeto;

-- Q40. FULL OUTER JOIN: usuários x autorizações
SELECT u.nome AS usuario, a.id_equipamento
FROM usuario u
FULL OUTER JOIN autorizacao a ON a.id_usuario = u.id_usuario
ORDER BY u.nome, a.id_equipamento;

-- =====================================================================
-- H) ORDENAÇÃO COM JOINS (5)
-- =====================================================================
-- Q41. Reservas da mais recente para a mais antiga
SELECT r.id_reserva, u.nome AS usuario, e.nome AS equipamento, r.data_hora_inicio, r.status
FROM reserva r
INNER JOIN usuario u     ON u.id_usuario     = r.id_usuario
INNER JOIN equipamento e ON e.id_equipamento = r.id_equipamento
ORDER BY r.data_hora_inicio DESC;

-- Q42. Manutenções por equipamento (A-Z) e por data (mais recente primeiro)
SELECT e.nome AS equipamento, m.data_hora_inicio, m.data_hora_fim, m.descricao_servico
FROM equipamento e
INNER JOIN manutencao m ON m.id_equipamento = e.id_equipamento
ORDER BY e.nome ASC, m.data_hora_inicio DESC;

-- Q43. Participantes por projeto e nome
SELECT p.nome AS projeto, u.nome AS participante, u.perfil
FROM projeto p
INNER JOIN participacao pa ON pa.id_projeto = p.id_projeto
INNER JOIN usuario u       ON u.id_usuario  = pa.id_usuario
ORDER BY p.nome, u.nome;

-- Q44. Consumo de materiais, do maior para o menor
SELECT m.nome AS material, p.nome AS projeto, cm.quantidade, m.unidade_medida
FROM consumo_material cm
INNER JOIN material m ON m.id_material = cm.id_material
INNER JOIN projeto p  ON p.id_projeto  = cm.id_projeto
ORDER BY cm.quantidade DESC, m.nome;

-- Q45. Histórico de utilização, do uso mais recente para o mais antigo
SELECT ut.data_inicio, ut.data_fim, u.nome AS usuario, e.nome AS equipamento
FROM utilizacao ut
INNER JOIN usuario u     ON u.id_usuario     = ut.id_usuario
INNER JOIN equipamento e ON e.id_equipamento = ut.id_equipamento
ORDER BY ut.data_inicio DESC;

-- =====================================================================
-- I) AGRUPAMENTO COM CONDIÇÕES (5)
-- =====================================================================
-- Q46. Total de reservas não canceladas por equipamento
SELECT e.id_equipamento, e.nome AS equipamento, COUNT(*) AS total_reservas
FROM equipamento e
INNER JOIN reserva r ON r.id_equipamento = e.id_equipamento
WHERE r.status <> 'Cancelada'
GROUP BY e.id_equipamento, e.nome
ORDER BY e.nome;

-- Q47. Soma, média e maior quantidade consumida por material (consumo >= 1)
SELECT m.nome AS material, SUM(cm.quantidade) AS total_consumido,
       ROUND(AVG(cm.quantidade), 2) AS media_por_projeto, MAX(cm.quantidade) AS maior_consumo
FROM material m
INNER JOIN consumo_material cm ON cm.id_material = m.id_material
WHERE cm.quantidade >= 1
GROUP BY m.id_material, m.nome
ORDER BY m.nome;

-- Q48. Horas de uso por equipamento (somente usos finalizados)
SELECT e.nome AS equipamento, COUNT(*) AS qtd_usos,
       ROUND(SUM(minutos_entre(ut.data_inicio, ut.data_fim)) / 60.0, 2) AS horas_de_uso
FROM utilizacao ut
INNER JOIN equipamento e ON e.id_equipamento = ut.id_equipamento
WHERE ut.data_fim IS NOT NULL
GROUP BY e.id_equipamento, e.nome
ORDER BY e.nome;

-- Q49. Estoque por unidade de medida (somente materiais com estoque > 0)
SELECT unidade_medida, COUNT(*) AS qtd_materiais, SUM(quantidade_disponivel) AS estoque_total,
       MIN(quantidade_disponivel) AS menor_estoque, MAX(quantidade_disponivel) AS maior_estoque
FROM material
WHERE quantidade_disponivel > 0
GROUP BY unidade_medida
ORDER BY unidade_medida;

-- Q50. Quantidade de participantes por projeto em andamento
SELECT p.nome AS projeto, COUNT(pa.id_usuario) AS participantes, MIN(pa.data_inicio) AS primeira_entrada
FROM projeto p
INNER JOIN participacao pa ON pa.id_projeto = p.id_projeto
WHERE p.data_fim IS NULL
GROUP BY p.id_projeto, p.nome
ORDER BY p.nome;

-- =====================================================================
-- J) ORDENAÇÃO COM AGRUPAMENTO E CONDIÇÃO DO AGRUPAMENTO (HAVING) (5)
-- =====================================================================
-- Q51. Equipamentos com 2 ou mais reservas não canceladas
SELECT e.nome AS equipamento, COUNT(*) AS total_reservas
FROM equipamento e
INNER JOIN reserva r ON r.id_equipamento = e.id_equipamento
WHERE r.status <> 'Cancelada'
GROUP BY e.id_equipamento, e.nome
HAVING COUNT(*) >= 2
ORDER BY total_reservas DESC, equipamento;

-- Q52. Projetos que consumiram mais de 3 unidades de material
SELECT p.nome AS projeto, SUM(cm.quantidade) AS total_material
FROM projeto p
INNER JOIN consumo_material cm ON cm.id_projeto = p.id_projeto
GROUP BY p.id_projeto, p.nome
HAVING SUM(cm.quantidade) > 3
ORDER BY total_material DESC;

-- Q53. Usuários com mais de 1 hora total de uso de equipamentos
SELECT u.nome AS usuario, COUNT(*) AS qtd_usos,
       ROUND(SUM(minutos_entre(ut.data_inicio, ut.data_fim)) / 60.0, 2) AS horas_de_uso
FROM usuario u
INNER JOIN utilizacao ut ON ut.id_usuario = u.id_usuario
WHERE ut.data_fim IS NOT NULL
GROUP BY u.id_usuario, u.nome
HAVING SUM(minutos_entre(ut.data_inicio, ut.data_fim)) > 60
ORDER BY horas_de_uso DESC;

-- Q54. Equipamentos com manutenção registrada, ordenados pelo total
SELECT e.nome AS equipamento, COUNT(*) AS total_manutencoes
FROM equipamento e
INNER JOIN manutencao m ON m.id_equipamento = e.id_equipamento
GROUP BY e.id_equipamento, e.nome
HAVING COUNT(*) >= 1
ORDER BY total_manutencoes DESC, equipamento;

-- Q55. Perfis com mais de 1 usuário cadastrado
SELECT perfil, COUNT(*) AS total_usuarios
FROM usuario
GROUP BY perfil
HAVING COUNT(*) > 1
ORDER BY total_usuarios DESC;

-- =====================================================================
-- K) CONSULTAS ESPECÍFICAS DO TEMA (requisitos RF09, RF10 e uso de IN)
-- =====================================================================
-- Q56. RF09 - Períodos já reservados da Cortadora a Laser 9060
SELECT e.nome AS equipamento, r.data_hora_inicio, r.data_hora_fim, r.status
FROM reserva r
INNER JOIN equipamento e ON e.id_equipamento = r.id_equipamento
WHERE e.nome = 'Cortadora a Laser 9060'
  AND r.status <> 'Cancelada'
ORDER BY r.data_hora_inicio;

-- Q57. RF10 - Verificação de conflitos: deve retornar 0 linhas
SELECT r1.id_reserva AS reserva_a, r2.id_reserva AS reserva_b, r1.id_equipamento
FROM reserva r1
INNER JOIN reserva r2 ON r2.id_equipamento = r1.id_equipamento
                     AND r2.id_reserva > r1.id_reserva
WHERE r1.status <> 'Cancelada' AND r2.status <> 'Cancelada'
  AND r1.data_hora_inicio < r2.data_hora_fim
  AND r1.data_hora_fim    > r2.data_hora_inicio;

-- Q58. Usando IN: usuários que participam de projetos que ainda não terminaram
SELECT u.nome, u.perfil
FROM usuario u
WHERE u.id_usuario IN (SELECT pa.id_usuario
                         FROM participacao pa
                         INNER JOIN projeto p ON p.id_projeto = pa.id_projeto
                        WHERE p.data_fim IS NULL)
ORDER BY u.nome;