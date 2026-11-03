
USE fablab_db;


SELECT * FROM Usuario;
SELECT * FROM Equipamento;
SELECT * FROM Reserva;
SELECT * FROM Projeto;


SELECT nome AS nome_usuario, email AS email_contato FROM Usuario;
SELECT nome AS nome_equipamento, status AS situacao_atual FROM Equipamento;


SELECT u.nome, r.data_hora_inicio, r.status FROM Usuario u INNER JOIN Reserva r ON u.id_usuario = r.id_usuario;
SELECT e.nome, a.data_autorizacao FROM Equipamento e INNER JOIN Autorizacao a ON e.id_equipamento = a.id_equipamento;
SELECT p.nome, pu.data_inicio FROM Projeto p INNER JOIN Projeto_Usuario pu ON p.id_projeto = pu.id_projeto;
SELECT e.nome, o.descricao FROM Equipamento e INNER JOIN Ocorrencia o ON e.id_equipamento = o.id_equipamento;
SELECT e.nome, m.descricao_servico FROM Equipamento e INNER JOIN Manutencao m ON e.id_equipamento = m.id_equipamento;

-- (WHERE)
SELECT u.nome AS usuario, e.nome AS equipamento, r.data_hora_inicio FROM Reserva r INNER JOIN Usuario u ON r.id_usuario = u.id_usuario INNER JOIN Equipamento e ON r.id_equipamento = e.id_equipamento WHERE r.status = 'Confirmada';
SELECT u.nome AS usuario, e.nome AS equipamento, a.data_autorizacao FROM Autorizacao a INNER JOIN Usuario u ON a.id_usuario = u.id_usuario INNER JOIN Equipamento e ON a.id_equipamento = e.id_equipamento WHERE e.requer_autorizacao = TRUE;
SELECT p.nome AS projeto, u.nome AS participante, pu.data_inicio FROM Projeto_Usuario pu INNER JOIN Projeto p ON pu.id_projeto = p.id_projeto INNER JOIN Usuario u ON pu.id_usuario = u.id_usuario WHERE p.data_fim IS NULL;
SELECT p.nome AS projeto, m.nome AS material, pm.quantidade FROM Projeto_Material pm INNER JOIN Projeto p ON pm.id_projeto = p.id_projeto INNER JOIN Material m ON pm.id_material = m.id_material WHERE pm.quantidade > 2.00;
SELECT e.nome AS equipamento, o.descricao AS problema, m.descricao_servico AS solucao FROM Manutencao m INNER JOIN Equipamento e ON m.id_equipamento = e.id_equipamento INNER JOIN Ocorrencia o ON m.id_ocorrencia = o.id_ocorrencia WHERE m.data_hora_fim IS NOT NULL;

--  LEFT JOINs
SELECT u.nome AS usuario, r.id_reserva, r.status FROM Usuario u LEFT JOIN Reserva r ON u.id_usuario = r.id_usuario;
SELECT e.nome AS equipamento, o.descricao AS ocorrencia FROM Equipamento e LEFT JOIN Ocorrencia o ON e.id_equipamento = o.id_equipamento;

-- (GROUP BY / HAVING / Funções de Agregação)
SELECT perfil, COUNT(*) AS total_usuarios FROM Usuario GROUP BY perfil;
SELECT e.categoria, COUNT(r.id_reserva) AS total_reservas FROM Equipamento e LEFT JOIN Reserva r ON e.id_equipamento = r.id_equipamento GROUP BY e.categoria;
SELECT p.nome AS projeto, SUM(pm.quantidade) AS total_materiais_usados FROM Projeto p INNER JOIN Projeto_Material pm ON p.id_projeto = pm.id_projeto GROUP BY p.nome HAVING total_materiais_usados > 3.0;

-- (ORDER BY)
SELECT nome, email, data_inclusao FROM Usuario ORDER BY data_inclusao DESC;
SELECT nome, quantidade_disponivel FROM Material ORDER BY quantidade_disponivel ASC;

-- (UNION)
SELECT nome AS item_nome, 'Equipamento' AS tipo FROM Equipamento
UNION
SELECT nome AS item_nome, 'Material' AS tipo FROM Material;

-- (VIEW)
CREATE OR REPLACE VIEW vw_reservas_detalhadas AS
SELECT 
    r.id_reserva,
    u.nome AS usuario,
    u.email,
    e.nome AS equipamento,
    r.data_hora_inicio,
    r.data_hora_fim,
    r.status
FROM Reserva r
INNER JOIN Usuario u ON r.id_usuario = u.id_usuario
INNER JOIN Equipamento e ON r.id_equipamento = e.id_equipamento;

-- Consulta de teste da VIEW
SELECT * FROM vw_reservas_detalhadas;
