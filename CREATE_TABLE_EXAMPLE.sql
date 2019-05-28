--Criação de tabela exemplo "CLIENTE"
CREATE TABLE cliente(
IDCLIENTE number(10) not null,
NOME varchar2(200) not null,
SOBRENOME varchar2(200),
EMAIL varchar2(100) not null,
DATACADASTRO date,
IDADE number(3),
IDENDERECO,
CONSTRAINT PK_IDCLIENTE PRIMARY KEY(IDCLIENTE),
CONSTRAINT FK_IDENDERECO_CLIENTE
           FOREIGN KEY (IDENDERECO) --nome da coluna da FK na tabela de origem
           REFERENCES ENDEREDO --referencia a tabela endereço
);

comment on table user_owner.cliente is 'Tabela de cliente.';

--Sequence para PK
CREATE SEQUENCE seq_cliente;

--Comentários das colunas da tabela
COMMENT ON COLUMN cliente.IDCLIENTE
is 'PK da tabela cliente.';

COMMENT ON COLUMN cliente.NOME
is 'Nome do cliente.';

COMMENT ON COLUMN cliente.SOBRENOME
is 'Sobrenome do cliente.';


--Grant para alterações da tabela
grant select, update, insert, delete ON user_owner.cliente to other_user;
create public synonym cliente for user_owner.cliente;

--Grant para alterações na sequence
grant select on user_owner.seq_cliente to other_user;
grant alter  on user_owner.seq_cliente to other_user;

create public synonym seq_cliente for user_owner.seq_cliente;
