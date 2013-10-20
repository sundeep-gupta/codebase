<?php
defined('_JEXEC') OR defined('_VALID_MOS') OR die('...Direct Access to this location is not allowed...');


/**
 * <p>Potuguese language.</p>
 * @copyright (c) 2006 Acajoom Services / All Rights Reserved
 * @author  Ricardo Sim�es <support@ijoobi.com>
 * @version $Id: portuguese.php 442 2007-01-07 11:52:33Z divivo $
 * @link http://www.ijoobi.com
 */

### General ###
 //acajoom Description
define('_ACA_DESC_NEWS', compa::encodeutf('Acajoom � uma ferramenta de listas de mailing, newsletters, auto-respostas, e seguimento, para comunica��o eficaz com os seus utilizadores e clientes. ' .
		'Acajoom, O Seu Parceiro De Comunica��o!'));
define('_ACA_FEATURES', compa::encodeutf('Acajoom, o seu parceiro de comunica��o!'));

// Type of lists
define('_ACA_NEWSLETTER', compa::encodeutf('Newsletter'));
define('_ACA_AUTORESP', compa::encodeutf('Auto-resposta'));
define('_ACA_AUTORSS', compa::encodeutf('Auto-RSS'));
define('_ACA_ECARD', compa::encodeutf('Cart�o Electr�nico'));
define('_ACA_POSTCARD', compa::encodeutf('Cart�o Postal'));
define('_ACA_PERF', compa::encodeutf('Performance'));
define('_ACA_COUPON', compa::encodeutf('Cup�o'));
define('_ACA_CRON', compa::encodeutf('Tarefa Cron'));
define('_ACA_MAILING', compa::encodeutf('Mailing'));
define('_ACA_LIST', compa::encodeutf('Lista'));

 //acajoom Menu
define('_ACA_MENU_LIST', compa::encodeutf('Gest�o de Listas'));
define('_ACA_MENU_SUBSCRIBERS', compa::encodeutf('Assinantes'));
define('_ACA_MENU_NEWSLETTERS', compa::encodeutf('Newsletters'));
define('_ACA_MENU_AUTOS', compa::encodeutf('Auto-Respostas'));
define('_ACA_MENU_COUPONS', compa::encodeutf('Cup�es'));
define('_ACA_MENU_CRONS', compa::encodeutf('Tarefas Cron'));
define('_ACA_MENU_AUTORSS', compa::encodeutf('Auto-RSS'));
define('_ACA_MENU_ECARD', compa::encodeutf('Cart�es Electr�nicos'));
define('_ACA_MENU_POSTCARDS', compa::encodeutf('Cart�es Postais'));
define('_ACA_MENU_PERFS', compa::encodeutf('Performances'));
define('_ACA_MENU_TAB_LIST', compa::encodeutf('Listas'));
define('_ACA_MENU_MAILING_TITLE', compa::encodeutf('Mailings'));
define('_ACA_MENU_MAILING', compa::encodeutf('Mailings para '));
define('_ACA_MENU_STATS', compa::encodeutf('Estat�sticas'));
define('_ACA_MENU_STATS_FOR', compa::encodeutf('Estat�sticas para '));
define('_ACA_MENU_CONF', compa::encodeutf('Configura��o'));
define('_ACA_MENU_UPDATE', compa::encodeutf('Import'));
define('_ACA_MENU_ABOUT', compa::encodeutf('Sobre'));
define('_ACA_MENU_LEARN', compa::encodeutf('Centro de Educa��o'));
define('_ACA_MENU_MEDIA', compa::encodeutf('Gest�o de Media'));
define('_ACA_MENU_HELP', compa::encodeutf('Ajuda'));
define('_ACA_MENU_CPANEL', compa::encodeutf('Painel de Controlo'));
define('_ACA_MENU_IMPORT', compa::encodeutf('Importar'));
define('_ACA_MENU_EXPORT', compa::encodeutf('Exportar'));
define('_ACA_MENU_SUB_ALL', compa::encodeutf('Subcrever Tudo'));
define('_ACA_MENU_UNSUB_ALL', compa::encodeutf('N�o-Subscrever Tudo'));
define('_ACA_MENU_VIEW_ARCHIVE', compa::encodeutf('Arquivo'));
define('_ACA_MENU_PREVIEW', compa::encodeutf('Pr�-visualizar'));
define('_ACA_MENU_SEND', compa::encodeutf('Enviar'));
define('_ACA_MENU_SEND_TEST', compa::encodeutf('Enviar Email de Teste'));
define('_ACA_MENU_SEND_QUEUE', compa::encodeutf('Fila de Processamento'));
define('_ACA_MENU_VIEW', compa::encodeutf('Ver'));
define('_ACA_MENU_COPY', compa::encodeutf('Copiar'));
define('_ACA_MENU_VIEW_STATS', compa::encodeutf('Ver Estado'));
define('_ACA_MENU_CRTL_PANEL', compa::encodeutf(' Painel De Controlo'));
define('_ACA_MENU_LIST_NEW', compa::encodeutf(' Criar Lista'));
define('_ACA_MENU_LIST_EDIT', compa::encodeutf(' Editar Lista'));
define('_ACA_MENU_BACK', compa::encodeutf('Retroceder'));
define('_ACA_MENU_INSTALL', compa::encodeutf('Instalar'));
define('_ACA_MENU_TAB_SUM', compa::encodeutf('Sum�rio'));
define('_ACA_STATUS', compa::encodeutf('Estado'));

// messages
define('_ACA_ERROR', compa::encodeutf(' Ocorreu um erro! '));
define('_ACA_SUB_ACCESS', compa::encodeutf('Direitos de Acesso'));
define('_ACA_DESC_CREDITS', compa::encodeutf('Cr�ditos'));
define('_ACA_DESC_INFO', compa::encodeutf('Informa��o'));
define('_ACA_DESC_HOME', compa::encodeutf('P�gina Oficial'));
define('_ACA_DESC_MAILING', compa::encodeutf('Lista de Mailing'));
define('_ACA_DESC_SUBSCRIBERS', compa::encodeutf('Assinantes'));
define('_ACA_PUBLISHED', compa::encodeutf('Publicado'));
define('_ACA_UNPUBLISHED', compa::encodeutf('N�o-Publicado'));
define('_ACA_DELETE', compa::encodeutf('Apagar'));
define('_ACA_FILTER', compa::encodeutf('Filtrar'));
define('_ACA_UPDATE', compa::encodeutf('Actualizar'));
define('_ACA_SAVE', compa::encodeutf('Salvar'));
define('_ACA_CANCEL', compa::encodeutf('Cancelar'));
define('_ACA_NAME', compa::encodeutf('Nome'));
define('_ACA_EMAIL', compa::encodeutf('E-mail'));
define('_ACA_SELECT', compa::encodeutf('Selecionar'));
define('_ACA_ALL', compa::encodeutf('Todas as'));
define('_ACA_SEND_A', compa::encodeutf('Enviar a '));
define('_ACA_SUCCESS_DELETED', compa::encodeutf(' apagado com sucesso'));
define('_ACA_LIST_ADDED', compa::encodeutf('Lista criada com sucesso'));
define('_ACA_LIST_COPY', compa::encodeutf('Lista copiada com sucesso'));
define('_ACA_LIST_UPDATED', compa::encodeutf('Lista actualizada com sucesso'));
define('_ACA_MAILING_SAVED', compa::encodeutf('Mailing salvado com sucesso.'));
define('_ACA_UPDATED_SUCCESSFULLY', compa::encodeutf('actualizado com sucesso.'));

### Subscribers information ###
//subscribe and unsubscribe info
define('_ACA_SUB_INFO', compa::encodeutf('Informa��o do Assinante'));
define('_ACA_VERIFY_INFO', compa::encodeutf('Por favor verifique o link que submeteu, falta alguma informa��o.'));
define('_ACA_INPUT_NAME', compa::encodeutf('Nome'));
define('_ACA_INPUT_EMAIL', compa::encodeutf('Email'));
define('_ACA_RECEIVE_HTML', compa::encodeutf('Receber em HTML?'));
define('_ACA_TIME_ZONE', compa::encodeutf('Zona de Fuso Hor�rio'));
define('_ACA_BLACK_LIST', compa::encodeutf('Lista Negra'));
define('_ACA_REGISTRATION_DATE', compa::encodeutf('Data de registo do utilizador'));
define('_ACA_USER_ID', compa::encodeutf('ID do Utilizador'));
define('_ACA_DESCRIPTION', compa::encodeutf('Descri��o'));
define('_ACA_ACCOUNT_CONFIRMED', compa::encodeutf('A sua conta foi activada.'));
define('_ACA_SUB_SUBSCRIBER', compa::encodeutf('Assinante'));
define('_ACA_SUB_PUBLISHER', compa::encodeutf('Editor'));
define('_ACA_SUB_ADMIN', compa::encodeutf('Administrador'));
define('_ACA_REGISTERED', compa::encodeutf('Registado'));
define('_ACA_SUBSCRIPTIONS', compa::encodeutf('Subscri��es'));
define('_ACA_SEND_UNSUBCRIBE', compa::encodeutf('Enviar mensagem de Cancelamento de subscri��o'));
define('_ACA_SEND_UNSUBCRIBE_TIPS', compa::encodeutf('Clique SIM para enviar um email de confirma��o para cancelamento de subscri��o.'));
define('_ACA_SUBSCRIBE_SUBJECT_MESS', compa::encodeutf('Por favor confirme a sua subscri��o'));
define('_ACA_UNSUBSCRIBE_SUBJECT_MESS', compa::encodeutf('Confirma��o de Cancelamento de Subscri��o'));
define('_ACA_DEFAULT_SUBSCRIBE_MESS', compa::encodeutf('Ol� [NAME],<br />' .
		'Apenas mais um passo e subscrever� a lista.  Por favor clique no link seguinte para confirmar a sua subscri��o.' .
		'<br /><br />[CONFIRM]<br /><br />Para quest�es � favor contactar o Webmaster.'));
define('_ACA_DEFAULT_UNSUBSCRIBE_MESS', compa::encodeutf('Este � um email de confirma��o de que voc� foi removido da nossa lista.  Lamentamos que tenha decidido cancelar a sua subscri��o, caso queira voltar a subscrever pode sempre faz�-lo no nosso site.  Caso tenha alguma quest�o por favor contacte o nosso Webmaster.'));

// Acajoom subscribers
define('_ACA_SIGNUP_DATE', compa::encodeutf('Data de Subscri��o'));
define('_ACA_CONFIRMED', compa::encodeutf('Confirmado'));
define('_ACA_SUBSCRIB', compa::encodeutf('Subscrever'));
define('_ACA_HTML', compa::encodeutf('Mailings em HTML'));
define('_ACA_RESULTS', compa::encodeutf('Resultados'));
define('_ACA_SEL_LIST', compa::encodeutf('Selecione uma Lista'));
define('_ACA_SEL_LIST_TYPE', compa::encodeutf('- Selecione tipo de Lista -'));
define('_ACA_SUSCRIB_LIST', compa::encodeutf('Lista Total de Assinantes'));
define('_ACA_SUSCRIB_LIST_UNIQUE', compa::encodeutf('assinantes para : '));
define('_ACA_NO_SUSCRIBERS', compa::encodeutf('Nenhum assinante encontrado para estas listas.'));
define('_ACA_COMFIRM_SUBSCRIPTION', compa::encodeutf('Foi enviado um email de confirma��o para si.  Por favor verifique o seu email e clique no link fornecido.<br />' .
		'O seu email necessita de ser confirmado para que a sua subscri��o possa ter efeito.'));
define('_ACA_SUCCESS_ADD_LIST', compa::encodeutf('Voc� foi adicionado a lista com sucesso.'));


 // Subcription info
define('_ACA_CONFIRM_LINK', compa::encodeutf('Clique aqui para confirmar a sua subscri��o'));
define('_ACA_UNSUBSCRIBE_LINK', compa::encodeutf('Clique aqui para remover-se da lista'));
define('_ACA_UNSUBSCRIBE_MESS', compa::encodeutf('O seu email foi removido da lista'));

