BEGIN
 INSERT INTO MY_TABLE (CODIGO, VALOR, DESCRICAO)
 VALUES(1, 100, 'My Descripition text.');
 EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
END;
/