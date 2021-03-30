-- PARTITION TABLES - ORACLE

--https://oracle-base.com/articles/12c/automatic-list-partitioning-12cr2
--DROP TABLE orders PURGE;

--#############################################################################################
--############################### EXEMPLO PRÁTICO #############################################
--#############################################################################################
CREATE TABLE orders
(
  id            NUMBER,
  country_code  VARCHAR2(5),
  customer_id   NUMBER,
  order_date    DATE,
  order_total   NUMBER(8,2),
  CONSTRAINT orders_pk PRIMARY KEY (id)
)
PARTITION BY LIST (country_code) AUTOMATIC
(
  PARTITION part_usa VALUES ('USA'),
  PARTITION part_uk_and_ireland VALUES ('GBR', 'IRL')
);

INSERT INTO orders VALUES (1, 'USA', 10, SYSDATE, 10200.93);
INSERT INTO orders VALUES (2, 'USA', 11, SYSDATE, 948.22);
INSERT INTO orders VALUES (3, 'GBR', 22, SYSDATE, 300.83);
INSERT INTO orders VALUES (4, 'IRL', 43, SYSDATE, 978.43);
COMMIT;

SELECT *
FROM all_tab_partitions
ORDER BY 1, 2;

--Não existente, criará partição automaticamente
INSERT INTO orders VALUES (5, 'BGR', 96, SYSDATE, 2178.43);

--Deletando o novo item de partição 'BGR'
delete from orders where id = 5

--Não existente, criará partição automaticamente
INSERT INTO orders VALUES (6, 'XYZ', 96, SYSDATE, 980.67);

select * from orders;

--To add partitions to non-partitioned table:
--https://docs.oracle.com/en/database/oracle/oracle-database/12.2/vldbg/evolve-nopartition-table.html#GUID-5FDB7D59-DD05-40E4-8AB4-AF82EA0D0FE5

ALTER TABLE orders MODIFY
  PARTITION BY LIST (country_code) AUTOMATIC
  (
    PARTITION part_usa VALUES ('USA'),
    PARTITION part_uk_and_ireland VALUES ('GBR', 'IRL')
    );
/*  (
    PARTITION inicial VALUES (NULL)
  );*/
  
--#############################################################################################
--############################### FIM EXEMPLO #################################################
--#############################################################################################


-- Automatic List Partitioning in Oracle Database 12c Release 2 (12.2)
ALTER TABLE TBL_XYZ_EXPORT MODIFY
  PARTITION BY LIST (ID_EMPRESA, COD_CENARIO_XYZ) AUTOMATIC
  (
            PARTITION inicial VALUES (NULL, NULL)
  );

 
 --Empty partitions performance:
--https://docs.oracle.com/database/121/VLDBG/GUID-54F4E4C9-76AE-43A9-BD13-765359E0A4A3.htm
--http://phil-sqltips.blogspot.com/2015/07/beware-of-empty-partitions.html


SELECT COUNT(*), COD_CENARIO_XYZ, ID_EMPRESA FROM ALCOA_IRPJ.INT_XYZ_LANCAMENTO_IT GROUP BY COD_CENARIO_XYZ, ID_EMPRESA WHERE ROWNUM = 1;
