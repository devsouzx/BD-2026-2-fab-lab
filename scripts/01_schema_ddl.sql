
-- ==========================================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS (DDL)
-- SGBD: MySQL
-- PROJETO: FAB LAB 
-- ==========================================

DROP DATABASE IF EXISTS fablab_db;
CREATE DATABASE fablab_db;
USE fablab_db;

-- 1. Tabela: Usuario
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    perfil VARCHAR(20) NOT NULL,
    telefone VARCHAR(20),
    data_inclusao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_alteracao DATETIME NULL
);

-- 2. Tabela: Equipamento
CREATE TABLE Equipamento (
    id_equipamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    descricao TEXT,
    requer_autorizacao BOOLEAN NOT NULL DEFAULT FALSE,
    status VARCHAR(20) NOT NULL DEFAULT 'Disponível',
    data_inclusao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_alteracao DATETIME NULL
);

-- 3. Tabela: Autorizacao
CREATE TABLE Autorizacao (
    id_autorizacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_equipamento INT NOT NULL,
    data_autorizacao DATE NOT NULL,
    CONSTRAINT fk_autorizacao_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_autorizacao_equipamento FOREIGN KEY (id_equipamento) REFERENCES Equipamento(id_equipamento) ON DELETE CASCADE
);

-- 4. Tabela: Reserva
CREATE TABLE Reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_equipamento INT NOT NULL,
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Confirmada',
    CONSTRAINT fk_reserva_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_reserva_equipamento FOREIGN KEY (id_equipamento) REFERENCES Equipamento(id_equipamento) ON DELETE CASCADE
);

-- 5. Tabela: Projeto
CREATE TABLE Projeto (
    id_projeto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim DATE
);

-- 6. Tabela Associativa: Projeto_Usuario (N:N)
CREATE TABLE Projeto_Usuario (
    id_projeto INT NOT NULL,
    id_usuario INT NOT NULL,
    data_inicio DATE NOT NULL,
    PRIMARY KEY (id_projeto, id_usuario),
    CONSTRAINT fk_pu_projeto FOREIGN KEY (id_projeto) REFERENCES Projeto(id_projeto) ON DELETE CASCADE,
    CONSTRAINT fk_pu_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- 7. Tabela Associativa: Projeto_Equipamento (N:N)
CREATE TABLE Projeto_Equipamento (
    id_projeto INT NOT NULL,
    id_equipamento INT NOT NULL,
    PRIMARY KEY (id_projeto, id_equipamento),
    CONSTRAINT fk_pe_projeto FOREIGN KEY (id_projeto) REFERENCES Projeto(id_projeto) ON DELETE CASCADE,
    CONSTRAINT fk_pe_equipamento FOREIGN KEY (id_equipamento) REFERENCES Equipamento(id_equipamento) ON DELETE CASCADE
);

-- 8. Tabela: Material
CREATE TABLE Material (
    id_material INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    quantidade_disponivel DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

-- 9. Tabela Associativa: Projeto_Material (N:N)
CREATE TABLE Projeto_Material (
    id_projeto INT NOT NULL,
    id_material INT NOT NULL,
    quantidade DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_projeto, id_material),
    CONSTRAINT fk_pm_projeto FOREIGN KEY (id_projeto) REFERENCES Projeto(id_projeto) ON DELETE CASCADE,
    CONSTRAINT fk_pm_material FOREIGN KEY (id_material) REFERENCES Material(id_material) ON DELETE CASCADE
);

-- 10. Tabela: Ocorrencia
CREATE TABLE Ocorrencia (
    id_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_equipamento INT NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descricao TEXT NOT NULL,
    CONSTRAINT fk_ocorrencia_equipamento FOREIGN KEY (id_equipamento) REFERENCES Equipamento(id_equipamento) ON DELETE CASCADE
);

-- 11. Tabela: Manutencao
CREATE TABLE Manutencao (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    id_equipamento INT NOT NULL,
    id_ocorrencia INT NULL,
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim DATETIME NULL,
    descricao_servico TEXT NOT NULL,
    CONSTRAINT fk_manutencao_equipamento FOREIGN KEY (id_equipamento) REFERENCES Equipamento(id_equipamento) ON DELETE CASCADE,
    CONSTRAINT fk_manutencao_ocorrencia FOREIGN KEY (id_ocorrencia) REFERENCES Ocorrencia(id_ocorrencia) ON DELETE SET NULL
);

-- ==========================================
-- TRIGGERS DE ATUALIZAÇÃO AUTOMÁTICA DA DATA
-- Requisito: data_inclusao e data_alteracao
-- ==========================================

DELIMITER //

CREATE TRIGGER trg_atualiza_usuario_data_alteracao
BEFORE UPDATE ON Usuario
FOR EACH ROW
BEGIN
    SET NEW.data_alteracao = CURRENT_TIMESTAMP();
END;
//

CREATE TRIGGER trg_atualiza_equipamento_data_alteracao
BEFORE UPDATE ON Equipamento
FOR EACH ROW
BEGIN
    SET NEW.data_alteracao = CURRENT_TIMESTAMP();
END;
//

DELIMITER ;
