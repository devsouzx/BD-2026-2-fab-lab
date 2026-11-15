-- =====================================================================
-- PROJETO FÍSICO - FAB LAB
-- Script 05: VIEWS (2 views com JOIN + UNION / NOT EXISTS)
-- =====================================================================

-- ---------------------------------------------------------------------
-- VIEW 1: histórico dos equipamentos (RF19) - JOIN + UNION
-- Reúne ocorrências, manutenções e utilizações de cada equipamento.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_historico_equipamento AS
SELECT e.id_equipamento, e.nome AS equipamento, o.data_hora AS data_evento,
       'Ocorrência' AS tipo_evento, o.descricao AS detalhe
FROM equipamento e
INNER JOIN ocorrencia o ON o.id_equipamento = e.id_equipamento
UNION
SELECT e.id_equipamento, e.nome, m.data_hora_inicio,
       'Manutenção', m.descricao_servico
FROM equipamento e
INNER JOIN manutencao m ON m.id_equipamento = e.id_equipamento
UNION
SELECT e.id_equipamento, e.nome, ut.data_inicio,
       'Utilização', CONCAT('Usado por ', u.nome)
FROM equipamento e
INNER JOIN utilizacao ut ON ut.id_equipamento = e.id_equipamento
INNER JOIN usuario u     ON u.id_usuario      = ut.id_usuario;

-- Consulta da view 1
SELECT * FROM vw_historico_equipamento ORDER BY id_equipamento, data_evento;

-- ---------------------------------------------------------------------
-- VIEW 2: equipamentos liberados para reserva (RF09 / RF11) - JOIN + NOT EXISTS
-- Equipamentos com status 'Disponível' e sem manutenção em andamento,
-- com a quantidade de usuários autorizados e de reservas ativas.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW vw_equipamentos_liberados AS
SELECT e.id_equipamento, e.nome AS equipamento, e.categoria, e.requer_autorizacao,
       COUNT(DISTINCT a.id_usuario) AS usuarios_autorizados,
       COUNT(DISTINCT r.id_reserva) AS reservas_ativas
FROM equipamento e
LEFT JOIN autorizacao a ON a.id_equipamento = e.id_equipamento
LEFT JOIN reserva r     ON r.id_equipamento = e.id_equipamento AND r.status = 'Ativa'
WHERE e.status = 'Disponível'
  AND NOT EXISTS (SELECT 1 FROM manutencao m
                   WHERE m.id_equipamento = e.id_equipamento
                     AND m.data_hora_fim IS NULL)
GROUP BY e.id_equipamento, e.nome, e.categoria, e.requer_autorizacao;

-- Consulta da view 2
SELECT * FROM vw_equipamentos_liberados ORDER BY equipamento;