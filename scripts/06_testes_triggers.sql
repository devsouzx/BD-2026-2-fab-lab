-- =====================================================================
-- PROJETO FÍSICO - FAB LAB
-- Script 06: testes dos triggers (executar após os scripts 01 a 05)
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1) Triggers de data_inclusao / data_alteracao (USUARIO e EQUIPAMENTO)
-- ---------------------------------------------------------------------
-- T01. INSERT em usuario -> data_inclusao preenchida, data_alteracao vazia
INSERT INTO usuario (id_usuario, nome, email, perfil) VALUES (900, 'Usuário Teste Trigger', 'teste.trigger@fablab.edu.br', 'Estudante');
SELECT id_usuario, nome, data_inclusao, data_alteracao FROM usuario WHERE id_usuario = 900;

-- T02. UPDATE em usuario -> data_alteracao preenchida
UPDATE usuario SET telefone = '62977770000' WHERE id_usuario = 900;
SELECT id_usuario, nome, telefone, data_inclusao, data_alteracao FROM usuario WHERE id_usuario = 900;

-- T03. INSERT em equipamento -> data_inclusao preenchida
INSERT INTO equipamento (id_equipamento, nome, categoria, descricao) VALUES (900, 'Equipamento Teste Trigger', 'Eletrônica', 'Registro de teste');
SELECT id_equipamento, nome, status, data_inclusao, data_alteracao FROM equipamento WHERE id_equipamento = 900;

-- T04. UPDATE em equipamento -> data_alteracao preenchida
UPDATE equipamento SET status = 'Indisponível' WHERE id_equipamento = 900;
SELECT id_equipamento, nome, status, data_inclusao, data_alteracao FROM equipamento WHERE id_equipamento = 900;

-- Limpeza dos registros de teste
DELETE FROM usuario     WHERE id_usuario = 900;
DELETE FROM equipamento WHERE id_equipamento = 900;

-- ---------------------------------------------------------------------
-- 2) Triggers de regras de negócio (cada INSERT abaixo DEVE FALHAR)
--    Execute um de cada vez (o erro interrompe a execução do script).
-- ---------------------------------------------------------------------
-- T05. RF07 - usuário 7 não tem autorização na Cortadora a Laser 9060 (equip. 2)
-- Erro esperado: RF07: usuário sem autorização para este equipamento.
INSERT INTO reserva (id_usuario, id_equipamento, data_hora_inicio, data_hora_fim)
VALUES (7, 2, '2026-11-25 09:00:00', '2026-11-25 11:00:00');

-- T06. RF10 - período sobreposto à reserva 7 (equip. 2, 20/11 09:00-11:00)
-- Erro esperado: RF10: já existe reserva para este equipamento no período.
INSERT INTO reserva (id_usuario, id_equipamento, data_hora_inicio, data_hora_fim)
VALUES (3, 2, '2026-11-20 10:00:00', '2026-11-20 12:00:00');

-- T07. RF11 - Ender 3 (equip. 5) está em manutenção sem data de fim
-- Erro esperado: RF11: equipamento em manutenção no período solicitado.
INSERT INTO reserva (id_usuario, id_equipamento, data_hora_inicio, data_hora_fim)
VALUES (1, 5, '2026-11-22 09:00:00', '2026-11-22 10:00:00');

-- T08. RF07 (utilização) - usuário 7 tenta usar equipamento restrito
-- Erro esperado: RF07: usuário sem autorização para utilizar este equipamento.
INSERT INTO utilizacao (id_usuario, id_equipamento, data_inicio)
VALUES (7, 3, '2026-11-15 15:00:00');

-- T09. CHECK de período inválido (fim antes do início)
-- Erro esperado: new row for relation "reserva" violates check constraint "ck_reserva_periodo"
INSERT INTO reserva (id_usuario, id_equipamento, data_hora_inicio, data_hora_fim)
VALUES (1, 4, '2026-11-25 10:00:00', '2026-11-25 09:00:00');

-- T10. CHECK de domínio do status do equipamento
-- Erro esperado: new row for relation "equipamento" violates check constraint "ck_equipamento_status"
UPDATE equipamento SET status = 'Quebrado' WHERE id_equipamento = 1;