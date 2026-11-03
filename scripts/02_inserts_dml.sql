USE fablab_db;

INSERT INTO Usuario (nome, email, perfil, telefone) VALUES
('João Emanuel Marinho', 'joao@fablab.edu.br', 'Estudante', '62999991111'),
('Mirela Emilly Pereira', 'mirela@fablab.edu.br', 'Estudante', '62999992222'),
('Carlos Henrique Lima', 'carlos@fablab.edu.br', 'Professor', '62999993333'),
('Ana Clara Oliveira', 'ana@fablab.edu.br', 'Pesquisador', '62999994444'),
('Juliana Torres Mendes', 'juliana@fablab.edu.br', 'Visitante', '62999995555'),
('Lucas Pereira Souza', 'lucas@fablab.edu.br', 'Estudante', '62999996666');

INSERT INTO Equipamento (nome, categoria, descricao, requer_autorizacao, status) VALUES
('Impressora 3D Sethi', 'Impressora 3D', 'Impressora FDM de alta precisão', FALSE, 'Disponível'),
('Cortadora a Laser 9060', 'Corte a Laser', 'Cortadora CO2 90W com área de 90x60cm', TRUE, 'Disponível'),
('Fresadora CNC Router', 'Máquina CNC', 'CNC para usinagem de madeira e acrílico', TRUE, 'Em uso'),
('Bancada de Eletrônica', 'Eletrônica', 'Estação de solda com osciloscópio e fonte', FALSE, 'Disponível'),
('Impressora 3D Ender 3', 'Impressora 3D', 'Impressora 3D FDM para prototipagem rápida', FALSE, 'Em manutenção');

INSERT INTO Autorizacao (id_usuario, id_equipamento, data_autorizacao) VALUES
(1, 2, '2026-09-10'),
(2, 3, '2026-08-08'),
(3, 2, '2026-07-15'),
(4, 3, '2026-08-02');

INSERT INTO Reserva (id_usuario, id_equipamento, data_hora_inicio, data_hora_fim, status) VALUES
(1, 2, '2026-11-10 10:00:00', '2026-11-10 12:00:00', 'Confirmada'),
(2, 1, '2026-11-10 13:00:00', '2026-11-10 15:00:00', 'Confirmada'),
(3, 3, '2026-11-11 08:00:00', '2026-11-11 12:00:00', 'Confirmada'),
(4, 4, '2026-11-12 14:00:00', '2026-11-12 16:00:00', 'Concluída'),
(5, 1, '2026-11-13 09:00:00', '2026-11-13 11:00:00', 'Cancelada');

INSERT INTO Projeto (nome, descricao, data_inicio, data_fim) VALUES
('Prótese Personalizada', 'Desenvolvimento de prótese de membro superior em impressão 3D', '2026-09-01', '2026-09-30'),
('Mini Fresadora Didática', 'Desenvolvimento de mini CNC para ensino de robótica', '2026-08-15', '2026-09-20'),
('Estação de Monitoramento', 'Sistema IoT com Arduino e sensores para monitoramento ambiental', '2026-07-01', '2026-10-10');

INSERT INTO Projeto_Usuario (id_projeto, id_usuario, data_inicio) VALUES
(1, 1, '2026-09-01'),
(2, 2, '2026-08-15'),
(2, 6, '2026-08-15'),
(3, 3, '2026-07-01'),
(3, 4, '2026-07-01');

INSERT INTO Projeto_Equipamento (id_projeto, id_equipamento) VALUES
(1, 1),
(2, 3),
(3, 4);

INSERT INTO Material (nome, unidade_medida, quantidade_disponivel) VALUES
('Filamento PLA Preto 1.75mm', 'Kg', 15.50),
('Chapa MDF 6mm 60x90cm', 'Unidade', 40.00),
('Placa de Acrílico 3mm Transparente', 'Unidade', 12.00),
('Placa Arduino Uno', 'Unidade', 8.00),
('Kit Cabos e Conectores Jumper', 'Pacote', 25.00);

INSERT INTO Projeto_Material (id_projeto, id_material, quantidade) VALUES
(1, 1, 2.50),
(2, 2, 4.00),
(2, 3, 2.00),
(3, 4, 1.00),
(3, 5, 3.00);

INSERT INTO Ocorrencia (id_equipamento, data_hora, descricao) VALUES
(5, '2026-10-18 10:15:00', 'Filamento inadequado causou entupimento no bico extrusor.'),
(2, '2026-10-20 14:22:00', 'Lente de corte necessitando de alinhamento e limpeza.');

INSERT INTO Manutencao (id_equipamento, id_ocorrencia, data_hora_inicio, data_hora_fim, descricao_servico) VALUES
(5, 1, '2026-10-18 11:00:00', '2026-10-18 16:45:00', 'Desentupimento e substituição do bico extrusor.'),
(2, 2, '2026-10-20 15:00:00', '2026-10-20 17:00:00', 'Limpeza óptica e alinhamento dos espelhos a laser.');
