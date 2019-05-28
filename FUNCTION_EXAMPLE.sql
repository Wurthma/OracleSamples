BEGIN
	DECLARE CURSOR listaAnalises IS
	select QRY.nr_historico_grupo, QRY.cd_projeto, QRY.cd_status, p_.cd_classificacao, e_.cd_municipio, QRY.cd_subgrupo, gr.cd_tipo_grupo
	from (
	  select ig.nr_historico_grupo, ig.cd_projeto, ig.cd_status, iu.nr_historico_usuario, ig.cd_subgrupo
	  from inbox_grupo ig
	  left join inbox_usuario iu on iu.nr_historico_grupo = ig.nr_historico_grupo
	  where ig.cd_subgrupo in
		   (select sgr_.cd_subgrupo from subgrupo sgr_
			join centro_resultado cer_ on cer_.cd_centro_resultado = sgr_.cd_centro_resultado
			join unidade_negocio uneg_ on uneg_.cd_unidade_negocio = cer_.cd_unidade_negocio
			join grupo gr_ on gr_.cd_grupo = sgr_.cd_grupo
			and uneg_.cd_empresa in (18,126)
			and gr_.cd_tipo_grupo in (12,13))
	) QRY
	join projeto p_ on p_.cd_projeto = QRY.cd_projeto
	join projeto_instalacao pi_ on pi_.cd_projeto = p_.cd_projeto
	join endereco e_ on e_.cd_endereco = pi_.cd_endereco
	join subgrupo sg_ on sg_.cd_subgrupo = QRY.cd_subgrupo
	join grupo gr on gr.cd_grupo = sg_.cd_grupo
	where QRY.nr_historico_usuario is null;
    
    cdProjeto Number;
    cdStatus Number;
    nrHistoricoGrupo Number;
    cdClassificacao Number;
    cdMunicipio Number;
    cdSubgrupoNovo Number;
    cdSubgrupoAnterior Number;
    tipoGrupo Number;
    --vars para armazenar sugrupos novos: GA.VIABILIDADE E GA.PROTEÇÃO:
    sbGaViabilidade Number;
    sbGaProtecao Number;

	BEGIN
		FOR reg IN listaAnalises LOOP
      
			--atribuir valores as variáveis
			cdProjeto := reg.cd_projeto;
			cdStatus := reg.cd_status;
			nrHistoricoGrupo := reg.nr_historico_grupo;
			cdClassificacao := reg.cd_classificacao;
			cdMunicipio := reg.cd_municipio;
			cdSubgrupoAnterior := reg.cd_subgrupo;
			tipoGrupo := reg.cd_tipo_grupo;
      
			--GA.VIABILIDADE E GA.PROTEÇÃO:
			select sg.cd_subgrupo INTO sbGaProtecao from subgrupo sg where sg.ds_subgrupo = 'GA.PROTEÇÃO - RGE';
			select sg.cd_subgrupo INTO sbGaViabilidade from subgrupo sg where sg.ds_subgrupo = 'GA.VIABILIDADE - RGE';

			--Atualiza o subgrupo do projeto para a nova fila:
			IF tipoGrupo = 13 THEN --se PROTEÇÃO
				update inbox_grupo ig set ig.cd_subgrupo = sbGaProtecao where ig.nr_historico_grupo = nrHistoricoGrupo;
				cdSubgrupoNovo := sbGaProtecao;
			ELSE
				update inbox_grupo ig set ig.cd_subgrupo = sbGaViabilidade where ig.nr_historico_grupo = nrHistoricoGrupo;
				cdSubgrupoNovo := sbGaViabilidade;
			END IF;
      

			--Log
			--dbms_output.put_line('nrHistoricoGrupo ID ' || nrHistoricoGrupo || ', atualizado do subgrupo ' || cdSubgrupoAnterior || ' para subgrupo: ' || cdSubgrupoNovo || '.');
      
		End Loop;
    commit; --Commit após final da execução
	END;
END;
