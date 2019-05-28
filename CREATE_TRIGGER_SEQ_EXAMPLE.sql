create or replace TRIGGER tr_B_I_cliente
 BEFORE INSERT ON cliente                          
 FOR EACH ROW
begin
  if :new.idcliente is null then
    select seq_cliente.nextval
    into   :new.idcliente
    from   dual;
  end if;
end;

