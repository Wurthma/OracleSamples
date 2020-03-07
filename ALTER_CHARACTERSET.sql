--Alterar CHARACTER_SET Oracle 11g
--Necessário conectar como SYS no SQLPlus
ALTER SYSTEM ENABLE RESTRICTED SESSION;

ALTER DATABASE CHARACTER SET INTERNAL_USE WE8MSWIN1252;

ALTER SYSTEM DISABLE RESTRICTED SESSION;

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


--Code for alter session NLS_CHARACTERSET to consider CHAR for all columns (VARCHAR2(x CHAR)
--Details: https://pt.stackoverflow.com/a/438855/35358
declare
    v_s_CharacterSet VARCHAR2(160);
begin
    select VALUE
    into v_s_CharacterSet
    from NLS_DATABASE_PARAMETERS
    where PARAMETER = 'NLS_CHARACTERSET';
    if v_s_CharacterSet in ('UTF8', 'AL32UTF8') then
        execute immediate 'alter session set nls_length_semantics=char';
    end if;
end;
