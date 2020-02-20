--Alterar CHARACTER_SET Oracle 11g
--Necessário conectar como SYS no SQLPlus
ALTER SYSTEM ENABLE RESTRICTED SESSION;

ALTER DATABASE CHARACTER SET INTERNAL_USE WE8MSWIN1252;

--Conferir character set configurado na base
SELECT value
FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';

/*
Path regedit (if windows): Computador\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\oracle\KEY_OraClient11g_home1_32bit
or (if x64): Computador\HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE\KEY_OraDb11g_home1
Change NLS_LANG for: AMERICAN_AMERICA.WE8MSWIN1252 
or (for brazilian): BRAZILIAN PORTUGUESE_BRAZIL.WE8MSWIN1252
*/
