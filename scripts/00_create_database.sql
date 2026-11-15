-- =====================================================================
-- PROJETO FÍSICO - FAB LAB (PostgreSQL)
-- Script 00: criação do banco de dados
-- Execute conectado ao banco "postgres" (não pode ser executado dentro
-- do próprio fablab_db). Depois CONECTE-SE ao banco fablab_db
-- (no psql: \c fablab_db | no pgAdmin: selecione fablab_db na árvore
-- e abra um novo Query Tool) e execute os scripts 01 a 06.
-- =====================================================================
DROP DATABASE IF EXISTS fablab_db;
CREATE DATABASE fablab_db;