define('_ACA_QUEUE_SENT_SUCCESS', compa::encodeutf('Todos os mailings agendados foram enviados com sucesso.'));
define('_ACA_MALING_VIEW', compa::encodeutf('Ver todos os mailings'));
define('_ACA_UNSUBSCRIBE_MESSAGE', compa::encodeutf('Tem a certeza que quer remover-se da lista?'));
define('_ACA_MOD_SUBSCRIBE', compa::encodeutf('Subscrever'));
define('_ACA_SUBSCRIBE', compa::encodeutf('Subscrever'));
define('_ACA_UNSUBSCRIBE', compa::encodeutf('Des-Subscrever'));
define('_ACA_VIEW_ARCHIVE', compa::encodeutf('Ver arquivo'));
define('_ACA_SUBSCRIPTION_OR', compa::encodeutf(' ou clique aqui para actualizar a sua informa��o'));
define('_ACA_EMAIL_ALREADY_REGISTERED', compa::encodeutf('Este endere�o de email j� se encontra registado.'));
define('_ACA_SUBSCRIBER_DELETED', compa::encodeutf('Assinante apagado com sucesso.'));


### UserPanel ###
 //User Menu
define('_UCP_USER_PANEL', compa::encodeutf('Painel de Controlo do Utilizador'));
define('_UCP_USER_MENU', compa::encodeutf('Menu do Utilizador'));
define('_UCP_USER_CONTACT', compa::encodeutf('As minhas subscri��es'));
 //Acajoom Cron Menu
define('_UCP_CRON_MENU', compa::encodeutf('Gest�o de tarefa Cron'));
define('_UCP_CRON_NEW_MENU', compa::encodeutf('Novo Cron'));
define('_UCP_CRON_LIST_MENU', compa::encodeutf('Listar o meu Cron'));
 //Acajoom Coupon Menu
define('_UCP_COUPON_MENU', compa::encodeutf('Gest�o de Cup�es'));
define('_UCP_COUPON_LIST_MENU', compa::encodeutf('Lista de Cup�es'));
define('_UCP_COUPON_ADD_MENU', compa::encodeutf('Adicionar um Cup�o'));

### lists ###
// Tabs
define('_ACA_LIST_T_GENERAL', compa::encodeutf('Descri��o'));
define('_ACA_LIST_T_LAYOUT', compa::encodeutf('Layout'));
define('_ACA_LIST_T_SUBSCRIPTION', compa::encodeutf('Subscri��o'));
define('_ACA_LIST_T_SENDER', compa::encodeutf('Informa��o do Remetente'));

define('_ACA_LIST_TYPE', compa::encodeutf('Tipo de Lista'));
define('_ACA_LIST_NAME', compa::encodeutf('Nome da Lista'));
define('_ACA_LIST_ISSUE', compa::encodeutf('Edi��o N #'));
define('_ACA_LIST_DATE', compa::encodeutf('Data de Envio'));
define('_ACA_LIST_SUB', compa::encodeutf('Assunto do Mailing'));
define('_ACA_ATTACHED_FILES', compa::encodeutf('Ficheiros Anexados'));
define('_ACA_SELECT_LIST', compa::encodeutf('Por favor selecione uma lista para editar!'));

// Auto Responder box
define('_ACA_AUTORESP_ON', compa::encodeutf('Tipo de Lista'));
define('_ACA_AUTO_RESP_OPTION', compa::encodeutf('Op��es de Auto-resposta'));
define('_ACA_AUTO_RESP_FREQ', compa::encodeutf('Assinantes podem escolher frequ�ncia'));
define('_ACA_AUTO_DELAY', compa::encodeutf('Atraso (em dias)'));
define('_ACA_AUTO_DAY_MIN', compa::encodeutf('Frequ�ncia M�nima'));
define('_ACA_AUTO_DAY_MAX', compa::encodeutf('Frequ�ncia M�xima'));
define('_ACA_FOLLOW_UP', compa::encodeutf('Especificar seguimento de auto-resposta'));
define('_ACA_AUTO_RESP_TIME', compa::encodeutf('Assinantes podem escolher hora'));
define('_ACA_LIST_SENDER', compa::encodeutf('Remetente da Lista'));

define('_ACA_LIST_DESC', compa::encodeutf('Descri��o da Lista'));
define('_ACA_LAYOUT', compa::encodeutf('Layout'));
define('_ACA_SENDER_NAME', compa::encodeutf('Nome do Remetente'));
define('_ACA_SENDER_EMAIL', compa::encodeutf('Email do Remetente'));
define('_ACA_SENDER_BOUNCE', compa::encodeutf('Endere�o de bounce do Remetente'));
define('_ACA_LIST_DELAY', compa::encodeutf('Atraso'));
define('_ACA_HTML_MAILING', compa::encodeutf('Mailing em HTML?'));
define('_ACA_HTML_MAILING_DESC', compa::encodeutf('(se modificar isto, voc� ter� de salvar e retornar a este ecran para visualizar as mudan�as.)'));
define('_ACA_HIDE_FROM_FRONTEND', compa::encodeutf('Esconder do S�tio-Principal?'));
define('_ACA_SELECT_IMPORT_FILE', compa::encodeutf('Selecione um ficheiro para importa��o'));;
define('_ACA_IMPORT_FINISHED', compa::encodeutf('Importa��o terminada'));
define('_ACA_DELETION_OFFILE', compa::encodeutf('Elimina��o do ficheiro'));
define('_ACA_MANUALLY_DELETE', compa::encodeutf('falhou, dever� apagar o ficheiro manualmente'));
define('_ACA_CANNOT_WRITE_DIR', compa::encodeutf('N�o � poss�vel escrever na directoria'));
define('_ACA_NOT_PUBLISHED', compa::encodeutf('N�o foi poss�vel enviar o mailing, a Lista n�o est� publicada.'));

//  List info box
define('_ACA_INFO_LIST_PUB', compa::encodeutf('Clique em SIM para publicar a Lista'));
define('_ACA_INFO_LIST_NAME', compa::encodeutf('Introduza o nome da sua Lista aqui. Poder� identificar a Lista com este nome.'));
define('_ACA_INFO_LIST_DESC', compa::encodeutf('Introduza uma breve descri��o da sua Lista aqui. Esta descri��o ser� vis�vel aos visitantes no seu site.'));
define('_ACA_INFO_LIST_SENDER_NAME', compa::encodeutf('Introduza o nome do Remetente do mailing. Este nome ser� vis�vel quando os assinantes receberem mensagens desta lista.'));
define('_ACA_INFO_LIST_SENDER_EMAIL', compa::encodeutf('Introduza o endere�o de email de onde as mensagens ser�o enviadas.'));
define('_ACA_INFO_LIST_SENDER_BOUNCED', compa::encodeutf('Introduza o endere�o de email para onde os utilizadores poder�o responder. � altamente recomendado que seja igual ao do remetente, visto que existem filtros de SPAM que poder�o atribuir uma probabilidade de SPAM elevada se forem diferentes.'));
define('_ACA_INFO_LIST_AUTORESP', compa::encodeutf('Escolha o tipo de mailings para esta Lista. <br />' .
		'Newsletter: newsletter normal<br />' .
		'Auto-resposta: uma Auto-resposta � uma Lista que � enviada automaticamente atrav�s da p�gina web em intervalos regulares.'));
define('_ACA_INFO_LIST_FREQUENCY', compa::encodeutf('Permitir aos utilizadores escolher quantas vezes recebem a Lista.  Atribui mais flexibilidade ao utilizador.'));
define('_ACA_INFO_LIST_TIME', compa::encodeutf('Deixar que o utilizador escolha a hora preferida do dia para receber a Lista.'));
define('_ACA_INFO_LIST_MIN_DAY', compa::encodeutf('Definir qual � a frequ�ncia m�nima que o utilizador pode escolher para receber a lista'));
define('_ACA_INFO_LIST_DELAY', compa::encodeutf('Especificar qual o atraso entre esta auto-resposta e a anterior.'));
define('_ACA_INFO_LIST_DATE', compa::encodeutf('Especificar a data para publica��o da lista de not�cias, caso queira atrasar a publica��o. <br /> FORMATO : AAAA-MM-DD HH:MM:SS'));
define('_ACA_INFO_LIST_MAX_DAY', compa::encodeutf('Definir qual � a frequ�ncia m�xima que o utilizador pode escolher para receber a lista'));
define('_ACA_INFO_LIST_LAYOUT', compa::encodeutf('Introduza o layout da sua lista de mailing aqui. Pode introduzir qualquer layou para o seu mailing aqui.'));
define('_ACA_INFO_LIST_SUB_MESS', compa::encodeutf('Esta mensagem ser� enviada ao assinante quando ele ou ela se registam pela primeira vez. Pode definir aqui qualquer texto que goste.'));
define('_ACA_INFO_LIST_UNSUB_MESS', compa::encodeutf('Esta mensagem ser� enviada ao assinante quando ele ou ela cancelarem a subscri��o. Pode inserir aqui qualquer mensagem.'));
define('_ACA_INFO_LIST_HTML', compa::encodeutf('Selecione a checkbox se desejar enviar mailing em HTML. Os assinantes poder�o especificar se preferem receber mensagens em HTML, ou mensagens de apenas texto aquando da subscri��o de uma lista HTML.'));
define('_ACA_INFO_LIST_HIDDEN', compa::encodeutf('Clique SIM para esconder a lista do s�tio-principal, os utilizadores n�o poder�o subscrever mas voc� poder� mesmo assim enviar mailings.'));
define('_ACA_INFO_LIST_ACA_AUTO_SUB', compa::encodeutf('Deseja subscri��o autom�tica dos utilizadores para esta lista?<br /><B>Novos Utilizadores:</B> registar� cada novo utilizador que se registe no site.<br /><B>Todos os Utilizadores:</B> registar� cada utilizador registado na base de dados.<br />(todas aquelas op��es suportam Community Builder)'));
define('_ACA_INFO_LIST_ACC_LEVEL', compa::encodeutf('Selecione o n�vel de acesso do s�tio-principal. Isto mostrar� ou esconder� o mailing para os grupos de utilizadores que n�o t�m acesso a ele, para que n�o sejam capazes do o subscrever.'));
define('_ACA_INFO_LIST_ACC_USER_ID', compa::encodeutf('Selecione o n�vel de acesso do grupo de utilizadores a quem permite edi��o. Esse grupo de utilizadores e superiores ser�o capazes de editar o mailing e envi�-lo, quer do s�tio-principal quer do s�tio de administra��o.'));
define('_ACA_INFO_LIST_FOLLOW_UP', compa::encodeutf('Se quiser que a auto-resposta mova-se para outra assim que atingir a �ltima mensagem, pode especificar aqui a auto-resposta seguinte.'));
define('_ACA_INFO_LIST_ACA_OWNER', compa::encodeutf('Esta � a ID da pessoa que criou a lista.'));
define('_ACA_INFO_LIST_WARNING', compa::encodeutf('   Esta �ltima op��o apenas est� dispon�vel uma vez aquando da cria��o da lista.'));
define('_ACA_INFO_LIST_SUBJET', compa::encodeutf(' Assunto do mailing.  Este � o assunto do email que o assinante receber�.'));
define('_ACA_INFO_MAILING_CONTENT', compa::encodeutf('Este � o corpo do email que voc� quer enviar.'));
define('_ACA_INFO_MAILING_NOHTML', compa::encodeutf('Introduza o corpo do email que voc� quer enviar para os assinantes que escolheram receber apenas mailings N�O-HTML. <BR/> NOTA: se deixar em branco o Acajoom converter� automaticamente o texto HTML para apenas texto.'));
define('_ACA_INFO_MAILING_VISIBLE', compa::encodeutf('Clique SIM para mostrar mailing no s�tio-principal.'));
define('_ACA_INSERT_CONTENT', compa::encodeutf('Insira o conte�do existente'));

// Coupons
define('_ACA_SEND_COUPON_SUCCESS', compa::encodeutf('Cup�o enviado com sucesso!'));
define('_ACA_CHOOSE_COUPON', compa::encodeutf('Escolha um cup�o'));
define('_ACA_TO_USER', compa::encodeutf(' para este utilizador'));

