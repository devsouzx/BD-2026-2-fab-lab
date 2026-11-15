-- =====================================================================
-- PROJETO FÍSICO - FAB LAB
-- Script 02 (PostgreSQL): INSERTs (povoamento de todas as 13 tabelas)
-- A ordem respeita as chaves estrangeiras (pais antes dos filhos).
-- =====================================================================

-- 1. USUARIO (os ids 9 em diante são registros usados depois no script 03 - DELETE)
INSERT INTO usuario (nome, email, perfil, telefone) VALUES
('João Emanuel Marinho Sousa',      'joao.sousa@fablab.edu.br',    'Estudante', '62999991111'),
('Mirela Emilly Pereira de Souza',  'mirela.souza@fablab.edu.br',  'Estudante', '62999992222'),
('Carlos Henrique Lima',            'carlos.lima@fablab.edu.br',   'Professor', '62999993333'),
('Ana Clara Oliveira',              'ana.oliveira@fablab.edu.br',  'Professor', '62999994444'),
('Juliana Torres Mendes',           'juliana.mendes@gmail.com',    'Externo',   '62999995555'),
('Lucas Pereira Souza',             'lucas.souza@fablab.edu.br',   'Estudante', '62999996666'),
('Rafael Costa Almeida',            'rafael.almeida@fablab.edu.br','Estudante', NULL),
('Beatriz Nogueira Ramos',          'beatriz.ramos@fablab.edu.br', 'Professor', '62999998888'),
('Cadastro Duplicado Teste',        'duplicado.teste@gmail.com',   'Externo',   NULL);

-- 2. EQUIPAMENTO (id 8 é usado no DELETE do script 03)
INSERT INTO equipamento (nome, categoria, descricao, requer_autorizacao, status) VALUES
('Impressora 3D Sethi',        'Impressora 3D',      'Impressora FDM de alta precisão',                   FALSE, 'Disponível'),
('Cortadora a Laser 9060',     'Cortadora a laser',  'Cortadora CO2 90W com área de 90x60 cm',            TRUE,  'Disponível'),
('Fresadora CNC Router',       'CNC',                'CNC para usinagem de madeira e acrílico',           TRUE,  'Em utilização'),
('Bancada de Eletrônica',      'Eletrônica',         'Estação de solda com osciloscópio e fonte',         FALSE, 'Disponível'),
('Impressora 3D Ender 3',      'Impressora 3D',      'Impressora 3D FDM para prototipagem rápida',        FALSE, 'Em manutenção'),
('Cortadora a Laser Mini 40W', 'Cortadora a laser',  'Cortadora de bancada para gravação e corte leve',   TRUE,  'Disponível'),
('Osciloscópio Digital',       'Eletrônica',         'Osciloscópio de 2 canais - 100 MHz',                FALSE, 'Indisponível'),
('Plotter de Corte (desativada)','Corte de vinil',   'Equipamento desativado do laboratório',             FALSE, 'Indisponível');

-- 3. PROJETO (id 6 é usado no DELETE do script 03)
INSERT INTO projeto (nome, descricao, data_inicio, data_fim) VALUES
('Prótese Personalizada',        'Desenvolvimento de prótese de membro superior em impressão 3D',  '2026-09-01', '2026-09-30'),
('Mini Fresadora Didática',      'Desenvolvimento de mini CNC para ensino de robótica',            '2026-08-15', '2026-09-20'),
('Estação de Monitoramento',     'Sistema IoT com Arduino e sensores para monitoramento ambiental','2026-07-01', NULL),
('Luminária de Acrílico',        'Luminária decorativa com gravação a laser em acrílico',          '2026-10-05', NULL),
('Organizador Modular em MDF',   'Organizador de ferramentas cortado a laser',                     '2026-11-01', NULL),
('Projeto Cancelado Teste',      'Projeto cancelado antes de iniciar',                             '2026-11-02', '2026-11-02');

-- 4. MATERIAL (id 7 é usado no DELETE do script 03)
INSERT INTO material (nome, unidade_medida, quantidade_disponivel) VALUES
('Filamento PLA Preto 1.75mm',          'Kg',      15.50),
('Chapa MDF 6mm 60x90cm',               'Unidade', 40.00),
('Placa de Acrílico 3mm Transparente',  'Unidade', 12.00),
('Placa Arduino Uno',                   'Unidade',  8.00),
('Kit Cabos e Conectores Jumper',       'Pacote',  25.00),
('Filamento PETG Azul 1.75mm',          'Kg',       6.00),
('Cola Instantânea (descontinuada)',    'Unidade',  0.00);

-- 5. AUTORIZACAO (apenas para equipamentos que exigem autorização: 2, 3 e 6)
INSERT INTO autorizacao (id_usuario, id_equipamento, data_autorizacao) VALUES
(1, 2, '2026-09-10'),
(2, 3, '2026-08-08'),
(3, 2, '2026-07-15'),
(4, 3, '2026-08-02'),
(3, 3, '2026-07-20'),
(6, 3, '2026-09-05'),
(8, 6, '2026-10-12');

