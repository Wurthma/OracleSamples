--Alterar CHARACTER_SET Oracle 11g
--Necessário conectar como SYS no SQLPlus
ALTER SYSTEM ENABLE RESTRICTED SESSION;

ALTER DATABASE CHARACTER SET INTERNAL_USE WE8MSWIN1252;

--Conferir character set configurado na base
SELECT value
FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';