### Cron options
//drop down frequency(CRON)
define('_ACA_FREQ_CH1', compa::encodeutf('Cada hora'));
define('_ACA_FREQ_CH2', compa::encodeutf('Cada 6 horas'));
define('_ACA_FREQ_CH3', compa::encodeutf('Cada 12 horas'));
define('_ACA_FREQ_CH4', compa::encodeutf('Diariamente'));
define('_ACA_FREQ_CH5', compa::encodeutf('Semanalmente'));
define('_ACA_FREQ_CH6', compa::encodeutf('Mensalmente'));
define('_ACA_FREQ_NONE', compa::encodeutf('N�o'));
define('_ACA_FREQ_NEW', compa::encodeutf('Novos utilizadores'));
define('_ACA_FREQ_ALL', compa::encodeutf('Todos os utilizadores'));

//Label CRON form
define('_ACA_LABEL_FREQ', compa::encodeutf('Cron Acajoom?'));
define('_ACA_LABEL_FREQ_TIPS', compa::encodeutf('Clique em SIM se quiser utilizar isto para uma Cron Acajoom, N�O para qualquer outra tarefa Cron.<br />' .
		'Se clicar em SIM n�o necessita de especificar o endere�o do Cron, este ser� automaticamente adicionado.'));
define('_ACA_SITE_URL', compa::encodeutf('O endere�o URL do seu site'));
define('_ACA_CRON_FREQUENCY', compa::encodeutf('Frequ�ncia do Cron'));
define('_ACA_STARTDATE_FREQ', compa::encodeutf('Data de Come�o'));
define('_ACA_LABELDATE_FREQ', compa::encodeutf('Especifique Data'));
define('_ACA_LABELTIME_FREQ', compa::encodeutf('Especifique Hora'));
define('_ACA_CRON_URL', compa::encodeutf('URL do Cron'));
define('_ACA_CRON_FREQ', compa::encodeutf('Frequ�ncia'));
define('_ACA_TITLE_CRONLIST', compa::encodeutf('Lista Cron'));
define('_NEW_LIST', compa::encodeutf('Criar uma nova lista'));

//title CRON form
define('_ACA_TITLE_FREQ', compa::encodeutf('Editar Cron'));
define('_ACA_CRON_SITE_URL', compa::encodeutf('Por favor introduza um endere�o URL v�lido, come�ado por http://'));

### Mailings ###
define('_ACA_MAILING_ALL', compa::encodeutf('Todos os mailings'));
define('_ACA_EDIT_A', compa::encodeutf('Editar um '));
define('_ACA_SELCT_MAILING', compa::encodeutf('Por favor selecione a Lista na caixa de possibilidades com vista a adicionar um novo mailing.'));
define('_ACA_VISIBLE_FRONT', compa::encodeutf('Vis�vel no s�tio-principal'));

// mailer
define('_ACA_SUBJECT', compa::encodeutf('Assunto'));
define('_ACA_CONTENT', compa::encodeutf('Conte�do'));
define('_ACA_NAMEREP', compa::encodeutf('[NAME] = Isto ser� substitu�do pelo nome que o assinante introduziu, voc� estar� a enviar emails personalizados ao usar isto.<br />'));
define('_ACA_FIRST_NAME_REP', compa::encodeutf('[FIRSTNAME] = Isto ser� substitu�do pelo PRIMEIRO nome que o assinante introduziu.<br />'));
define('_ACA_NONHTML', compa::encodeutf('Vers�o N�o-html'));
define('_ACA_ATTACHMENTS', compa::encodeutf('Anexos'));
define('_ACA_SELECT_MULTIPLE', compa::encodeutf('Carregue na tecla CONTROL (ou COMANDO) para selecionar m�ltiplos anexos.<br />' .
		'Os ficheiros apresentados nesta lista de anexos est�o localizados na directoria de anexos, pode alterar esta localiza��o no painel de controlo em Configura��o.'));
define('_ACA_CONTENT_ITEM', compa::encodeutf('Item do Conte�do'));
define('_ACA_SENDING_EMAIL', compa::encodeutf('A enviar email'));
define('_ACA_MESSAGE_NOT', compa::encodeutf('A Mensagem n�o pode ser enviada'));
define('_ACA_MAILER_ERROR', compa::encodeutf('Erro no Mailer'));
define('_ACA_MESSAGE_SENT_SUCCESSFULLY', compa::encodeutf('Mensagem enviada com sucesso'));
define('_ACA_SENDING_TOOK', compa::encodeutf('O envio deste mailing foi de'));
define('_ACA_SECONDS', compa::encodeutf('segundos'));
define('_ACA_NO_ADDRESS_ENTERED', compa::encodeutf('Nenhum assinante ou endere�o de email fornecido'));
define('_ACA_CHANGE_SUBSCRIPTIONS', compa::encodeutf('Modificar'));
define('_ACA_CHANGE_EMAIL_SUBSCRIPTION', compa::encodeutf('Modificar a sua subscri��o'));
define('_ACA_WHICH_EMAIL_TEST', compa::encodeutf('Indique o endere�o de email para enviar um teste ou selecione pr�-visualizar'));
define('_ACA_SEND_IN_HTML', compa::encodeutf('Enviar em HTML (para mailings html)?'));
define('_ACA_VISIBLE', compa::encodeutf('Vis�vel'));
define('_ACA_INTRO_ONLY', compa::encodeutf('Apenas Introdu��o'));

// stats
define('_ACA_GLOBALSTATS', compa::encodeutf('Estat�sticas Globais'));
define('_ACA_DETAILED_STATS', compa::encodeutf('Estat�sticas Detalhadas'));
define('_ACA_MAILING_LIST_DETAILS', compa::encodeutf('Detalhes de Listas'));
define('_ACA_SEND_IN_HTML_FORMAT', compa::encodeutf('Envio em formato HTML'));
define('_ACA_VIEWS_FROM_HTML', compa::encodeutf('Vistos (de emails em html)'));
define('_ACA_SEND_IN_TEXT_FORMAT', compa::encodeutf('Envio em formtato Texto'));
define('_ACA_HTML_READ', compa::encodeutf('Lidos HTML'));
define('_ACA_HTML_UNREAD', compa::encodeutf('N�o-Lidos HTML'));
define('_ACA_TEXT_ONLY_SENT', compa::encodeutf('Apenas Texto'));

// Configuration panel
// main tabs
define('_ACA_MAIL_CONFIG', compa::encodeutf('Mail'));
define('_ACA_LOGGING_CONFIG', compa::encodeutf('Hist. & Estat.'));
define('_ACA_SUBSCRIBER_CONFIG', compa::encodeutf('Assinantes'));
define('_ACA_AUTO_CONFIG', compa::encodeutf('Cron'));
define('_ACA_MISC_CONFIG', compa::encodeutf('Miscel�nea'));
define('_ACA_MAIL_SETTINGS', compa::encodeutf('Defini��es de Mail'));
define('_ACA_MAILINGS_SETTINGS', compa::encodeutf('Defini��es de Mailings'));
define('_ACA_SUBCRIBERS_SETTINGS', compa::encodeutf('Defini��es de Assinantes'));
define('_ACA_CRON_SETTINGS', compa::encodeutf('Defini��es de Cron'));
define('_ACA_SENDING_SETTINGS', compa::encodeutf('Defini��es de Envio'));
define('_ACA_STATS_SETTINGS', compa::encodeutf('Defini��es de Estat�sticas'));
define('_ACA_LOGS_SETTINGS', compa::encodeutf('Defini��es de Hist�ricos'));
define('_ACA_MISC_SETTINGS', compa::encodeutf('Defini��es de Miscel�nea'));
// mail settings
define('_ACA_SEND_MAIL_FROM', compa::encodeutf('Email do remetente<br/>(used as Bounced back for all your messages)'));
define('_ACA_SEND_MAIL_NAME', compa::encodeutf('Nome do remetente'));
define('_ACA_MAILSENDMETHOD', compa::encodeutf('M�todo do Mailer'));
define('_ACA_SENDMAILPATH', compa::encodeutf('Caminho do Sendmail'));
define('_ACA_SMTPHOST', compa::encodeutf('SMTP host'));
define('_ACA_SMTPAUTHREQUIRED', compa::encodeutf('Requer Autentica��o SMTP'));
define('_ACA_SMTPAUTHREQUIRED_TIPS', compa::encodeutf('Selecione SIM se o seu servidor SMTP require autentica��o'));
define('_ACA_SMTPUSERNAME', compa::encodeutf('nome da conta SMTP'));
define('_ACA_SMTPUSERNAME_TIPS', compa::encodeutf('Introduza o nome da conta para o SMTP quando o seu servidor SMTP requerer autentica��o'));
define('_ACA_SMTPPASSWORD', compa::encodeutf('palavra-passe SMTP'));
define('_ACA_SMTPPASSWORD_TIPS', compa::encodeutf('Introduza a palavra-passe para o SMTP quando o seu servidor SMTP requerer autentica��o'));
define('_ACA_USE_EMBEDDED', compa::encodeutf('Usar imagens embebidas'));
define('_ACA_USE_EMBEDDED_TIPS', compa::encodeutf('Selecione SIM se as imagens dos items de conte�do anexo dever�o ser embebidas no email para mensagens em html, ou N�O para usar as tags de imagem por defeito que fazem link para as imagens no site.'));
define('_ACA_UPLOAD_PATH', compa::encodeutf('Caminho de Envio/Anexos'));
define('_ACA_UPLOAD_PATH_TIPS', compa::encodeutf('Pode especificar uma directoria para envio.<br />' .
		'Certifique-se que a directoria que especificar existe, caso contr�rio crie-a.'));

// subscribers settings
define('_ACA_ALLOW_UNREG', compa::encodeutf('Permitir n�o-registados'));
define('_ACA_ALLOW_UNREG_TIPS', compa::encodeutf('Selecione SIM se quiser permitir utilizadores susbcreverem listas sem estarem registados no site.'));
define('_ACA_REQ_CONFIRM', compa::encodeutf('Requerer Confirma��o'));
define('_ACA_REQ_CONFIRM_TIPS', compa::encodeutf('Selecione SIM se quiser obrigar os utilizadores assinantes n�o-registados a confirmar o seu endere�o de email.'));
define('_ACA_SUB_SETTINGS', compa::encodeutf('Defini��es de Subscri��o'));
define('_ACA_SUBMESSAGE', compa::encodeutf('Email de Subscri��o'));
define('_ACA_SUBSCRIBE_LIST', compa::encodeutf('Subscrever uma lista'));

define('_ACA_USABLE_TAGS', compa::encodeutf('Tags utiliz�veis'));
define('_ACA_NAME_AND_CONFIRM', compa::encodeutf('<b>[CONFIRM]</b> = Isto cria um link clic�vel onde o assinante pode confirmar a sua subscri��o. Isto � <strong>obrigat�rio</strong> para que o Acajoom funcione correctamente.<br />'
.'<br />[NAME] = Isto ser� substitu�do pelo nome que o assinante introduziu, estar� a enviar emails personalizados ao usar isto.<br />'
.'<br />[FIRSTNAME] = Isto ser� substitu�do pelo PRIMEIRO nome do assinante, o primeiro nome � DEFINIDO pelo primeiro nome introduzido pelo assinante.<br />'));
define('_ACA_CONFIRMFROMNAME', compa::encodeutf('Confirmar o nome do Remetente'));
define('_ACA_CONFIRMFROMNAME_TIPS', compa::encodeutf('Introduza o nome do remetente a mostrar na confirma��o das listas.'));
define('_ACA_CONFIRMFROMEMAIL', compa::encodeutf('Confirmar o email do remetente'));
define('_ACA_CONFIRMFROMEMAIL_TIPS', compa::encodeutf('Introduza o endere�o de email do remetente a mostrar na confirma��o das listas.'));
define('_ACA_CONFIRMBOUNCE', compa::encodeutf('Endere�o de Bounce'));
define('_ACA_CONFIRMBOUNCE_TIPS', compa::encodeutf('Introduza o endere�o de bounce do remetente a mostrar na confirma��o das listas.'));
define('_ACA_HTML_CONFIRM', compa::encodeutf('Confirmar HTML'));
define('_ACA_HTML_CONFIRM_TIPS', compa::encodeutf('Selecione SIM se as listas de confirma��o devem ser em HTML se o utilizador permitir HTML.'));
define('_ACA_TIME_ZONE_ASK', compa::encodeutf('Perguntar Zona de Fuso Hor�rio'));
define('_ACA_TIME_ZONE_TIPS', compa::encodeutf('Selecione SIM se quiser perguntar ao utilizador qual a sua zona de fuso hor�rio. Quando aplic�vel, os mailings em espera ser�o enviados baseados na zona de fuso hor�rio'));

 // Cron Set up