-- 6. RESERVA (respeita RF07, RF10 e RF11 - os triggers validam cada linha)
INSERT INTO reserva (id_usuario, id_equipamento, data_hora_inicio, data_hora_fim, status) VALUES
(1, 2, '2026-11-10 10:00:00', '2026-11-10 12:00:00', 'Concluída'),
(2, 1, '2026-11-10 13:00:00', '2026-11-10 15:00:00', 'Concluída'),
(3, 3, '2026-11-11 08:00:00', '2026-11-11 12:00:00', 'Concluída'),
(4, 4, '2026-11-12 14:00:00', '2026-11-12 16:00:00', 'Concluída'),
(5, 1, '2026-11-13 09:00:00', '2026-11-13 11:00:00', 'Cancelada'),
(2, 3, '2026-11-18 14:00:00', '2026-11-18 17:00:00', 'Ativa'),
(1, 2, '2026-11-20 09:00:00', '2026-11-20 11:00:00', 'Ativa'),
(6, 1, '2026-11-19 10:00:00', '2026-11-19 12:00:00', 'Ativa'),
(3, 2, '2026-11-20 13:00:00', '2026-11-20 15:00:00', 'Ativa');

-- 7. OCORRENCIA (id 4 é usado no DELETE do script 03)
INSERT INTO ocorrencia (id_equipamento, data_hora, descricao) VALUES
(5, '2026-10-18 10:15:00', 'Filamento inadequado causou entupimento no bico extrusor.'),
(2, '2026-10-20 14:22:00', 'Lente de corte necessitando de alinhamento e limpeza.'),
(3, '2026-11-02 09:40:00', 'Vibração excessiva do eixo Z durante a usinagem.'),
(7, '2026-11-05 16:10:00', 'Tela do osciloscópio sem imagem após ligar o equipamento.'),
(5, '2026-11-13 15:30:00', 'Mesa aquecida não atinge a temperatura configurada.');

-- 8. MANUTENCAO (id 5 é usado no DELETE do script 03)
INSERT INTO manutencao (id_equipamento, data_hora_inicio, data_hora_fim, descricao_servico) VALUES
(5, '2026-10-18 11:00:00', '2026-10-18 16:45:00', 'Desentupimento e substituição do bico extrusor.'),
(2, '2026-10-20 15:00:00', '2026-10-20 17:00:00', 'Limpeza óptica e alinhamento dos espelhos a laser.'),
(3, '2026-11-03 08:00:00', '2026-11-03 12:00:00', 'Lubrificação e reaperto do eixo Z.'),
(5, '2026-11-14 08:00:00', NULL,                  'Revisão geral da mesa aquecida e do termistor (em andamento).'),
(4, '2026-09-15 09:00:00', '2026-09-15 11:00:00', 'Manutenção preventiva da estação de solda.');

-- 9. PARTICIPACAO
INSERT INTO participacao (id_usuario, id_projeto, data_inicio) VALUES
(1, 1, '2026-09-01'),
(8, 1, '2026-09-03'),
(2, 2, '2026-08-15'),
(6, 2, '2026-08-15'),
(3, 3, '2026-07-01'),
(4, 3, '2026-07-01'),
(1, 4, '2026-10-05'),
(5, 4, '2026-10-06');

-- 10. CONSUMO_MATERIAL (id_material, id_projeto, quantidade)
INSERT INTO consumo_material (id_material, id_projeto, quantidade) VALUES
(1, 1, 2.50),
(2, 2, 4.00),
(3, 2, 2.00),
(4, 3, 1.00),
(5, 3, 3.00),
(3, 4, 3.00),
(1, 4, 0.80);

-- 11. PROJETO_EQUIPAMENTO
INSERT INTO projeto_equipamento (id_projeto, id_equipamento) VALUES
(1, 1),
(1, 5),
(2, 3),
(3, 4),
(4, 2),
(4, 1);

-- 12. UTILIZACAO (RF07 também é validado por trigger)
INSERT INTO utilizacao (id_usuario, id_equipamento, data_inicio, data_fim) VALUES
(1, 1, '2026-09-02 10:00:00', '2026-09-02 14:00:00'),
(6, 3, '2026-09-10 09:00:00', '2026-09-10 12:30:00'),
(1, 2, '2026-11-10 10:05:00', '2026-11-10 11:50:00'),
(2, 1, '2026-11-10 13:00:00', '2026-11-10 14:40:00'),
(3, 3, '2026-11-11 08:10:00', '2026-11-11 11:30:00'),
(4, 4, '2026-11-12 14:00:00', '2026-11-12 15:45:00'),
(2, 3, '2026-11-15 09:00:00', NULL);

-- 13. MANUTENCAO_OCORRENCIA (id_manutencao, id_ocorrencia)
INSERT INTO manutencao_ocorrencia (id_manutencao, id_ocorrencia) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1);