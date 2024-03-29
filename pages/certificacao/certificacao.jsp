<%@page import="br.com.citframework.util.Constantes"%>
<%@ taglib uri="/tags/cit" prefix="cit"%>
<%@page import="br.com.centralit.citcorpore.util.WebUtil"%>
<%@page import="br.com.centralit.citcorpore.bean.UsuarioDTO"%>
<%@page import="br.com.citframework.dto.Usuario"%>
<%@ taglib uri="/tags/i18n" prefix="i18n"%>

<!doctype html public "✰">
<html>
<head>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
	String iframe = "";
	iframe = request.getParameter("iframe");
%>
<%@include file="/include/security/security.jsp"%>
<!--<![endif]-->
<title><i18n:message key="citcorpore.comum.title"/></title>
<%@include file="/include/noCache/noCache.jsp"%>
<%@include file="/include/header.jsp"%>
<%@include file="/include/javaScriptsComuns/javaScriptsComuns.jsp"%>

<script>

	var objTab = null;

	addEvent(window, "load", load, false);
	
	function load() {

		document.form.afterRestore = function() {
			$('.tabs').tabs('select', 0);
		}
		
		/*
		* Tratamento para escutar o evento submit
		* que � disparado quando o usu�rio d� enter no campo
		* e ent�o salvar
		*/
		$('#form').submit(function (e) {
			
			e.preventDefault();
			
			document.form.save();
		});
		
		/*
		* Foco no primeiro campo
		*/
		document.form.descricao.focus();
	}

	function limpar() {
		
	   	limparForm();
	   	
	   	limpar_LOOKUP_CERTIFICACOES();
	}
	
	function limparForm() {
		
		document.form.clear();
		
		document.form.descricao.focus();
	}
	
	function LOOKUP_CERTIFICACOES_select(id, desc) {

		document.form.restore({
			idCertificacao : id
		});
	}
	
	function excluir() {
		
		if (document.getElementById("idCertificacao").value != "") {
			
			if (confirm(i18n_message("citcorpore.comum.deleta"))) {
				
				document.form.fireEvent("delete");
			}
		}
	}

</script>

<%//se for chamado por iframe deixa apenas a parte de cadastro da p�gina
			if (iframe != null) {%>
<style>
div#main_container {
	margin: 10px 10px 10px 10px;
}
</style>
<%}%>
</head>
<body>
	<div id="wrapper">
		<%if (iframe == null) {%>
		<%@include file="/include/menu_vertical.jsp"%>
		<%}%>
		<div id="main_container" class="main_container container_16 clearfix">
		<%if (iframe == null) {%>
			<%@include file="/include/menu_horizontal.jsp"%>
			<%}%>

			<div class="flat_area grid_16">
				<h2>
					<i18n:message key="solicitacaoCargo.certificacoes" />
				</h2>
			</div>
			<div class="box grid_16 tabs">
				<ul class="tab_header clearfix">
					<li><a href="#tabs-1"><i18n:message key="solicitacaoCargo.cadastroCertificacao" />
					</a></li>
					<li><a href="#tabs-2" class="round_top"><i18n:message key="solicitacaoCargo.pesquisaCertificacao" />
					</a></li>
				</ul>
				<a href="#" class="toggle">&nbsp;</a>
				<div class="toggle_container">
					<div id="tabs-1" class="block">
						<div class="section">
							<form id='form'
								  name='form'
								  action='<%=CitCorporeConstantes.CAMINHO_SERVIDOR%><%=request.getContextPath()%>/pages/certificacao/certificacao'>
								  
								<input type='hidden' name='idCertificacao' id="idCertificacao" />
								 
								<div class="columns clearfix">
									<div class="col_50">
				               			<fieldset style="height: 70px;">
				             				<label class="campoObrigatorio" for="descricao">
				             					<i18n:message key="citcorpore.comum.descricao" />
				             				</label>
				             				<input class="Valid[Required] Description[citcorpore.comum.descricao]" type='text' name='descricao' size='50' maxlength="100"/>
				               			</fieldset>
				               	    </div>
				               	    <div class="col_100">
				               			<fieldset style="height: 130px;">
				             				<label for="detalhe"><i18n:message key="solicitacaoCargo.detalhamento" /></label>
				             				<textarea name='detalhe' rows="5" cols="100" maxlength="100"></textarea>
				               			</fieldset>
				             		</div>
								</div>
								<br>
								<br>
								<button type='button' name='btnGravar' class="light"
									onclick='document.form.save();'>
									<img
										src="<%=br.com.citframework.util.Constantes.getValue("CONTEXTO_APLICACAO")%>/template_new/images/icons/small/grey/pencil.png">
									<span><i18n:message key="citcorpore.comum.gravar" />
									</span>
								</button>
								<button type='button' name='btnLimpar' class="light"
									onclick='limparForm();'>
									<img
										src="<%=br.com.citframework.util.Constantes.getValue("CONTEXTO_APLICACAO")%>/template_new/images/icons/small/grey/clear.png">
									<span><i18n:message key="citcorpore.comum.limpar" />
									</span>
								</button>
								<button type='button' name='btnExcluir' id="btnExcluir"
									class="light" onclick='excluir();'>
									<img
										src="<%=br.com.citframework.util.Constantes.getValue("CONTEXTO_APLICACAO")%>/template_new/images/icons/small/grey/trashcan.png">
									<span><i18n:message key="citcorpore.comum.excluir" />
									</span>
								</button>
							</form>
						</div>
					</div>
					<div id="tabs-2" class="block">
						<div class="section">
							<i18n:message key="citcorpore.comum.pesquisa" />
							<form name='formPesquisa'>
								<cit:findField formName='formPesquisa'lockupName='LOOKUP_CERTIFICACOES' id='LOOKUP_CERTIFICACOES' top='0'left='0' len='550' heigth='400' javascriptCode='true' htmlCode='true' />
							</form>
						</div>
					</div>
					<!-- ## FIM - AREA DA APLICACAO ## -->
				</div>
			</div>
		</div>
		<!-- Fim da Pagina de Conteudo -->
	</div>
	<%@include file="/include/footer.jsp"%>
</body>
</html>
