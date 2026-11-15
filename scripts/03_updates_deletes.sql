-- =====================================================================
-- PROJETO FÍSICO - FAB LAB
-- Script 03: UPDATEs e DELETEs (pelo menos um de cada para as 13 tabelas)
-- =====================================================================

-- =====================================================================
-- UPDATES
-- =====================================================================
-- 1. usuario (dispara trigger -> data_alteracao)
UPDATE usuario SET telefone = '62988880000' WHERE id_usuario = 1;

-- 2. equipamento (dispara trigger -> data_alteracao)
UPDATE equipamento SET descricao = 'Impressora FDM de alta precisão, volume de impressão 220x220x250 mm'
 WHERE id_equipamento = 1;

-- 3. autorizacao
UPDATE autorizacao SET data_autorizacao = '2026-09-15' WHERE id_autorizacao = 1;

-- 4. reserva
UPDATE reserva SET data_hora_fim = '2026-11-19 13:00:00' WHERE id_reserva = 8;

-- 5. projeto
UPDATE projeto SET descricao = 'Organizador de ferramentas modular cortado a laser em MDF 6 mm'
 WHERE id_projeto = 5;

-- 6. material
UPDATE material SET quantidade_disponivel = 13.00 WHERE id_material = 1;

-- 7. ocorrencia
UPDATE ocorrencia SET descricao = 'Entupimento do bico extrusor causado por filamento inadequado.'
 WHERE id_ocorrencia = 1;

-- 8. manutencao
UPDATE manutencao SET descricao_servico = 'Desentupimento, substituição do bico extrusor e teste de calibração.'
 WHERE id_manutencao = 1;

-- 9. participacao
UPDATE participacao SET data_inicio = '2026-09-02' WHERE id_usuario = 1 AND id_projeto = 1;

-- 10. consumo_material
UPDATE consumo_material SET quantidade = 3.00 WHERE id_material = 1 AND id_projeto = 1;

-- 11. projeto_equipamento (tabela só com chaves: altera o equipamento usado no projeto 4)
UPDATE projeto_equipamento SET id_equipamento = 6 WHERE id_projeto = 4 AND id_equipamento = 2;

-- 12. utilizacao (encerra o uso em andamento) + libera o equipamento
UPDATE utilizacao SET data_fim = '2026-11-15 11:30:00'
 WHERE id_usuario = 2 AND id_equipamento = 3 AND data_inicio = '2026-11-15 09:00:00';
UPDATE equipamento SET status = 'Disponível' WHERE id_equipamento = 3;

-- 13. manutencao_ocorrencia (corrige o vínculo: a manutenção 4 trata a ocorrência 5, não a 1)
UPDATE manutencao_ocorrencia SET id_ocorrencia = 5 WHERE id_manutencao = 4 AND id_ocorrencia = 1;

-- =====================================================================
-- DELETES (filhos primeiro; nas tabelas-pai remove-se apenas registro sem vínculos)
-- =====================================================================
-- 13. manutencao_ocorrencia
DELETE FROM manutencao_ocorrencia WHERE id_manutencao = 2 AND id_ocorrencia = 2;

-- 12. utilizacao
DELETE FROM utilizacao WHERE id_usuario = 6 AND id_equipamento = 3 AND data_inicio = '2026-09-10 09:00:00';

-- 11. projeto_equipamento
DELETE FROM projeto_equipamento WHERE id_projeto = 4 AND id_equipamento = 1;

-- 10. consumo_material
DELETE FROM consumo_material WHERE id_material = 1 AND id_projeto = 4;

-- 9. participacao
DELETE FROM participacao WHERE id_usuario = 8 AND id_projeto = 1;

-- 8. manutencao (sem vínculo com ocorrência)
DELETE FROM manutencao WHERE id_manutencao = 5;

-- 7. ocorrencia (sem vínculo com manutenção)
DELETE FROM ocorrencia WHERE id_ocorrencia = 4;

-- 6. reserva
DELETE FROM reserva WHERE id_reserva = 5;

-- 5. autorizacao
DELETE FROM autorizacao WHERE id_autorizacao = 6;

-- 4. material
DELETE FROM material WHERE id_material = 7;

-- 3. projeto
DELETE FROM projeto WHERE id_projeto = 6;

-- 2. equipamento
DELETE FROM equipamento WHERE id_equipamento = 8;

-- 1. usuario
DELETE FROM usuario WHERE id_usuario = 9;