define('_ACA_TIME_OFFSET_URL', compa::encodeutf('clique aqui para definir a zona de fuso hor�rio no painel de configura��o global do Joomla -> Separador Locale'));
define('_ACA_TIME_OFFSET_TIPS', compa::encodeutf('Defina a zona de fuso hor�rio do seu servidor para que a data e hora guardadas sejam exactas'));
define('_ACA_TIME_OFFSET', compa::encodeutf('Fuso Hor�rio'));
define('_ACA_CRON_TITLE', compa::encodeutf('Definir uma fun��o Con'));
define('_ACA_CRON_DESC', compa::encodeutf('<br />Usar a fun��o Cron automatiza tarefas para o seu site Joomla!<br />' .
		'Para a accionar precisa de adicionar no painel de controlo (separador cron)o seguinte comando:<br />' .
		'<b>' . ACA_JPATH_LIVE . '/index2.php?option=com_acajoom&act=cron</b> ' .
		'<br /><br />Se precisar de ajuda para parametrizar ou tiver problemas por favor consulte o nosso forum <a href="http://www.ijoobi.com" target="_blank">http://www.ijoobi.com</a>'));
// sending settings
define('_ACA_PAUSEX', compa::encodeutf('Pausa x segundos por cada quantidade de emails configurada'));
define('_ACA_PAUSEX_TIPS', compa::encodeutf('Introduza o n�mero de segundos que o Acajoom dar� ao servidor de SMTP para enviar as mensagens antes de proceder a novo envio do grupo seguinte de mensagens.'));
define('_ACA_EMAIL_BET_PAUSE', compa::encodeutf('Emails entre pausas'));
define('_ACA_EMAIL_BET_PAUSE_TIPS', compa::encodeutf('N�mero de emails a enviar antes de fazer pausa.'));
define('_ACA_WAIT_USER_PAUSE', compa::encodeutf('Esperar por ac��o do utilizador numa pausa'));
define('_ACA_WAIT_USER_PAUSE_TIPS', compa::encodeutf('Caso o script deva esperar por ac��o do utilizador quando pausado entre conjuntos de mailings.'));
define('_ACA_SCRIPT_TIMEOUT', compa::encodeutf('Tempo de intervalo do Script'));
define('_ACA_SCRIPT_TIMEOUT_TIPS', compa::encodeutf('N�mero de minutos que o script dever� ter para correr (0 para ilimitados).'));
// Stats settings
define('_ACA_ENABLE_READ_STATS', compa::encodeutf('Activar leitura de estat�sticas'));
define('_ACA_ENABLE_READ_STATS_TIPS', compa::encodeutf('Selecione SIM se quiser guardar no hist�rico o n�mero de visualiza��es. Esta t�cnica s� pode ser usada com mailings em html'));
define('_ACA_LOG_VIEWSPERSUB', compa::encodeutf('Guardar hist�rico de visualiza��es por assinante'));
define('_ACA_LOG_VIEWSPERSUB_TIPS', compa::encodeutf('Selecione SIM se quiser guardar no hist�rico o n�mero de visualiza��es por assinante. Esta t�cnica s� pode ser usada com mailings em html'));
// Logs settings
define('_ACA_DETAILED', compa::encodeutf('Hist�ricos detalhados'));
define('_ACA_SIMPLE', compa::encodeutf('Hist�ricos simplificados'));
define('_ACA_DIAPLAY_LOG', compa::encodeutf('Mostrar hist�ricos'));
define('_ACA_DISPLAY_LOG_TIPS', compa::encodeutf('Selecione SIM se quiser mostrar os hist�ricos enquanto envia mailings.'));
define('_ACA_SEND_PERF_DATA', compa::encodeutf('Envio de performance para fora'));
define('_ACA_SEND_PERF_DATA_TIPS', compa::encodeutf('Selecione SIM se quiser permitir ao Acajoom enviar relat�rios AN�NIMOS sobre a sua configura��o, n�mero de assinantes de uma lista e o tempo que levou e enviar o mailing. Isto d�-nos uma ideia acerca da performance do Acajoom e AJUDA-NOS a melhorar o Acajoom em futuros desenvolvimentos.'));
define('_ACA_SEND_AUTO_LOG', compa::encodeutf('Hist�rico de envio para o Auto-resposta'));
define('_ACA_SEND_AUTO_LOG_TIPS', compa::encodeutf('Selecione SIM se quiser enviar um email com hist�rico cada vez que a fila for processada.  AVISO: isto pode resultar numa grande quantidade de emails.'));
define('_ACA_SEND_LOG', compa::encodeutf('Hist�rico de envio'));
define('_ACA_SEND_LOG_TIPS', compa::encodeutf('Caso deva ser enviado um email com o hist�rico do mailing para o endere�o de email do utilizador que envioou o mailing.'));
define('_ACA_SEND_LOGDETAIL', compa::encodeutf('Detalhe do hist�rico de envio'));
define('_ACA_SEND_LOGDETAIL_TIPS', compa::encodeutf('DETALHADO incl�e a informa��o de sucesso ou falha para cada assinante e um resumo geral da informa��o. SIMPLES apenas envia o resumo geral.'));
define('_ACA_SEND_LOGCLOSED', compa::encodeutf('Enviar hist�rico se a conex�o for fechada'));
define('_ACA_SEND_LOGCLOSED_TIPS', compa::encodeutf('Com esta op��o activada o utilizador que enviou o mailing receber� na mesma o relat�rio por email.'));
define('_ACA_SAVE_LOG', compa::encodeutf('Salvar Hist�rico'));
define('_ACA_SAVE_LOG_TIPS', compa::encodeutf('Caso o hist�rico do mailing deva ser anexado ao ficheiro do hist�rico.'));
define('_ACA_SAVE_LOGDETAIL', compa::encodeutf('Guardar hist�rico detalhado'));
define('_ACA_SAVE_LOGDETAIL_TIPS', compa::encodeutf('DETALHADO incl�e a informa��o de sucesso ou falha para cada assinante e um resumo geral da informa��o. SIMPLES apenas envia o resumo geral.'));
define('_ACA_SAVE_LOGFILE', compa::encodeutf('Salvar ficheiro de Hist�rico'));
define('_ACA_SAVE_LOGFILE_TIPS', compa::encodeutf('Ficheiro ao qual a inform��o de hist�rico ser� anexada. Este ficheiro poder� ficar muito grande.'));
define('_ACA_CLEAR_LOG', compa::encodeutf('Limpar Hist�rico'));
define('_ACA_CLEAR_LOG_TIPS', compa::encodeutf('Limpa o ficheiro de Hist�rico.'));

### control panel
define('_ACA_CP_LAST_QUEUE', compa::encodeutf('�ltima fila executada'));
define('_ACA_CP_TOTAL', compa::encodeutf('Total'));
define('_ACA_MAILING_COPY', compa::encodeutf('Mailing copiado com sucesso!'));

// Miscellaneous settings
define('_ACA_SHOW_GUIDE', compa::encodeutf('Mostrar Guia'));
define('_ACA_SHOW_GUIDE_TIPS', compa::encodeutf('Mostra o Guia no in�cio para ajudar novos utilizadores a criar uma newsletter, uma auto-resposta e parametrizar correctamente o Acajoom.'));
define('_ACA_AUTOS_ON', compa::encodeutf('Usar Auto-respostas'));
define('_ACA_AUTOS_ON_TIPS', compa::encodeutf('Selecione N�O se n�o quiser usar Auto-respostas, todas as op��es de auto-respostas ser�o desactivadas.'));
define('_ACA_NEWS_ON', compa::encodeutf('Usar Newsletters'));
define('_ACA_NEWS_ON_TIPS', compa::encodeutf('Selecione N�O se n�o quiser usar Newsletters, todas as op��es de newsletters ser�o desactivadas.'));
define('_ACA_SHOW_TIPS', compa::encodeutf('Mostrar Dicas'));
define('_ACA_SHOW_TIPS_TIPS', compa::encodeutf('Mostra dicas para ajudar os utilizadores a usar o Acajoom de forma eficaz.'));
define('_ACA_SHOW_FOOTER', compa::encodeutf('Mostrar Rodap�'));
define('_ACA_SHOW_FOOTER_TIPS', compa::encodeutf('Caso deva ou n�o ser mostrado os direitos de c�pia no rodap�.'));
define('_ACA_SHOW_LISTS', compa::encodeutf('Mostrar Listas no s�tio-principal'));
define('_ACA_SHOW_LISTS_TIPS', compa::encodeutf('Quando o utilizador n�o est� registado mostra uma lista das listas que pode subscrever atrav�s de um bot�o de arquivo para as newsletters  ou simplesmente um formul�rio de login para que se possam registar.'));
define('_ACA_CONFIG_UPDATED', compa::encodeutf('Os detalhes da configura��o foram actualizados!'));
define('_ACA_UPDATE_URL', compa::encodeutf('URL de Actualiza��o'));
define('_ACA_UPDATE_URL_WARNING', compa::encodeutf('AVISO! N�o mude este URL a n�o ser que lhe seja pedido para o fazer pela equipa t�cnica do Acajoom.<br />'));
define('_ACA_UPDATE_URL_TIPS', compa::encodeutf('Por exemplo: http://www.ijoobi.com/update/ (inclua a barra no final)'));

// module
define('_ACA_EMAIL_INVALID', compa::encodeutf('O endere�o de email introduzido � inv�lido.'));
define('_ACA_REGISTER_REQUIRED', compa::encodeutf('� necess�rio registar-se primeiro no site para poder ser assinante de uma lista.'));

// Access level box
define('_ACA_OWNER', compa::encodeutf('Criador da Lista:'));
define('_ACA_ACCESS_LEVEL', compa::encodeutf('Definir n�vel de acesso para a lista'));
define('_ACA_ACCESS_LEVEL_OPTION', compa::encodeutf('Op��es de n�vel de acesso'));
define('_ACA_USER_LEVEL_EDIT', compa::encodeutf('Selecione que n�vel de utilizador tem permiss�o para editar um mailing (quer do s�tio-principal quer do s�tio de administra��o) '));

//  drop down options
define('_ACA_AUTO_DAY_CH1', compa::encodeutf('Diariamente'));
define('_ACA_AUTO_DAY_CH2', compa::encodeutf('Diariamente, excepto fim-de-semana'));
define('_ACA_AUTO_DAY_CH3', compa::encodeutf('Dia sim, dia n�o'));
define('_ACA_AUTO_DAY_CH4', compa::encodeutf('Dia sim, dia n�o, excepto fim-de-semana'));
define('_ACA_AUTO_DAY_CH5', compa::encodeutf('Semanalmente'));
define('_ACA_AUTO_DAY_CH6', compa::encodeutf('Bi-semanal'));
define('_ACA_AUTO_DAY_CH7', compa::encodeutf('Mensal'));
define('_ACA_AUTO_DAY_CH9', compa::encodeutf('Anual'));
define('_ACA_AUTO_OPTION_NONE', compa::encodeutf('N�o'));
define('_ACA_AUTO_OPTION_NEW', compa::encodeutf('Novos Utilizadores'));
define('_ACA_AUTO_OPTION_ALL', compa::encodeutf('Todos os Utilizadores'));

//
define('_ACA_UNSUB_MESSAGE', compa::encodeutf('Email para N�o-subscri��o'));
define('_ACA_UNSUB_SETTINGS', compa::encodeutf('Defini��es de N�o-subscri��o'));
define('_ACA_AUTO_ADD_NEW_USERS', compa::encodeutf('Subscri��o autom�tica de Utilizadores?'));

