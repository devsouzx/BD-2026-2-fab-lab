USE fablab_db;

-- (UPDATE) 
UPDATE Usuario SET telefone = '62988880000' WHERE id_usuario = 1;
UPDATE Equipamento SET status = 'Disponível' WHERE id_equipamento = 3;
UPDATE Autorizacao SET data_autorizacao = '2026-09-15' WHERE id_autorizacao = 1;
UPDATE Reserva SET status = 'Concluída' WHERE id_reserva = 1;
UPDATE Projeto SET data_fim = '2026-10-15' WHERE id_projeto = 3;
UPDATE Projeto_Usuario SET data_inicio = '2026-09-02' WHERE id_projeto = 1 AND id_usuario = 1;
UPDATE Material SET quantidade_disponivel = 18.00 WHERE id_material = 1;
UPDATE Projeto_Material SET quantidade = 3.00 WHERE id_projeto = 1 AND id_material = 1;
UPDATE Ocorrencia SET descricao = 'Falha resolvida após substituição do bico extrusor.' WHERE id_ocorrencia = 1;
UPDATE Manutencao SET descricao_servico = 'Substituição completa do bico e testes de calibração.' WHERE id_manutencao = 1;

-- (DELETE)
DELETE FROM Reserva WHERE id_reserva = 5;
DELETE FROM Projeto_Material WHERE id_projeto = 3 AND id_material = 5;
