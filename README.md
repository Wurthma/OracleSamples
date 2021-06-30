# Exemplos ORACLE
Exemplos de scripts ORACLE e PL/SQL que uso frequentemente.

1. [CREATE_TABLE_EXAMPLE.sql](CREATE_TABLE_EXAMPLE.sql): 
  Exemplo de criação de tabela com comentário em tabela e colunas, grants para alterações e criação de sinônimo (synonym).

2. [INSERT_ERROR_HANDLE.sql](INSERT_ERROR_HANDLE.sql): 
  Tratamento de exceção para insert de valores duplicados.

3. [IF_EXISTS_SAMPLES.sql](IF_EXISTS_SAMPLES.sql): 
  Verifica se constraint e index existe e, se sim, deleta a mesma antes de criar novamente.
  Verificar se coluna existe antes de fazer o drop.

4. [IF_EXISTS_SAMPLES_2.sql](IF_EXISTS_SAMPLES_2.sql): 
  Faz tratamento de exceção para coluna existente e index existente e não existente.
  Verificar se coluna existe antes de fazer o drop.

5. [CRIAR_DB_USER.sql](CRIAR_DB_USER.sql): 
  Criação de OWNER com exemplos de GRANT.
  Criação de TABLESPACES setando o padrão do owner criado.
  GRANT para depuração.
  
6. [CREATE_TRIGGER_SEQ_EXAMPLE.sql](CREATE_TRIGGER_SEQ_EXAMPLE.sql): 
  Exemplo de TRIGGER para fazer auto incremento em tabela de PK sequencial.

7. [DELETE_DUPLICATES.sql](DELETE_DUPLICATES.sql): 
  Deletar valores duplicados de tabela.

8. [FUNCTION_EXAMPLE.sql](FUNCTION_EXAMPLE.sql): 
  Exemplo básico de function.

9. [FUNCTION_LOOP_EXAMPLE.sql](FUNCTION_LOOP_EXAMPLE.sql): 
  Exemplo de function com LOOP.

10. [GENERATE_DROP_OBJECTS.sql](GENERATE_DROP_OBJECTS.sql): 
  Script para gerar DROP de todos objetos do OWNER (criar filtro caso queira criar para objetos específicos).

11. [SELECT_TABLESPACES.sql](SELECT_TABLESPACES.sql): 
  Query para localizar tablespaces do owner.

12. [ALTER_CHARACTERSET.sql](ALTER_CHARACTERSET.sql): 
  Alteração do CHARACTERSET do ambiente.
  Query para verificar character_set atual.
  
13. [PARTITIONS_EXAMPLES.sql](PARTITIONS_EXAMPLES.sql): 
  Exemplos para criação de partições.

13. [PRC_CLEAN_EMPTY_PARPITIONS.sql](PRC_CLEAN_EMPTY_PARPITIONS.sql): 
  Procedure para limpar partições vazias.