// Update and upgrade messages
define('_ACA_NO_UPDATES', compa::encodeutf('N�o existem actualiza��es dispon�veis de momento.'));
define('_ACA_VERSION', compa::encodeutf('Vers�o Acajoom'));
define('_ACA_NEED_UPDATED', compa::encodeutf('Ficheiros que precisam de ser actualizados:'));
define('_ACA_NEED_ADDED', compa::encodeutf('Ficheiros que precisam de ser adicionados:'));
define('_ACA_NEED_REMOVED', compa::encodeutf('Ficheiros que precisam de ser removidos:'));
define('_ACA_FILENAME', compa::encodeutf('Ficheiro:'));
define('_ACA_CURRENT_VERSION', compa::encodeutf('Vers�o actual:'));
define('_ACA_NEWEST_VERSION', compa::encodeutf('�ltima vers�o:'));
define('_ACA_UPDATING', compa::encodeutf('Actualizando'));
define('_ACA_UPDATE_UPDATED_SUCCESSFULLY', compa::encodeutf('Os ficheiros foram actualizados com sucesso.'));
define('_ACA_UPDATE_FAILED', compa::encodeutf('A Actualiza��o Falhou!'));
define('_ACA_ADDING', compa::encodeutf('Adicionando'));
define('_ACA_ADDED_SUCCESSFULLY', compa::encodeutf('Adicionado com sucesso.'));
define('_ACA_ADDING_FAILED', compa::encodeutf('A Adi��o Falhou!'));
define('_ACA_REMOVING', compa::encodeutf('Removendo'));
define('_ACA_REMOVED_SUCCESSFULLY', compa::encodeutf('Removido com sucesso.'));
define('_ACA_REMOVING_FAILED', compa::encodeutf('A Remo��o Falhou!'));
define('_ACA_INSTALL_DIFFERENT_VERSION', compa::encodeutf('Instale uma vers�o diferente'));
define('_ACA_CONTENT_ADD', compa::encodeutf('Adicionar conte�do'));
define('_ACA_UPGRADE_FROM', compa::encodeutf('Importar dados (newsletters e informa��o de assinantes) de '));
define('_ACA_UPGRADE_MESS', compa::encodeutf('N�o existem riscos para os seus dados existentes. <br /> Este processo simplesmente apenas importa dados para a base de dados do Acajoom.'));
define('_ACA_CONTINUE_SENDING', compa::encodeutf('Continuar e enviar'));

// Acajoom message
define('_ACA_UPGRADE1', compa::encodeutf('Voc� pode facilmente importar os seus utilizadores e newsletters '));
define('_ACA_UPGRADE2', compa::encodeutf(' para o Acajoom no painel de actualiza��es.'));
define('_ACA_UPDATE_MESSAGE', compa::encodeutf('Est� dispon�vel uma nova vers�o do Acajoom! '));
define('_ACA_UPDATE_MESSAGE_LINK', compa::encodeutf('Clique aqui para actualizar!'));
define('_ACA_CRON_SETUP', compa::encodeutf('Para que as auto-respostas sejam enviadas tem de configurar uma tarefa Cron.'));
define('_ACA_THANKYOU', compa::encodeutf('Obrigado por escolher Acajoom, o Seu Parceiro de Comunica��o!'));
define('_ACA_NO_SERVER', compa::encodeutf('Servidor de actualiza��o n�o dispon�vel, por favor verifique mais tarde.'));
define('_ACA_MOD_PUB', compa::encodeutf('O m�dulo Acajoom n�o est� publicado.'));
define('_ACA_MOD_PUB_LINK', compa::encodeutf('Clique aqui para o publicar!'));
define('_ACA_IMPORT_SUCCESS', compa::encodeutf('importado com sucesso'));
define('_ACA_IMPORT_EXIST', compa::encodeutf('assinante j� est� na base de dados'));


