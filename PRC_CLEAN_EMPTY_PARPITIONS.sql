CREATE OR REPLACE PROCEDURE PRC_CLEAN_EMPTY_PARPITIONS(p_owner in varchar2) AS
BEGIN
  DECLARE
    CURSOR listCommands IS
    --Query para localizar todas partições vazias
      SELECT QRY.SQLCOMMAND,
             QRY.TABLE_OWNER,
             QRY.TABLE_NAME,
             QRY.PARTITION_NAME,
             QRY.ROWS_EXIST
        FROM (WITH t AS (SELECT table_owner,
                                table_name,
                                partition_name,
                                TO_NUMBER(EXTRACTVALUE(XMLTYPE(DBMS_XMLGEN.getxml('SELECT COUNT(*) AS rows_exist FROM ' ||
                                                                                  DBMS_ASSERT.enquote_name(str => table_owner) || '.' ||
                                                                                  DBMS_ASSERT.enquote_name(str => table_name) ||
                                                                                  ' PARTITION (' ||
                                                                                  DBMS_ASSERT.enquote_name(str => partition_name) ||
                                                                                  ') WHERE ROWNUM <= 1')),
                                                       '/ROWSET/ROW/ROWS_EXIST')) AS rows_exist
                           FROM all_tab_partitions
                          WHERE table_owner = p_owner
                          ORDER BY table_owner,
                                   table_name,
                                   partition_position)
               SELECT 'ALTER TABLE ' ||
                      DBMS_ASSERT.enquote_name(str => table_owner) || '.' ||
                      DBMS_ASSERT.enquote_name(str => table_name) ||
                      ' DROP PARTITION ' ||
                      DBMS_ASSERT.enquote_name(str => partition_name) AS SQLCOMMAND,
                      t.*
                 FROM t
                WHERE rows_exist = 0) QRY;
  
  
  BEGIN
    FOR reg IN listCommands LOOP
      EXECUTE IMMEDIATE reg.SQLCOMMAND;
      --Log
      dbms_output.put_line(reg.SQLCOMMAND);
      dbms_output.put_line('Partition delete executed for PARTITION:' ||
                           reg.PARTITION_NAME || ', from TABLE: ' ||
                           reg.TABLE_OWNER || '.' || reg.TABLE_NAME);
    End Loop;
  END;
END;
