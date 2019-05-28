BEGIN
	DECLARE CURSOR listaAnalises IS
	select QRY.nr_historico_grupo, QRY.cd_projeto, QRY.cd_status, p_.cd_classificacao, e_.cd_municipio, QRY.cd_subgrupo
  from (
      select ig.nr_historico_grupo, ig.cd_projeto, ig.cd_status, iu.nr_historico_usuario, ig.cd_subgrupo
      from inbox_grupo ig
      left join inbox_usuario iu on iu.nr_historico_grupo = ig.nr_historico_grupo
      where ig.cd_subgrupo in
           (1189, 739)
    ) QRY
  join projeto p_ on p_.cd_projeto = QRY.cd_projeto
  join projeto_instalacao pi_ on pi_.cd_projeto = p_.cd_projeto
  join endereco e_ on e_.cd_endereco = pi_.cd_endereco
  where QRY.nr_historico_usuario is null;
    
    cdProjeto Number;
    cdStatus Number;
    nrHistoricoGrupo Number;
    cdClassificacao Number;
    cdMunicipio Number;
    cdSubgrupoNovo Number;
    cdSubgrupoAnterior Number;

	BEGIN
		FOR reg IN listaAnalises LOOP
      
			--atribuir valores as variáveis
			cdProjeto := reg.cd_projeto;
			cdStatus := reg.cd_status;
      nrHistoricoGrupo := reg.nr_historico_grupo;
      cdClassificacao := reg.cd_classificacao;
      cdMunicipio := reg.cd_municipio;
      cdSubgrupoAnterior := reg.cd_subgrupo;
      
      --cdSubgrupoNovo
			select sr.cd_subgrupo 
      INTO cdSubgrupoNovo 
      from subgrupo_regra sr 
      where sr.cd_classificacao = cdClassificacao 
      and sr.cd_status = cdStatus 
      and sr.cd_municipio = cdMunicipio;
      
      --Atualiza o subgrupo do projeto para a nova fila:
      update inbox_grupo ig set ig.cd_subgrupo = cdSubgrupoNovo where ig.nr_historico_grupo = nrHistoricoGrupo;

			--Log
			dbms_output.put_line('nrHistoricoGrupo ID ' || nrHistoricoGrupo || ', atualizado do subgrupo ' || cdSubgrupoAnterior || ' para subgrupo: ' || cdSubgrupoNovo || '.');
      
		End Loop;
    commit; --Commit após final da execução
	END;
END;