// Acajoom\'s Guide
define('_ACA_GUIDE', compa::encodeutf('Assistente'));
define('_ACA_GUIDE_FIRST_ACA_STEP', compa::encodeutf('<p>O Acajoom tem muitas caracteristicas grandiosas e este assistente vai guia-lo atrav�s de um processo de 4 passos f�ceis para que come�e a enviar newsletters e auto-respostas!<p />'));
define('_ACA_GUIDE_FIRST_ACA_STEP_DESC', compa::encodeutf('Primeiro, precisa de adicionar uma lista.  Uma lista pode ser de dois tipos, newsletter ou auto-resposta.' .
		'  Na lista voc� define todos os diferentes par�metros para activar o envio das suas newsletters ou auto-respostas: nome do remetente, layout, mensagem de boas-vindas aos assinantes\' , etc...
<br /><br />Pode criar a sua primeira lista aqui: <a href="index2.php?option=com_acajoom&act=list" >criar uma lista</a> e clicar no bot�o novo.'));
define('_ACA_GUIDE_FIRST_ACA_STEP_UPGRADE', compa::encodeutf('O Acajoom proporciona-lhe uma maneira f�cil de importar toda a informa��o de um sistema pr�vio de newsletter.<br />' .
		' V� ao painel de Actualiza��es e escolha o seu sistema pr�vio de newsletter para importar todas as suas newsletters e assinantes.<br /><br />' .
		'<span style="color:#FF5E00;" >IMPORTANTE: a inmporata��o � LIVRE de risco e n�o afecta de forma alguma a informa��o do seu sistema pr�vio de newsletter</span><br />' .
		'Depois da importa��o ser� capaz de gerir os seus assinantes e mailings directamente a partir do Acajoom.<br /><br />'));
define('_ACA_GUIDE_SECOND_ACA_STEP', compa::encodeutf('Optimo a sua primeira lista est� criada!  Agora pode escrever o seu primeiro %s.  Para criar v� para: '));
define('_ACA_GUIDE_SECOND_ACA_STEP_AUTO', compa::encodeutf('Gest�o de Auto-responder'));
define('_ACA_GUIDE_SECOND_ACA_STEP_NEWS', compa::encodeutf('Gest�o de Newsletters'));
define('_ACA_GUIDE_SECOND_ACA_STEP_FINAL', compa::encodeutf(' e selecione o seu %s. <br /> Depois escolha o seu %s na lista de possibilidades.  Crie o seu primeiro mailing clicando em NOVO '));

define('_ACA_GUIDE_THRID_ACA_STEP_NEWS', compa::encodeutf('Antes de enviar a sua primeira newsletter poder� querer verificar a configura��o de mail.  ' .
		'V� para <a href="index2.php?option=com_acajoom&act=configuration" >P�gina de Configura��o</a> para verificar as defini��es de mail. <br />'));
define('_ACA_GUIDE_THRID2_ACA_STEP_NEWS', compa::encodeutf('<br />Quando estiver pronto retroceda para o Menu Newsletters, selecione o seu mailing e clique em ENVIAR'));

define('_ACA_GUIDE_THRID_ACA_STEP_AUTOS', compa::encodeutf('Para que as suas auto-respostas sejam enviadas necessita que primeiro esteja criada uma tarefa Cron no seu servidor. ' .
		' Por favor refira-se ao separador Cron no painel de configura��o.' .
		' <a href="index2.php?option=com_acajoom&act=configuration" >clique aqui</a> para aparender como criar uma tarefa Cron. <br />'));

define('_ACA_GUIDE_MODULE', compa::encodeutf(' <br />Certifique tamb�m que publicou o m�dulo Acajoom para que as pessoas possam assinar a lista.'));

define('_ACA_GUIDE_FOUR_ACA_STEP_NEWS', compa::encodeutf(' Pode agora criar uma auto-resposta.'));
define('_ACA_GUIDE_FOUR_ACA_STEP_AUTOS', compa::encodeutf(' Pode agora tamb�m criar uma newsletter.'));

define('_ACA_GUIDE_FOUR_ACA_STEP', compa::encodeutf('<p><br />A� est�! Est� agora pronto para comunicar de forma eficaz com os seus visitantes e utilizadores. Este assistente terminar� assim que voc� introduzir um segundo mailing ou ent�o pode desliga-lo no <a href="index2.php?option=com_acajoom&act=configuration" >Painel de Configura��o</a>.' .
		'<br /><br />  Se tiver alguma quest�o enquanto usar o Acajoom, por favor refira-se ao ' .
		'<a target="_blank" href="http://www.ijoobi.com/index.php?option=com_agora&Itemid=60" >forum</a>. ' .
		' Encontrar� tamb�m muita informa��o sobre como comunicar de forma eficaz com os seus assinantes em <a href="http://www.ijoobi.com/" target="_blank" >www.ijoobi.com</a>.' .
		'<p /><br /><b>Obrigado por usar o Acajoom. O Seu Parceiro de Comunica��o!</b> '));
define('_ACA_GUIDE_TURNOFF', compa::encodeutf('O assitente esta agora a ser desligado!'));
define('_ACA_STEP', compa::encodeutf('STEP '));

// Acajoom Install
define('_ACA_INSTALL_CONFIG', compa::encodeutf('Configura��o Acajoom'));
define('_ACA_INSTALL_SUCCESS', compa::encodeutf('Instala��o com Sucesso'));
define('_ACA_INSTALL_ERROR', compa::encodeutf('Erro na instala��o'));
define('_ACA_INSTALL_BOT', compa::encodeutf('Plugin (Bot) Acajoom'));
define('_ACA_INSTALL_MODULE', compa::encodeutf('M�dulo Acajoom'));
//Others
define('_ACA_JAVASCRIPT', compa::encodeutf('!Aviso! Para uma correcta opera��o o Javascript deve estar activado.'));
define('_ACA_EXPORT_TEXT', compa::encodeutf('Os assinantes exportados s�o baseados na lista que escolheu. <br />Exportar assinantes para lista'));
define('_ACA_IMPORT_TIPS', compa::encodeutf('Importar assinantes. A informa��o no ficheiro precisa de ter o seguinte formato: <br />' .
		'Nome,email,recebeHTML(1/0),<span style="color: rgb(255, 0, 0);">confirmado(1/0)</span>'));
define('_ACA_SUBCRIBER_EXIT', compa::encodeutf('j� � assinante'));
define('_ACA_GET_STARTED', compa::encodeutf('Clique aqui para come�ar!'));

//News since 1.0.1
define('_ACA_WARNING_1011', compa::encodeutf('Aviso: 1011: A Actualiza��o n�o funcionar� por causa das restri��es do seu server.'));
define('_ACA_SEND_MAIL_FROM_TIPS', compa::encodeutf('used as Bounced back for all your messages'));
define('_ACA_SEND_MAIL_NAME_TIPS', compa::encodeutf('Escolha que nome se mostrado como remetente.'));
define('_ACA_MAILSENDMETHOD_TIPS', compa::encodeutf('Escolha que mailer deseja usar: PHP mail function, <span>Sendmail</span> ou SMTP Server.'));
define('_ACA_SENDMAILPATH_TIPS', compa::encodeutf('Esta � a directoria do servidor de Mail'));
define('_ACA_LIST_T_TEMPLATE', compa::encodeutf('Tema Padr�o'));
define('_ACA_NO_MAILING_ENTERED', compa::encodeutf('Nenhum mailing fornecido'));
define('_ACA_NO_LIST_ENTERED', compa::encodeutf('Nenhuma lista fornecida'));
define('_ACA_SENT_MAILING', compa::encodeutf('Mailings Enviados'));
define('_ACA_SELECT_FILE', compa::encodeutf('Por favor selecione um ficheiro para '));
define('_ACA_LIST_IMPORT', compa::encodeutf('Verifique a(s) lista(s) que voc� quer que tenha(m) assinantes associados.'));
define('_ACA_PB_QUEUE', compa::encodeutf('Subscriber inserted but problem to connect him/her to the list(s). Please check manually.'));
define('_ACA_UPDATE_MESS', compa::encodeutf(''));
define('_ACA_UPDATE_MESS1', compa::encodeutf('Actualiza��o Altamente Recomendada!'));
define('_ACA_UPDATE_MESS2', compa::encodeutf('Remendo e pequenas correc��es.'));
define('_ACA_UPDATE_MESS3', compa::encodeutf('Novo lan�amento.'));
define('_ACA_UPDATE_MESS5', compa::encodeutf('� obrigat�rio Joomla 1.5 para actualizar.'));
define('_ACA_UPDATE_IS_AVAIL', compa::encodeutf(' est� dispon�vel!'));
define('_ACA_NO_MAILING_SENT', compa::encodeutf('Nenhum mailing enviado!'));
define('_ACA_SHOW_LOGIN', compa::encodeutf('Mostra formul�rio de login'));
define('_ACA_SHOW_LOGIN_TIPS', compa::encodeutf('Selecione SIM para mostrar um formul�rio de login no s�tio-principal do Painel de Controlo do Acajoom para que o utilizador possa registar-se no site.'));
define('_ACA_LISTS_EDITOR', compa::encodeutf('Editor de Descri��o da Lista'));
define('_ACA_LISTS_EDITOR_TIPS', compa::encodeutf('Selecione SIM para usar um editor HTML para editar o campo Descri��o da Lista.'));
define('_ACA_SUBCRIBERS_VIEW', compa::encodeutf('Ver assinantes'));

//News since 1.0.2
define('_ACA_FRONTEND_SETTINGS', compa::encodeutf('Defini�oes do S�tio-Principal'));
define('_ACA_SHOW_LOGOUT', compa::encodeutf('Mostra bot�o de logout'));
define('_ACA_SHOW_LOGOUT_TIPS', compa::encodeutf('Selecione SIM para mostrar um bot�o de logout no front-end do painal de controlo do Acajoom.'));

//News since 1.0.3 CB integration
define('_ACA_CONFIG_INTEGRATION', compa::encodeutf('Integra��o'));
define('_ACA_CB_INTEGRATION', compa::encodeutf('Integra��o com o Community Builder'));
define('_ACA_INSTALL_PLUGIN', compa::encodeutf('Plugin Community Builder (Integra��o Acajoom) '));
define('_ACA_CB_PLUGIN_NOT_INSTALLED', compa::encodeutf('O plugin Acajoom para o Community Builder ainda n�o est� instalado!'));
define('_ACA_CB_PLUGIN', compa::encodeutf('Listas aquando do registo'));
define('_ACA_CB_PLUGIN_TIPS', compa::encodeutf('Selecione SIM para mostrar as listas de mailing no formul�rio de registo do community builder'));
define('_ACA_CB_LISTS', compa::encodeutf('Listas de IDs'));
define('_ACA_CB_LISTS_TIPS', compa::encodeutf('ESTE CAMPO � OBRIGAT�RIO. Introduza o n�mero de ID das listas que voc� quer permitir aos utilizadores assinar separados por v�rgula ,  (0 mostra todas as listas)'));
define('_ACA_CB_INTRO', compa::encodeutf('Texto de Introdu��o'));
define('_ACA_CB_INTRO_TIPS', compa::encodeutf('Um texto aparecer� antes da listagem. DEIXE EM BRANCO PARA N�O MOSTRAR NADA.  Use cb_pretext para layout CSS.'));
define('_ACA_CB_SHOW_NAME', compa::encodeutf('Mostra Nome da Lista'));
define('_ACA_CB_SHOW_NAME_TIPS', compa::encodeutf('Selecione se deve ou n�o mostrar o nome da lista depois da introdu��o.'));
define('_ACA_CB_LIST_DEFAULT', compa::encodeutf('Verifica lista por defeito'));
define('_ACA_CB_LIST_DEFAULT_TIPS', compa::encodeutf('Selecione se quer ou n�o, ter uma caixa de verifica��o para cada lista verificado por defeito.'));
define('_ACA_CB_HTML_SHOW', compa::encodeutf('Mostra Receber HTML'));
define('_ACA_CB_HTML_SHOW_TIPS', compa::encodeutf('Escolha SIM para permitir aos utilizadores decidir se querem ou n�o, receber emails em HTML. Escolha N�O para usar o receber HTML por defeito.'));
define('_ACA_CB_HTML_DEFAULT', compa::encodeutf('Receber HTML por defeito'));
define('_ACA_CB_HTML_DEFAULT_TIPS', compa::encodeutf('Escolha esta op��o para mostrar a configura��o de mail em HTML por defeito. Se o Mostra Receber Html estiver para N�O ent�o esta ser� a op��o por defeitot.'));

// Since 1.0.4
define('_ACA_BACKUP_FAILED', compa::encodeutf('N�o foi poss�vel efectuar a c�pia de seguran�a do ficheiro! O ficheiro n�o foi substitu�do.'));
define('_ACA_BACKUP_YOUR_FILES', compa::encodeutf('Foi efectuada uma c�pia de seguran�a dos ficheiros da vers�o antiga na seguinte direct�ria:'));
define('_ACA_SERVER_LOCAL_TIME', compa::encodeutf('Hora local do Servidor'));
define('_ACA_SHOW_ARCHIVE', compa::encodeutf('Mostrar bot�o de Arquivo'));
define('_ACA_SHOW_ARCHIVE_TIPS', compa::encodeutf('Selecione SIM para mostrar o bot�o de Arquivo no front-end das listas de Newsletter'));
define('_ACA_LIST_OPT_TAG', compa::encodeutf('Tags'));
define('_ACA_LIST_OPT_IMG', compa::encodeutf('Imagens'));
define('_ACA_LIST_OPT_CTT', compa::encodeutf('Conte�do'));
define('_ACA_INPUT_NAME_TIPS', compa::encodeutf('Introduza o seu nome completo (primeiro nome primeiro)'));
define('_ACA_INPUT_EMAIL_TIPS', compa::encodeutf('Introduza o seu endere�o de email (Certifique-se de que este � um endere�o de email v�lido para que possa receber as nossas Newsletters.)'));
define('_ACA_RECEIVE_HTML_TIPS', compa::encodeutf('Escolha SIM se quiser receber mails em HTML - N�O para receber mails em apenas texto'));
define('_ACA_TIME_ZONE_ASK_TIPS', compa::encodeutf('Especifique a sua zona de fuso hor�rio.'));


// Since 1.0.5
define('_ACA_FILES', compa::encodeutf('Ficheiros'));
define('_ACA_FILES_UPLOAD', compa::encodeutf('Envio'));
define('_ACA_MENU_UPLOAD_IMG', compa::encodeutf('Envio de Imagens'));
define('_ACA_TOO_LARGE', compa::encodeutf('Tamanho do ficheiro demasiado grande. O tamanho m�ximo permitido �'));
define('_ACA_MISSING_DIR', compa::encodeutf('O direct�rio de destino n�o existe'));
define('_ACA_IS_NOT_DIR', compa::encodeutf('O direct�rio de destino n�o existe ou � um ficheiro regular.'));
define('_ACA_NO_WRITE_PERMS', compa::encodeutf('O direct�rio de destino n�o tem permiss�o de escrita.'));
define('_ACA_NO_USER_FILE', compa::encodeutf('N�o selecionou nenhum ficheiro para envio.'));
define('_ACA_E_FAIL_MOVE', compa::encodeutf('Imposs�vel mover o ficheiro.'));
define('_ACA_FILE_EXISTS', compa::encodeutf('O ficheiro destino j� existe.'));
define('_ACA_CANNOT_OVERWRITE', compa::encodeutf('O ficheiro destino j� existe e n�o pode ser sobreposto.'));
define('_ACA_NOT_ALLOWED_EXTENSION', compa::encodeutf('Extens�o de ficheiro n�o permitida.'));
define('_ACA_PARTIAL', compa::encodeutf('O ficheiro foi enviado apenas parcialmente.'));
define('_ACA_UPLOAD_ERROR', compa::encodeutf('Erro de envio:'));
define('DEV_NO_DEF_FILE', compa::encodeutf('O ficheiro foi enviado apenas parcialmente.'));
define('_ACA_CONTENTREP', compa::encodeutf('[SUBSCRIPTIONS] = Isto ser� substiu�do pelos links de subscri��o.' .
		' Isto � <strong>obrigat�rio</strong> para que o Acajoom funcione correctamente.<br />' .
		'Se colocar algum outro conte�do nesta caixa o mesmo ser� mostrado em todos os mailings correspondentes a esta Lista.' .
		' <br />Adicione a sua mensagem de subscri��o no final.  O Acajoom adicionar� automaticamente um link para que o assinante altere a informa��o dele, e um link para remover-se da Lista.'));

// since 1.0.6
define('_ACA_NOTIFICATION', compa::encodeutf('Notifica��o'));  // shortcut for Email notification
define('_ACA_NOTIFICATIONS', compa::encodeutf('Notifica��es'));
define('_ACA_USE_SEF', compa::encodeutf('SEF nos mailings'));
define('_ACA_USE_SEF_TIPS', compa::encodeutf('� recomendado que escolha N�O.  No entanto se desejar que o URL inclu�do nos seus mailings use SEF ent�o escolha SIM.' .
		' <br /><b>Os links funcionar�o de igual forma para ambas as op��es.  N�O, assegurar� que os links nos mailings funcionar�o sempre mesmo que altere o seu SEF.</b> '));
define('_ACA_ERR_NB', compa::encodeutf('Erro #: ERR'));
define('_ACA_ERR_SETTINGS', compa::encodeutf('Defini��es de manuseamento de Erros'));
define('_ACA_ERR_SEND', compa::encodeutf('Enviar relat�rio de erros'));
define('_ACA_ERR_SEND_TIPS', compa::encodeutf('Se deseja que o Acajoom seja um produto melhor por favor selecione SIM.  Isto envia-nos um relat�rio de erros.  Por isso nunca mais necessita de reportar bugs ;-) <br /> <b>NENHUMA INFORMA��O PRIVADA � ENVIADA</b>.  N�s nem sequer saberemos a que site perten�e o erro. Apenas enviamos informa��o sobre o Acajoom , a instala��o PHP e queries SQL. '));
define('_ACA_ERR_SHOW_TIPS', compa::encodeutf('Escolha SIM para mostrar o n�mero do erro no ecr�n.  Usado principalmente para efeitos de debuging. '));
define('_ACA_ERR_SHOW', compa::encodeutf('Mostra erros'));
define('_ACA_LIST_SHOW_UNSUBCRIBE', compa::encodeutf('Mostra links de remo��o'));
define('_ACA_LIST_SHOW_UNSUBCRIBE_TIPS', compa::encodeutf('Selecione SIM para mostrar links de remo��o no rodap� dos mailings para que os utilizadores possam mudar as suas subscri��es. <br /> N�O, desactiva os links e rodap�.'));
define('_ACA_UPDATE_INSTALL', compa::encodeutf('<span style="color: rgb(255, 0, 0);">NOT�CIA IMPORTANTE!</span> <br />Se est� a fazer uma actualiza��o a partir de uma vers�o anterior do Acajoom, precisa de actualizar a estrutura da sua base de dados clicando no bot�o seguinte (A sua informa��o ficar� �ntegra)'));
define('_ACA_UPDATE_INSTALL_BTN', compa::encodeutf('Actualizar tabelas e configura��o'));
define('_ACA_MAILING_MAX_TIME', compa::encodeutf('Tempo m�ximo da fila'));
define('_ACA_MAILING_MAX_TIME_TIPS', compa::encodeutf('Define o tempo m�ximo para cada conjunto de emails enviados pela fila. Recomendado entre 30s e 2mins.'));

// virtuemart integration beta
define('_ACA_VM_INTEGRATION', compa::encodeutf('Integra��o com VirtueMart'));
define('_ACA_VM_COUPON_NOTIF', compa::encodeutf('Notifica��o de ID do Cup�o'));
define('_ACA_VM_COUPON_NOTIF_TIPS', compa::encodeutf('Especifica o n�mero de ID do mailing que quiser usar para enviar cup�es para os seus clientes.'));
define('_ACA_VM_NEW_PRODUCT', compa::encodeutf('Notifica��o de ID de novos produtos'));
define('_ACA_VM_NEW_PRODUCT_TIPS', compa::encodeutf('Especifica o n�mero de ID do mailing que quiser usar para enviar notifica��o de novos produtos.'));


// since 1.0.8
// create forms for subscriptions
define('_ACA_FORM_BUTTON', compa::encodeutf('Criar Formul�rio'));
define('_ACA_FORM_COPY', compa::encodeutf('C�digo HTML'));
define('_ACA_FORM_COPY_TIPS', compa::encodeutf('Copie o c�digo HTML gerado para a sua p�gina HTML.'));
define('_ACA_FORM_LIST_TIPS', compa::encodeutf('Selecione a lista que quer incluir neste formul�rio'));
// update messages
define('_ACA_UPDATE_MESS4', compa::encodeutf('N�o pode ser actualizado automaticamente.'));
define('_ACA_WARNG_REMOTE_FILE', compa::encodeutf('N�o h� maneira de conseguir o ficheiro remoto.'));
define('_ACA_ERROR_FETCH', compa::encodeutf('Erro de acesso ao ficheiro.'));

define('_ACA_CHECK', compa::encodeutf('Verificar'));
define('_ACA_MORE_INFO', compa::encodeutf('Mais informa��o'));
define('_ACA_UPDATE_NEW', compa::encodeutf('Actualizar para nova vers�o'));
define('_ACA_UPGRADE', compa::encodeutf('Upgrade para produto mais elevado'));
define('_ACA_DOWNDATE', compa::encodeutf('Voltar a instalar vers�o anterior'));
define('_ACA_DOWNGRADE', compa::encodeutf('Voltar para o produto b�sico'));
define('_ACA_REQUIRE_JOOM', compa::encodeutf('Requere Joomla'));
define('_ACA_TRY_IT', compa::encodeutf('Experimentar!'));
define('_ACA_NEWER', compa::encodeutf('Novo'));
define('_ACA_OLDER', compa::encodeutf('Antigo'));
define('_ACA_CURRENT', compa::encodeutf('Actual'));

// since 1.0.9
define('_ACA_CHECK_COMP', compa::encodeutf('Experimentar um dos outros componentes'));
define('_ACA_MENU_VIDEO', compa::encodeutf('Tutoriais Video'));
define('_ACA_AUTO_SCHEDULE', compa::encodeutf('Temporizador'));
define('_ACA_SCHEDULE_TITLE', compa::encodeutf('Defini��es de fun��es autom�ticas temporizadas'));
define('_ACA_ISSUE_NB_TIPS', compa::encodeutf('Atribuir n�mero automaticamente gerado pelo sistema'));
define('_ACA_SEL_ALL', compa::encodeutf('Todos os mailings'));
define('_ACA_SEL_ALL_SUB', compa::encodeutf('Todas as listas'));
define('_ACA_INTRO_ONLY_TIPS', compa::encodeutf('Se assinalar esta caixa apenas a introdu��o do artigo ser� inserida no mailing com um link LER MAIS para a leitura completa do mesmo no seu site.'));
define('_ACA_TAGS_TITLE', compa::encodeutf('Tag de conte�do'));
define('_ACA_TAGS_TITLE_TIPS', compa::encodeutf('Copie e cole esta tag para o seu mailing, no s�tio onde quer colocar o conte�do.'));
define('_ACA_PREVIEW_EMAIL_TEST', compa::encodeutf('Indica o endere�o de email para onde enviar um teste'));
define('_ACA_PREVIEW_TITLE', compa::encodeutf('Pr�-visualizar'));
define('_ACA_AUTO_UPDATE', compa::encodeutf('Nova notifica��o de actualiza��o'));
define('_ACA_AUTO_UPDATE_TIPS', compa::encodeutf('Selecione SIM se quiser ser notificado de novas actualiza��es para o seu componente. <br />IMPORTANTE!! Mostrar Dicas tem de estar activado para que esta fun��o funcione.'));

// since 1.1.0
define('_ACA_LICENSE', compa::encodeutf('Informa��o de Licenceamento'));


// since 1.1.1
define('_ACA_NEW', compa::encodeutf('Novo'));
define('_ACA_SCHEDULE_SETUP', compa::encodeutf('Para que as auto-respostas sejam enviadas tem de definir uma agenda na configura��o.'));
define('_ACA_SCHEDULER', compa::encodeutf('Agendador'));
define('_ACA_ACAJOOM_CRON_DESC', compa::encodeutf('se n�o tem acesso � administra��o de tarefas cron no seu website, pode registar-se para uma Conta Tarefa Cron Acajoom Gr�tis em:'));
define('_ACA_CRON_DOCUMENTATION', compa::encodeutf('Pode encontrar mais informa��o sobre como definir o Agendador Acajoom no url seguinte:'));
define('_ACA_CRON_DOC_URL', compa::encodeutf('<a href="http://www.ijoobi.com/index.php?option=com_content&view=article&id=4249&catid=29&Itemid=72"
 target="_blank">http://www.ijoobi.com/index.php?option=com_content&Itemid=72&view=category&layout=blog&id=29&limit=60</a>'));
define( '_ACA_QUEUE_PROCESSED', compa::encodeutf('Fila processada com sucesso...'));
define( '_ACA_ERROR_MOVING_UPLOAD', compa::encodeutf('Erro ao mover ficheiro importado'));

//since 1.1.4
define( '_ACA_SCHEDULE_FREQUENCY', compa::encodeutf('Frequ�ncia do Agenda'));
define( '_ACA_CRON_MAX_FREQ', compa::encodeutf('Frequ�ncia M�xima da Agenda'));
define( '_ACA_CRON_MAX_FREQ_TIPS', compa::encodeutf('Especifica a frequ�ncia m�xima que a agenda pode ser executada ( em minutos ).  Isto limitar� a atenda mesmo que a tarefa cron esteja definida com maior frequ�ncia.'));
define( '_ACA_CRON_MAX_EMAIL', compa::encodeutf('M�ximo de emails por tarefa'));
define( '_ACA_CRON_MAX_EMAIL_TIPS', compa::encodeutf('Especifica o n�mero m�ximo de emails enviados por tarefa (0 ilimitados).'));
define( '_ACA_CRON_MINUTES', compa::encodeutf(' minutos'));
define( '_ACA_SHOW_SIGNATURE', compa::encodeutf('Mostra rodap� do email'));
define( '_ACA_SHOW_SIGNATURE_TIPS', compa::encodeutf('Caso queira ou n�o promover o Acajoom no rodap� dos emails.'));
define( '_ACA_QUEUE_AUTO_PROCESSED', compa::encodeutf('Auto-respostas processadas com successo...'));
define( '_ACA_QUEUE_NEWS_PROCESSED', compa::encodeutf('Newsletters agendadas processadas com sucesso...'));
define( '_ACA_MENU_SYNC_USERS', compa::encodeutf('Sincronizar Utilizadores'));
define( '_ACA_SYNC_USERS_SUCCESS', compa::encodeutf('Sincroniza��o de Utilizadores processada com sucesso!'));

// compatibility with Joomla 15
if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', compa::encodeutf('Sair'));
if (!defined('_CMN_YES')) define( '_CMN_YES', compa::encodeutf('Sim'));
if (!defined('_CMN_NO')) define( '_CMN_NO', compa::encodeutf('N�o'));
if (!defined('_HI')) define( '_HI', compa::encodeutf('Ol�'));
if (!defined('_CMN_TOP')) define( '_CMN_TOP', compa::encodeutf('Topo'));
if (!defined('_CMN_BOTTOM')) define( '_CMN_BOTTOM', compa::encodeutf('Fundo'));
//if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', compa::encodeutf('Logout'));

// For include title only or full article in content item tab in newsletter edit - p0stman911
define('_ACA_TITLE_ONLY_TIPS', compa::encodeutf('Se selecionar isto apenas o t�tulo do artigo ser� inserido no mailing como link para o artigo completo no seu site.'));
define('_ACA_TITLE_ONLY', compa::encodeutf('Apenas T�tulo'));
define('_ACA_FULL_ARTICLE_TIPS', compa::encodeutf('Se selecionar isto o artigo completo ser� inserido no mailing'));
define('_ACA_FULL_ARTICLE', compa::encodeutf('Artigo Completo'));
define('_ACA_CONTENT_ITEM_SELECT_T', compa::encodeutf('Selecione um item de conte�do para ser adicionado � mensagem. <br />Copie e cole o<b>content tag</b> para o mailing.  Pode escolher ter a totalidade do texto, apenas introdu��o, ou apenas t�tulo com (0, 1, ou 2 respectivamente). '));
define('_ACA_SUBSCRIBE_LIST2', compa::encodeutf('Lista(s) de Mailing'));

// smart-newsletter function
define('_ACA_AUTONEWS', compa::encodeutf('Smart-Newsletter'));
define('_ACA_MENU_AUTONEWS', compa::encodeutf('Smart-Newsletters'));
define('_ACA_AUTO_NEWS_OPTION', compa::encodeutf('Op��es da Smart-Newsletter'));
define('_ACA_AUTONEWS_FREQ', compa::encodeutf('Frequ�ncia da Newsletter'));
define('_ACA_AUTONEWS_FREQ_TIPS', compa::encodeutf('Especifica a frequ�ncia com que deseja enviar as smart-newsletter.'));
define('_ACA_AUTONEWS_SECTION', compa::encodeutf('Sec��o de Artigos'));
define('_ACA_AUTONEWS_SECTION_TIPS', compa::encodeutf('Especifica a sec��o de que quer escolher os artigos.'));
define('_ACA_AUTONEWS_CAT', compa::encodeutf('Categoria do Artigo'));
define('_ACA_AUTONEWS_CAT_TIPS', compa::encodeutf('Especifica a categoria de que quer escolher os artigos (TODAS para todos os artigos naquela sec��o).'));
define('_ACA_SELECT_SECTION', compa::encodeutf('Selecione sec��o'));
define('_ACA_SELECT_CAT', compa::encodeutf('Todas as Categorias'));
define('_ACA_AUTO_DAY_CH8', compa::encodeutf('Quaternalmente'));
define('_ACA_AUTONEWS_STARTDATE', compa::encodeutf('Data de come�o'));
define('_ACA_AUTONEWS_STARTDATE_TIPS', compa::encodeutf('Especifica a data para come�ar a enviar a Smart Newsletter.'));
define('_ACA_AUTONEWS_TYPE', compa::encodeutf('Renderiza��o do Conte�do'));// how we see the content which is included in the newsletter
define('_ACA_AUTONEWS_TYPE_TIPS', compa::encodeutf('Artigo Completo: will include the entire article in the newsletter.<br />' .
		'Apenas Introdu��o: ser� incluida apenas a introdu��o do artigo na newsletter.<br/>' .
		'Apenas T�tulo: ser� incluido apenas o t�tulo do artigo na newsletter.'));
define('_ACA_TAGS_AUTONEWS', compa::encodeutf('[SMARTNEWSLETTER] = Isto ser� substitu�do pela Smart-newsletter.'));

//since 1.1.3
define('_ACA_MALING_EDIT_VIEW', compa::encodeutf('Create / View Mailings'));
define('_ACA_LICENSE_CONFIG', compa::encodeutf('License'));
define('_ACA_ENTER_LICENSE', compa::encodeutf('Enter license'));
define('_ACA_ENTER_LICENSE_TIPS', compa::encodeutf('Enter your license number and save it.'));
define('_ACA_LICENSE_SETTING', compa::encodeutf('License settings'));
define('_ACA_GOOD_LIC', compa::encodeutf('Your license is valid.'));
define('_ACA_NOTSO_GOOD_LIC', compa::encodeutf('Your license is not valid: '));
define('_ACA_PLEASE_LIC', compa::encodeutf('Please contact Acajoom support to upgrade your license ( license@ijoobi.com ).'));

define('_ACA_DESC_PLUS', compa::encodeutf('Acajoom Plus is the first sequencial auto-responders for Joomla CMS.  ' . _ACA_FEATURES));
define('_ACA_DESC_PRO', compa::encodeutf('Acajoom PRO the ultimate mailing system for Joomla CMS.  ' . _ACA_FEATURES));

//since 1.1.4
define('_ACA_ENTER_TOKEN', compa::encodeutf('Enter token'));
define('_ACA_ENTER_TOKEN_TIPS', compa::encodeutf('Please enter your token number you received by email when you purchased Acajoom. '));
define('_ACA_ACAJOOM_SITE', compa::encodeutf('Acajoom site:'));
define('_ACA_MY_SITE', compa::encodeutf('My site:'));
define( '_ACA_LICENSE_FORM', compa::encodeutf(' ' . 'Click here to go to the license form.</a>'));
define('_ACA_PLEASE_CLEAR_LICENSE', compa::encodeutf('Please clear the license field so it is empty and try again.<br />  If the problem persists, '));
define( '_ACA_LICENSE_SUPPORT', compa::encodeutf('If you still have questions, ' . _ACA_PLEASE_LIC ));
define( '_ACA_LICENSE_TWO', compa::encodeutf('you can get your license manual by entering the token number and site URL (which is highlighted in green at the top of this page) in the License form. '
					. _ACA_LICENSE_FORM . '<br /><br/>' . _ACA_LICENSE_SUPPORT ));
define('_ACA_ENTER_TOKEN_PATIENCE', compa::encodeutf('After saving your token a license will be generated automatically. ' .
		' Usually the token is validated in 2 minutes.  However, in some cases it can take up to 15 minutes.<br />' .
		'<br />Check back this control panel in few minutes.  <br /><br />' .
						'If you didn\'t receive a valid license key in 15 minutes, '. _ACA_LICENSE_TWO));
define( '_ACA_ENTER_NOT_YET', compa::encodeutf('Your token has not yet been validated.'));
define( '_ACA_UPDATE_CLICK_HERE', compa::encodeutf('Pleae visit <a href="http://www.ijoobi.com" target="_blank">www.ijoobi.com</a> to download the newest version.'));
define( '_ACA_NOTIF_UPDATE', compa::encodeutf('To be notified of new updates enter your email address and click subscribe '));

define('_ACA_THINK_PLUS', compa::encodeutf('If you want more out of your mailing system think Plus!'));
define('_ACA_THINK_PLUS_1', compa::encodeutf('Sequential auto-responders'));
define('_ACA_THINK_PLUS_2', compa::encodeutf('Schedule the delivery of your newsletter for a predefined date'));
define('_ACA_THINK_PLUS_3', compa::encodeutf('No more server limitation'));
define('_ACA_THINK_PLUS_4', compa::encodeutf('and much more...'));


//since 1.2.2
define( '_ACA_LIST_ACCESS', compa::encodeutf('List Access'));
define( '_ACA_INFO_LIST_ACCESS', compa::encodeutf('Specify what group of users can view and subscribe to this list'));
define( 'ACA_NO_LIST_PERM', compa::encodeutf('You don\'t have enough permission to subscribe to this list'));

//Archive Configuration
 define('_ACA_MENU_TAB_ARCHIVE', compa::encodeutf('Archive'));
 define('_ACA_MENU_ARCHIVE_ALL', compa::encodeutf('Archive All'));

//Archive Lists
 define('_FREQ_OPT_0', compa::encodeutf('None'));
 define('_FREQ_OPT_1', compa::encodeutf('Every Week'));
 define('_FREQ_OPT_2', compa::encodeutf('Every 2 Weeks'));
 define('_FREQ_OPT_3', compa::encodeutf('Every Month'));
 define('_FREQ_OPT_4', compa::encodeutf('Every Quarter'));
 define('_FREQ_OPT_5', compa::encodeutf('Every Year'));
 define('_FREQ_OPT_6', compa::encodeutf('Other'));

define('_DATE_OPT_1', compa::encodeutf('Created date'));
define('_DATE_OPT_2', compa::encodeutf('Modified date'));

define('_ACA_ARCHIVE_TITLE', compa::encodeutf('Setting up auto-archive frequency'));
define('_ACA_FREQ_TITLE', compa::encodeutf('Archive frequency'));
define('_ACA_FREQ_TOOL', compa::encodeutf('Define how often you want the Archive Manager to arhive your website content.'));
define('_ACA_NB_DAYS', compa::encodeutf('Number of days'));
define('_ACA_NB_DAYS_TOOL', compa::encodeutf('This is only for the Other option! Please specify the number of days between each Archive.'));
define('_ACA_DATE_TITLE', compa::encodeutf('Date type'));
define('_ACA_DATE_TOOL', compa::encodeutf('Define if the archived should be done on the created date or modified date.'));

define('_ACA_MAINTENANCE_TAB', compa::encodeutf('Maintenance settings'));
define('_ACA_MAINTENANCE_FREQ', compa::encodeutf('Maintenance frequency'));
define( '_ACA_MAINTENANCE_FREQ_TIPS', compa::encodeutf('Specify the frequency at which you want the maintenance routine to run.'));
define( '_ACA_CRON_DAYS', compa::encodeutf('hour(s)'));

define( '_ACA_LIST_NOT_AVAIL', compa::encodeutf('There is no list available.'));
define( '_ACA_LIST_ADD_TAB', compa::encodeutf('Add/Edit'));

define( '_ACA_LIST_ACCESS_EDIT', compa::encodeutf('Mailing Add/Edit Access'));
define( '_ACA_INFO_LIST_ACCESS_EDIT', compa::encodeutf('Specify what group of users can add or edit a new mailing for this list'));
define( '_ACA_MAILING_NEW_FRONT', compa::encodeutf('Createa New Mailing'));

define('_ACA_AUTO_ARCHIVE', compa::encodeutf('Auto-Archive'));
define('_ACA_MENU_ARCHIVE', compa::encodeutf('Auto-Archive'));

//Extra tags:
define('_ACA_TAGS_ISSUE_NB', compa::encodeutf('[ISSUENB] = This will be replaced by the issue number of  the newsletter.'));
define('_ACA_TAGS_DATE', compa::encodeutf('[DATE] = This will be replaced by the sent date.'));
define('_ACA_TAGS_CB', compa::encodeutf('[CBTAG:{field_name}] = This will be replaced by the value taken from the Community Builder field: eg. [CBTAG:firstname] '));
define( '_ACA_MAINTENANCE', compa::encodeutf('Joobi Care'));


define('_ACA_THINK_PRO', compa::encodeutf('When you have professional needs, you use professional components!'));
define('_ACA_THINK_PRO_1', compa::encodeutf('Smart-Newsletters'));
define('_ACA_THINK_PRO_2', compa::encodeutf('Define access level for your list'));
define('_ACA_THINK_PRO_3', compa::encodeutf('Define who can edit/add mailings'));
define('_ACA_THINK_PRO_4', compa::encodeutf('More tags: add your CB fields'));
define('_ACA_THINK_PRO_5', compa::encodeutf('Joomla contents Auto-archive'));
define('_ACA_THINK_PRO_6', compa::encodeutf('Database optimization'));

define('_ACA_LIC_NOT_YET', compa::encodeutf('Your license is not yet valid.  Please check the license Tab in the configuration panel.'));
define('_ACA_PLEASE_LIC_GREEN', compa::encodeutf('Make sure to provide the green information at the top of the tab to our support team.'));

define('_ACA_FOLLOW_LINK', compa::encodeutf('Get Your License'));
define( '_ACA_FOLLOW_LINK_TWO', compa::encodeutf('You can get your license by entering the token number and site URL (which is highlighted in green at the top of this page) in the License form. '));
define( '_ACA_ENTER_TOKEN_TIPS2', compa::encodeutf(' Then click on Apply button in the top right menu.'));
define( '_ACA_ENTER_LIC_NB', compa::encodeutf('Enter your License'));
define( '_ACA_UPGRADE_LICENSE', compa::encodeutf('Upgrade Your License'));
define( '_ACA_UPGRADE_LICENSE_TIPS', compa::encodeutf('If you received a token to upgrade your license please enter it here, click Apply and proceed to number <b>2</b> to get your new license number.'));

define( '_ACA_MAIL_FORMAT', compa::encodeutf('Encoding format'));
define( '_ACA_MAIL_FORMAT_TIPS', compa::encodeutf('What format do you want to use for encoding your mailings, Text only or MIME'));
define( '_ACA_ACAJOOM_CRON_DESC_ALT', compa::encodeutf('If you do not have access to a cron task manager on your website, you can use the Free jCron component to create a cron task from your website.'));

//since 1.3.1
define('_ACA_SHOW_AUTHOR', compa::encodeutf('Show Author\'s Name'));
define('_ACA_SHOW_AUTHOR_TIPS', compa::encodeutf('Select Yes if you want to add the name of the author when you add an article in the Mailing'));

//since 1.3.5
define('_ACA_REGWARN_NAME', compa::encodeutf('Por favor, informe seu nome.'));
define('_ACA_REGWARN_MAIL', compa::encodeutf('Por favor, informe um endere�o de e-mail v�lido.'));

//since 1.5.6
define('_ACA_ADDEMAILREDLINK_TIPS', compa::encodeutf('If you select Yes, the e-mail of the user will be added as a parameter at the end of your redirect URL (the redirect link for your module or for an external Acajoom form).<br/>That can be useful if you want to execute a special script in your redirect page.'));
define('_ACA_ADDEMAILREDLINK', compa::encodeutf('Add e-mail to the redirect link'));

//since 1.6.3
define('_ACA_ITEMID', compa::encodeutf('ItemId'));
define('_ACA_ITEMID_TIPS', compa::encodeutf('This ItemId will be added to your Acajoom links.'));

//since 1.6.5
define('_ACA_SHOW_JCALPRO', compa::encodeutf('jCalPRO'));
define('_ACA_SHOW_JCALPRO_TIPS', compa::encodeutf('Show the integration tab for jCalPRO <br/>(only if jCalPRO is installed on your website!)'));
define('_ACA_JCALTAGS_TITLE', compa::encodeutf('jCalPRO Tag:'));
define('_ACA_JCALTAGS_TITLE_TIPS', compa::encodeutf('Copy and paste this tag into the mailing where you want to have the event to be placed.'));
define('_ACA_JCALTAGS_DESC', compa::encodeutf('Description:'));
define('_ACA_JCALTAGS_DESC_TIPS', compa::encodeutf('Select Yes if you want to insert the description of the event'));
define('_ACA_JCALTAGS_START', compa::encodeutf('Start date:'));
define('_ACA_JCALTAGS_START_TIPS', compa::encodeutf('Select Yes if you want to insert the start date of the event'));
define('_ACA_JCALTAGS_READMORE', compa::encodeutf('Read more:'));
define('_ACA_JCALTAGS_READMORE_TIPS', compa::encodeutf('Select Yes if you want to insert a <b>read more link</b> for this event'));
define('_ACA_REDIRECTCONFIRMATION', compa::encodeutf('Redirect URL'));
define('_ACA_REDIRECTCONFIRMATION_TIPS', compa::encodeutf('If you require a confirmation e-mail, the user will be confirmed and redirected to this URL if he clicks on the confirmation link.'));

//since 2.0.0 compatibility with Joomla 1.5
if(!defined('_CMN_SAVE') and defined('CMN_SAVE')) define('_CMN_SAVE',CMN_SAVE);
if(!defined('_CMN_SAVE')) define('_CMN_SAVE','Save');
if(!defined('_NO_ACCOUNT')) define('_NO_ACCOUNT','No account yet?');
if(!defined('_CREATE_ACCOUNT')) define('_CREATE_ACCOUNT','Register');
if(!defined('_NOT_AUTH')) define('_NOT_AUTH','You are not authorised to view this resource.');

//since 3.0.0
define('_ACA_DISABLETOOLTIP', compa::encodeutf('Disable Tooltip'));
define('_ACA_DISABLETOOLTIP_TIPS', compa::encodeutf('Disable the tooltip on the frontend'));
define('_ACA_MINISENDMAIL', compa::encodeutf('Use Mini SendMail'));
define('_ACA_MINISENDMAIL_TIPS', compa::encodeutf('If your server uses Mini SendMail, select this option to don\'t add the name of the user in the header of the e-mail'));

//Since 3.1.5
define('_ACA_READMORE',compa::encodeutf('Read more...'));
define('_ACA_VIEWARCHIVE',compa::encodeutf('Click here'));

//Acajoom GPL
define('_ACA_DESC_GPL',_ACA_DESC_NEWS);