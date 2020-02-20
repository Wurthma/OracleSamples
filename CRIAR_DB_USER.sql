alter session set "_oracle_script"=true;
CREATE USER NAME_USER IDENTIFIED BY NAME_USER;
GRANT DBA TO NAME_USER;

--Criando tablespaces
CREATE TABLESPACE TBS_DATA DATAFILE 'TBS_DATA.DBF' SIZE 50M AUTOEXTEND ON; -- se necessário criar tablespace (DATA)
CREATE TABLESPACE TBS_INDEX DATAFILE 'TBS_INDEX.DBF' SIZE 50M AUTOEXTEND ON; --se necessário criar tablespace (INDEX)

--acesso aos tablespaces
ALTER USER NAME_USER QUOTA UNLIMITED ON TBS_DATA; 
ALTER USER NAME_USER QUOTA UNLIMITED ON TBS_INDEX;

GRANT EXECUTE ON DBMS_CRYPTO TO NAME_USER;
ALTER USER NAME_USER DEFAULT TABLESPACE TABLESPACE_DATA;

--Grant para debug
GRANT DEBUG ANY PROCEDURE TO NAME_USER;
GRANT DEBUG CONNECT SESSION TO NAME_USER;
