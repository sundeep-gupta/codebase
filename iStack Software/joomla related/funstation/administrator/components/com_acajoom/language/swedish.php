<?php
defined('_JEXEC') OR defined('_VALID_MOS') OR die('...Direct Access to this location is not allowed...');


/**
 * <p>Swedish language file.</p>
 * @copyright (c) 2006 Acajoom Services / All Rights Reserved
 * @author Janne Karlsson<support@ijoobi.com>
 * @version $Id: swedish.php 491 2007-02-01 22:56:07Z divivo $
* @link http://www.ijoobi.com
 */

### General ###
 //acajoom Description
define('_ACA_DESC_NEWS', compa::encodeutf('Acajoom �r en mailinglista, nyhetsbrev, auto-respondrar, och ett uppf�ljningsverktyg f�r att kommunicera effektivt med dina anv�ndare och kunder. ' .
		'Acajoom, Din Kommunikations Partner!'));
define('_ACA_FEATURES', compa::encodeutf('Acajoom, din kommunikationspartner!'));

// Type of lists
define('_ACA_NEWSLETTER', compa::encodeutf('Nyhetsbrev'));
define('_ACA_AUTORESP', compa::encodeutf('Auto-responder'));
define('_ACA_AUTORSS', compa::encodeutf('Auto-RSS'));
define('_ACA_ECARD', compa::encodeutf('eKort'));
define('_ACA_POSTCARD', compa::encodeutf('Postkort'));
define('_ACA_PERF', compa::encodeutf('Prestanda'));
define('_ACA_COUPON', compa::encodeutf('Kupong'));
define('_ACA_CRON', compa::encodeutf('Cron Uppgift'));
define('_ACA_MAILING', compa::encodeutf('Maila'));
define('_ACA_LIST', compa::encodeutf('Lista'));

 //acajoom Menu
define('_ACA_MENU_LIST', compa::encodeutf('List Hanterare'));
define('_ACA_MENU_SUBSCRIBERS', compa::encodeutf('Prenumeranter'));
define('_ACA_MENU_NEWSLETTERS', compa::encodeutf('Nyhetsbrev'));
define('_ACA_MENU_AUTOS', compa::encodeutf('Auto-respondrar'));
define('_ACA_MENU_COUPONS', compa::encodeutf('Kuponger'));
define('_ACA_MENU_CRONS', compa::encodeutf('Cron Uppgifter'));
define('_ACA_MENU_AUTORSS', compa::encodeutf('Auto-RSS'));
define('_ACA_MENU_ECARD', compa::encodeutf('eKort'));
define('_ACA_MENU_POSTCARDS', compa::encodeutf('Postkort'));
define('_ACA_MENU_PERFS', compa::encodeutf('Prestanda'));
define('_ACA_MENU_TAB_LIST', compa::encodeutf('Listor'));
define('_ACA_MENU_MAILING_TITLE', compa::encodeutf('Mail'));
define('_ACA_MENU_MAILING', compa::encodeutf('Mailande f�r '));
define('_ACA_MENU_STATS', compa::encodeutf('Statistik'));
define('_ACA_MENU_STATS_FOR', compa::encodeutf('Statistik f�r '));
define('_ACA_MENU_CONF', compa::encodeutf('Konfiguration'));
define('_ACA_MENU_UPDATE', compa::encodeutf('Import'));
define('_ACA_MENU_ABOUT', compa::encodeutf('Om'));
define('_ACA_MENU_LEARN', compa::encodeutf('Utbildningscenter'));
define('_ACA_MENU_MEDIA', compa::encodeutf('Media Hanterare'));
define('_ACA_MENU_HELP', compa::encodeutf('Hj�lp'));
define('_ACA_MENU_CPANEL', compa::encodeutf('CPanel'));
define('_ACA_MENU_IMPORT', compa::encodeutf('Importera'));
define('_ACA_MENU_EXPORT', compa::encodeutf('Exportera'));
define('_ACA_MENU_SUB_ALL', compa::encodeutf('Prenumerara Alla'));
define('_ACA_MENU_UNSUB_ALL', compa::encodeutf('Ej Prenumerera Alla'));
define('_ACA_MENU_VIEW_ARCHIVE', compa::encodeutf('Arkiv'));
define('_ACA_MENU_PREVIEW', compa::encodeutf('F�rhandsgranska'));
define('_ACA_MENU_SEND', compa::encodeutf('Skicka'));
define('_ACA_MENU_SEND_TEST', compa::encodeutf('Skicka Test E-post'));
define('_ACA_MENU_SEND_QUEUE', compa::encodeutf('Process K�'));
define('_ACA_MENU_VIEW', compa::encodeutf('Visa'));
define('_ACA_MENU_COPY', compa::encodeutf('Kopiera'));
define('_ACA_MENU_VIEW_STATS', compa::encodeutf('Visa stats'));
define('_ACA_MENU_CRTL_PANEL', compa::encodeutf(' Kontrollpanel'));
define('_ACA_MENU_LIST_NEW', compa::encodeutf(' Skapa en Lista'));
define('_ACA_MENU_LIST_EDIT', compa::encodeutf(' Redigera en Lista'));
define('_ACA_MENU_BACK', compa::encodeutf('Tillbaka'));
define('_ACA_MENU_INSTALL', compa::encodeutf('Installation'));
define('_ACA_MENU_TAB_SUM', compa::encodeutf('Summering'));
define('_ACA_STATUS', compa::encodeutf('Status'));

// messages
define('_ACA_ERROR', compa::encodeutf(' Ett fel intr�ffade! '));
define('_ACA_SUB_ACCESS', compa::encodeutf('Beh�righets r�ttigheter'));
define('_ACA_DESC_CREDITS', compa::encodeutf('Krediter'));
define('_ACA_DESC_INFO', compa::encodeutf('Information'));
define('_ACA_DESC_HOME', compa::encodeutf('Hemsida'));
define('_ACA_DESC_MAILING', compa::encodeutf('Maillista'));
define('_ACA_DESC_SUBSCRIBERS', compa::encodeutf('Prenumeranter'));
define('_ACA_PUBLISHED', compa::encodeutf('Publicerad'));
define('_ACA_UNPUBLISHED', compa::encodeutf('Opublicerad'));
define('_ACA_DELETE', compa::encodeutf('Radera'));
define('_ACA_FILTER', compa::encodeutf('Filter'));
define('_ACA_UPDATE', compa::encodeutf('Uppdatera'));
define('_ACA_SAVE', compa::encodeutf('Spara'));
define('_ACA_CANCEL', compa::encodeutf('Avbryt'));
define('_ACA_NAME', compa::encodeutf('Namn'));
define('_ACA_EMAIL', compa::encodeutf('E-post'));
define('_ACA_SELECT', compa::encodeutf('V�lj'));
define('_ACA_ALL', compa::encodeutf('Alla'));
define('_ACA_SEND_A', compa::encodeutf('Skicka en '));
define('_ACA_SUCCESS_DELETED', compa::encodeutf(' raderades'));
define('_ACA_LIST_ADDED', compa::encodeutf('Lista skapades'));
define('_ACA_LIST_COPY', compa::encodeutf('Lista kopierades'));
define('_ACA_LIST_UPDATED', compa::encodeutf('Lista uppdaterades'));
define('_ACA_MAILING_SAVED', compa::encodeutf('Mailande sparades.'));
define('_ACA_UPDATED_SUCCESSFULLY', compa::encodeutf('uppdaterat.'));

### Subscribers information ###
//subscribe and unsubscribe info
define('_ACA_SUB_INFO', compa::encodeutf('Prenumerations information'));
define('_ACA_VERIFY_INFO', compa::encodeutf('Verifiera l�nken du la till, viss information saknas.'));
define('_ACA_INPUT_NAME', compa::encodeutf('Namn'));
define('_ACA_INPUT_EMAIL', compa::encodeutf('E-post'));
define('_ACA_RECEIVE_HTML', compa::encodeutf('Mottag HTML?'));
define('_ACA_TIME_ZONE', compa::encodeutf('Tids Zon'));
define('_ACA_BLACK_LIST', compa::encodeutf('Svarta listan'));
define('_ACA_REGISTRATION_DATE', compa::encodeutf('Anv�ndares registreringsdatum'));
define('_ACA_USER_ID', compa::encodeutf('Anv�ndar ID'));
define('_ACA_DESCRIPTION', compa::encodeutf('Beskrivning'));
define('_ACA_ACCOUNT_CONFIRMED', compa::encodeutf('Ditt konto har aktiverats.'));
define('_ACA_SUB_SUBSCRIBER', compa::encodeutf('Prenumerant'));
define('_ACA_SUB_PUBLISHER', compa::encodeutf('Publicist'));
define('_ACA_SUB_ADMIN', compa::encodeutf('Administrat�r'));
define('_ACA_REGISTERED', compa::encodeutf('Registrerad'));
define('_ACA_SUBSCRIPTIONS', compa::encodeutf('Prenumerationer'));
define('_ACA_SEND_UNSUBCRIBE', compa::encodeutf('Skicka prenumerera ej meddelande'));
define('_ACA_SEND_UNSUBCRIBE_TIPS', compa::encodeutf('Klicka Ja f�r att skicka ett prenumerera ej e-post bekr�ftelse meddelande.'));
define('_ACA_SUBSCRIBE_SUBJECT_MESS', compa::encodeutf('Bekr�fta din prenumeration'));
define('_ACA_UNSUBSCRIBE_SUBJECT_MESS', compa::encodeutf('Prenumerera Ej bekr�ftelse'));
define('_ACA_DEFAULT_SUBSCRIBE_MESS', compa::encodeutf('Hej ! [NAME],<br />' .
		'Bara ett steg till sedan �r du inlagd i prenumerationslistan.  Klicka p� f�ljande l�nk f�r att bekr�fta din prenumeration.' .
		'<br /><br />[CONFIRM]<br /><br />Vid fr�gor kontakta webmaster.'));
define('_ACA_DEFAULT_UNSUBSCRIBE_MESS', compa::encodeutf('Detta �r ett bekr�ftelsemail om att du har valt att inte l�ngre prenumerera hos oss mera.  Vi �r sj�lvklart ledsna att du valt detta men om du v�ljer att �ter prenumerera hos oss igen s� �r du v�lkommen tillbaka.  Om du har n�gra fr�gor s� kontakta v�r webmaster.'));

// Acajoom subscribers
define('_ACA_SIGNUP_DATE', compa::encodeutf('Inskrivningsdatum'));
define('_ACA_CONFIRMED', compa::encodeutf('Bekr�ftad'));
define('_ACA_SUBSCRIB', compa::encodeutf('Prenumerera'));
define('_ACA_HTML', compa::encodeutf('HTML mail'));
define('_ACA_RESULTS', compa::encodeutf('Resultat'));
define('_ACA_SEL_LIST', compa::encodeutf('V�lj en lista'));
define('_ACA_SEL_LIST_TYPE', compa::encodeutf('- V�lj typ av lista -'));
define('_ACA_SUSCRIB_LIST', compa::encodeutf('Lista p� alla prenumeranter'));
define('_ACA_SUSCRIB_LIST_UNIQUE', compa::encodeutf('prenumeranter f�r : '));
define('_ACA_NO_SUSCRIBERS', compa::encodeutf('Inga prenumeranter hittades i denna lista.'));
define('_ACA_COMFIRM_SUBSCRIPTION', compa::encodeutf('Ett bekr�ftelsemail har skickats till e-postadressen som du uppgav.  Kolla ditt e-post meddelande och klicka p� l�nken som anges.<br />' .
		'Du beh�ver bekr�fta din e-post f�r att din prenumeration ska b�rja g�lla.'));
define('_ACA_SUCCESS_ADD_LIST', compa::encodeutf('Du har lagts till i listan �ver prenumerationer.'));


 // Subcription info
define('_ACA_CONFIRM_LINK', compa::encodeutf('Klicka h�r f�r att bekr�fta din prenumeration'));
define('_ACA_UNSUBSCRIBE_LINK', compa::encodeutf('Klicka h�r f�r att ta bort dig fr�n listan �ver prenumeranter'));
define('_ACA_UNSUBSCRIBE_MESS', compa::encodeutf('Din e-postadress har tagits bort fr�n listan'));

define('_ACA_QUEUE_SENT_SUCCESS', compa::encodeutf('Alla schemalagda mailningar har skickats iv�g.'));
define('_ACA_MALING_VIEW', compa::encodeutf('Visa alla mailningar'));
define('_ACA_UNSUBSCRIBE_MESSAGE', compa::encodeutf('�r du s�ker p� att du inte vill prenumerera hos oss l�ngre?'));
define('_ACA_MOD_SUBSCRIBE', compa::encodeutf('Prenumerera'));
define('_ACA_SUBSCRIBE', compa::encodeutf('Prenumerera'));
define('_ACA_UNSUBSCRIBE', compa::encodeutf('Prenumerera Ej'));
define('_ACA_VIEW_ARCHIVE', compa::encodeutf('Visa arkiv'));
define('_ACA_SUBSCRIPTION_OR', compa::encodeutf(' eller klicka h�r f�r att uppdatera din information'));
define('_ACA_EMAIL_ALREADY_REGISTERED', compa::encodeutf('E-postadressen som du angav finns redan.'));
define('_ACA_SUBSCRIBER_DELETED', compa::encodeutf('Prenumerant raderades.'));


### UserPanel ###
 //User Menu
define('_UCP_USER_PANEL', compa::encodeutf('Anv�ndar Kontrollpanel'));
define('_UCP_USER_MENU', compa::encodeutf('Anv�ndarmeny'));
define('_UCP_USER_CONTACT', compa::encodeutf('Mina Prenumerationer'));
 //Acajoom Cron Menu
define('_UCP_CRON_MENU', compa::encodeutf('Cron Uppgifts Hanterare'));
define('_UCP_CRON_NEW_MENU', compa::encodeutf('NY Cron'));
define('_UCP_CRON_LIST_MENU', compa::encodeutf('Lista min Cron'));
 //Acajoom Coupon Menu
define('_UCP_COUPON_MENU', compa::encodeutf('Kupong Hanterare'));
define('_UCP_COUPON_LIST_MENU', compa::encodeutf('Lista p� Kuponger'));
define('_UCP_COUPON_ADD_MENU', compa::encodeutf('Skapa en Kupong'));

### lists ###
// Tabs
define('_ACA_LIST_T_GENERAL', compa::encodeutf('Beskrivning'));
define('_ACA_LIST_T_LAYOUT', compa::encodeutf('Layout'));
define('_ACA_LIST_T_SUBSCRIPTION', compa::encodeutf('Prenumeration'));
define('_ACA_LIST_T_SENDER', compa::encodeutf('Avs�ndarinformation'));

define('_ACA_LIST_TYPE', compa::encodeutf('List Typ'));
define('_ACA_LIST_NAME', compa::encodeutf('List namn'));
define('_ACA_LIST_ISSUE', compa::encodeutf('Nummer #'));
define('_ACA_LIST_DATE', compa::encodeutf('S�ndningsdatum'));
define('_ACA_LIST_SUB', compa::encodeutf('Mail�mne'));
define('_ACA_ATTACHED_FILES', compa::encodeutf('Bifogade filer'));
define('_ACA_SELECT_LIST', compa::encodeutf('V�lj en lista att redigera!'));

// Auto Responder box
define('_ACA_AUTORESP_ON', compa::encodeutf('Typ av lista'));
define('_ACA_AUTO_RESP_OPTION', compa::encodeutf('Auto-responder val'));
define('_ACA_AUTO_RESP_FREQ', compa::encodeutf('Prenumeranter kan v�lja frekvens'));
define('_ACA_AUTO_DELAY', compa::encodeutf('F�rsening (i dagar)'));
define('_ACA_AUTO_DAY_MIN', compa::encodeutf('Minimum frekvens'));
define('_ACA_AUTO_DAY_MAX', compa::encodeutf('Maximum frekvens'));
define('_ACA_FOLLOW_UP', compa::encodeutf('Specificera auto-responder uppf�ljning'));
define('_ACA_AUTO_RESP_TIME', compa::encodeutf('Prenumeranter kan v�lja tid'));
define('_ACA_LIST_SENDER', compa::encodeutf('Lista avs�ndare'));

define('_ACA_LIST_DESC', compa::encodeutf('List beskrivning'));
define('_ACA_LAYOUT', compa::encodeutf('Layout'));
define('_ACA_SENDER_NAME', compa::encodeutf('Avs�ndarnamn'));
define('_ACA_SENDER_EMAIL', compa::encodeutf('Avs�ndarens e-post'));
define('_ACA_SENDER_BOUNCE', compa::encodeutf('Avs�ndarens studsadress'));
define('_ACA_LIST_DELAY', compa::encodeutf('F�rsening'));
define('_ACA_HTML_MAILING', compa::encodeutf('HTML mail?'));
define('_ACA_HTML_MAILING_DESC', compa::encodeutf('(om du �ndrar detta, s� beh�ver du spara och �terv�nda till denna ruta f�r att se �ndringarna.)'));
define('_ACA_HIDE_FROM_FRONTEND', compa::encodeutf('D�lj p� framsidan?'));
define('_ACA_SELECT_IMPORT_FILE', compa::encodeutf('V�lj en fil att importera'));;
define('_ACA_IMPORT_FINISHED', compa::encodeutf('Importering avslutat'));
define('_ACA_DELETION_OFFILE', compa::encodeutf('Radering av fil'));
define('_ACA_MANUALLY_DELETE', compa::encodeutf('misslyckades, du m�ste ta bort filen manuellt'));
define('_ACA_CANNOT_WRITE_DIR', compa::encodeutf('Kan inte skriva till mappen'));
define('_ACA_NOT_PUBLISHED', compa::encodeutf('Kunde inte skicka mailen, listan �r inte publicerad.'));

//  List info box
define('_ACA_INFO_LIST_PUB', compa::encodeutf('Klicka Ja f�r att publicera listan'));
define('_ACA_INFO_LIST_NAME', compa::encodeutf('Skriv in namnet p� listan h�r. Du kan identifiera listan med detta namn.'));
define('_ACA_INFO_LIST_DESC', compa::encodeutf('Skriv in en kort beskrivning p� listan h�r. Denna beskrivning kommer att vara synlig f�r bes�kare p� din hemsida.'));
define('_ACA_INFO_LIST_SENDER_NAME', compa::encodeutf('Skriv in namnet p� avs�ndaren p� mailen. Detta namn kommer att vara synligt n�r prenumeranter mottar meddelanden fr�n denna lista.'));
define('_ACA_INFO_LIST_SENDER_EMAIL', compa::encodeutf('Skriv in e-postadressen fr�n vilken meddelandet kommer att skickas ifr�n.'));
define('_ACA_INFO_LIST_SENDER_BOUNCED', compa::encodeutf('Skriv in e-postadressen som anv�ndare kan svar till. Det rekomenderas att det �r samma som avs�ndar adressen, eftersom spamfilter kommer att ge ditt meddelande en h�gre rankning om dom �r olika.'));
define('_ACA_INFO_LIST_AUTORESP', compa::encodeutf('V�lj typ av mail p� denna lista. <br />' .
		'Nyhetsbrev: normalt nyhetsbrev<br />' .
		'Auto-responder: en auto-responder �r en lista som s�nds automatiskt genom hemsidan vid regelbundna intervaller.'));
define('_ACA_INFO_LIST_FREQUENCY', compa::encodeutf('Aktivera anv�ndare genom att ange hur ofta dom ska motta fr�n denna lista.  Det ger mer flexibilitet f�r anv�ndaren.'));
define('_ACA_INFO_LIST_TIME', compa::encodeutf('L�t anv�ndaren v�lja sin �nskade tid p� dygnet f�r att motta fr�n listan.'));
define('_ACA_INFO_LIST_MIN_DAY', compa::encodeutf('Definera vad som �r den minimala frekvensen en anv�ndare kan v�lja att mottaga listan'));
define('_ACA_INFO_LIST_DELAY', compa::encodeutf('Specificera f�rdr�jningen mellan denna auto-responder och den f�reg�ende g�ngen.'));
define('_ACA_INFO_LIST_DATE', compa::encodeutf('Specificera datumet f�r publicering av nyhetslistan om du vill f�rdr�ja publiceringen. <br /> FORMAT : ����-MM-DD TT:MM:SS'));
define('_ACA_INFO_LIST_MAX_DAY', compa::encodeutf('Definera vad som �r den maximala frekvensen en anv�ndare kan v�lja att mottaga listan'));
define('_ACA_INFO_LIST_LAYOUT', compa::encodeutf('Skriv in layouten p� din maillista h�r. Du kan fylla i vilken layout f�r din mail h�r.'));
define('_ACA_INFO_LIST_SUB_MESS', compa::encodeutf('Detta meddelande kommer att skickas till prenumeranten n�r han eller hon registreras f�r f�rsta g�ngen. Du kan fylla i den text du �nskar h�r.'));
define('_ACA_INFO_LIST_UNSUB_MESS', compa::encodeutf('Detta meddelande kommer att skickas till prenumeranten n�r han eller hon vill avs�ga sig sin prenumeration. Ditt meddelande kan du fylla i h�r.'));
define('_ACA_INFO_LIST_HTML', compa::encodeutf('V�lj kryssrutan om du vill skicka ut ett HTML mail. Prenumeranter kommer att kunna specificera om dom vill motta HTML meddelande, eller endast Text meddelande n�r dom prenumererar p� en HTML lista.'));
define('_ACA_INFO_LIST_HIDDEN', compa::encodeutf('Klicka Ja f�r att d�lja listan p� f�rstasidan, anv�ndare kommer inte att kunna prenumerera men du kommer fortfarande att kunna skicka mail.'));
define('_ACA_INFO_LIST_ACA_AUTO_SUB', compa::encodeutf('Vill du med automatik l�gga till prenumeranter till denna lista?<br /><B>Nya Anv�ndare:</B> kommer att registrera varje ny anv�ndare som har registrerat sig p� hemsidan.<br /><B>Alla Anv�ndare:</B> kommer att registrera varje registrerad anv�ndare till databasen.<br />(alla dessa alternativ supportar Community Builder)'));
define('_ACA_INFO_LIST_ACC_LEVEL', compa::encodeutf('V�lj f�rstasidans beh�righetsniv�. Detta kommer att visa eller d�lja mailen till anv�ndargrupper som inte har tillg�ng till den, s� dom inte kan prenumerera p� den.'));
define('_ACA_INFO_LIST_ACC_USER_ID', compa::encodeutf('V�lj beh�righetsniv� p� anv�ndargrupper som du vill ska kunna redigera. Dessa anv�ndargrupper och ovanf�r kommer att kunna redigera mailen och skicka ut dom, antingen fr�n f�rstasidan eller fr�n backend.'));
define('_ACA_INFO_LIST_FOLLOW_UP', compa::encodeutf('Om du vill att auto-respondern ska flyttas till en annan s� fort den skickat sitt sista meddelande s� kan du specificera det h�r f�r att f�lja upp auto-respondern.'));
define('_ACA_INFO_LIST_ACA_OWNER', compa::encodeutf('Detta �r ID:en p� personen som skapade listan.'));
define('_ACA_INFO_LIST_WARNING', compa::encodeutf(' Detta sista val �r endast tillg�ngligt p� slutet vid skapande av listan.'));
define('_ACA_INFO_LIST_SUBJET', compa::encodeutf(' �mne p� mailen.  Detta �r �mnet p� e-posten som prenumeranten kommer att motta.'));
define('_ACA_INFO_MAILING_CONTENT', compa::encodeutf('Detta �r huvudrutan p� mailet som kommer att skickas.'));
define('_ACA_INFO_MAILING_NOHTML', compa::encodeutf('Skriv in h�r huvudtexten p� mailet som du vill skicka till prenumeranterna som v�ljer att motta endast icke HTML mail. <BR/> NOTERA: om du l�mnar detta tomt s� kommer Acajoom automatiskt att konvertera det fr�n HTML text till endast text.'));
define('_ACA_INFO_MAILING_VISIBLE', compa::encodeutf('Klicka Ja f�r att visa mailen p� f�rstasidan.'));
define('_ACA_INSERT_CONTENT', compa::encodeutf('S�tt in existerande inneh�ll'));

// Coupons
define('_ACA_SEND_COUPON_SUCCESS', compa::encodeutf('Kupong skickat!'));
define('_ACA_CHOOSE_COUPON', compa::encodeutf('V�lj en kupong'));
define('_ACA_TO_USER', compa::encodeutf(' till denna anv�ndare'));

### Cron options
//drop down frequency(CRON)
define('_ACA_FREQ_CH1', compa::encodeutf('Varje timma'));
define('_ACA_FREQ_CH2', compa::encodeutf('Var 6:e timma'));
define('_ACA_FREQ_CH3', compa::encodeutf('Var 12:e timma'));
define('_ACA_FREQ_CH4', compa::encodeutf('Dagligt'));
define('_ACA_FREQ_CH5', compa::encodeutf('Veckovis'));
define('_ACA_FREQ_CH6', compa::encodeutf('M�nadsvis'));
define('_ACA_FREQ_NONE', compa::encodeutf('Nej'));
define('_ACA_FREQ_NEW', compa::encodeutf('Nya Anv�ndare'));
define('_ACA_FREQ_ALL', compa::encodeutf('Alla Anv�ndare'));

//Label CRON form
define('_ACA_LABEL_FREQ', compa::encodeutf('Acajoom Cron?'));
define('_ACA_LABEL_FREQ_TIPS', compa::encodeutf('Klicka Ja om du vill anv�nda detta som ett Acajoom Cron, Nej f�r n�gon annan cron uppgift.<br />' .
		'Om du klicka Ja s� beh�ver du inte ange n�gon Cron Adress, det kommer automatiskt att l�ggas till.'));
define('_ACA_SITE_URL', compa::encodeutf('Din hemsidas URL'));
define('_ACA_CRON_FREQUENCY', compa::encodeutf('Cron Frekvens'));
define('_ACA_STARTDATE_FREQ', compa::encodeutf('Start Datum'));
define('_ACA_LABELDATE_FREQ', compa::encodeutf('Specificera Datum'));
define('_ACA_LABELTIME_FREQ', compa::encodeutf('Specificera Tid'));
define('_ACA_CRON_URL', compa::encodeutf('Cron URL'));
define('_ACA_CRON_FREQ', compa::encodeutf('Frekvens'));
define('_ACA_TITLE_CRONLIST', compa::encodeutf('Cron Lista'));
define('_NEW_LIST', compa::encodeutf('Skapa en ny lista'));

//title CRON form
define('_ACA_TITLE_FREQ', compa::encodeutf('Redigera Cron'));
define('_ACA_CRON_SITE_URL', compa::encodeutf('Fyll i en giltig hemside url, starta med http://'));

### Mailings ###
define('_ACA_MAILING_ALL', compa::encodeutf('Alla mail'));
define('_ACA_EDIT_A', compa::encodeutf('Redigera ett '));
define('_ACA_SELCT_MAILING', compa::encodeutf('V�lj en lista i drop down menyn f�r att l�gga till en ny mail.'));
define('_ACA_VISIBLE_FRONT', compa::encodeutf('Synligt p� f�rstasidan'));

// mailer
define('_ACA_SUBJECT', compa::encodeutf('�mne'));
define('_ACA_CONTENT', compa::encodeutf('Inneh�ll'));
define('_ACA_NAMEREP', compa::encodeutf('[NAME] = Detta kommer att ers�ttas med namnet som prenumeranten uppgav, du skickar personlig e-post n�r du anv�nder dig av detta.<br />'));
define('_ACA_FIRST_NAME_REP', compa::encodeutf('[FIRSTNAME] = Detta kommer att ers�ttas med F�R namnet som prenumeranten uppgav.<br />'));
define('_ACA_NONHTML', compa::encodeutf('Ingen-html version'));
define('_ACA_ATTACHMENTS', compa::encodeutf('Bifogade filer'));
define('_ACA_SELECT_MULTIPLE', compa::encodeutf('Hold kontrollen (eller kommando) f�r att v�lja flera bifogade filer.<br />' .
		'Filerna som visas i den bifogade listan finns i en bifogad fil mapp, du kan �ndra denna plats i konfigurationspanelen.'));
define('_ACA_CONTENT_ITEM', compa::encodeutf('Inneh�lls objekt'));
define('_ACA_SENDING_EMAIL', compa::encodeutf('Skickar e-post'));
define('_ACA_MESSAGE_NOT', compa::encodeutf('Meddelandet kunde inte skickas'));
define('_ACA_MAILER_ERROR', compa::encodeutf('Mail fel'));
define('_ACA_MESSAGE_SENT_SUCCESSFULLY', compa::encodeutf('Meddelande skickat'));
define('_ACA_SENDING_TOOK', compa::encodeutf('S�ndning av detta mail tog'));
define('_ACA_SECONDS', compa::encodeutf('sekunder'));
define('_ACA_NO_ADDRESS_ENTERED', compa::encodeutf('Ingen e-postadress eller prenumerant angavs'));
define('_ACA_CHANGE_SUBSCRIPTIONS', compa::encodeutf('�ndra'));
define('_ACA_CHANGE_EMAIL_SUBSCRIPTION', compa::encodeutf('�ndra din prenumeration'));
define('_ACA_WHICH_EMAIL_TEST', compa::encodeutf('Indikera en e-postadress f�r att skicka ett test till eller v�lj f�rhandsgranska'));
define('_ACA_SEND_IN_HTML', compa::encodeutf('Skicka i HTML (f�r html mail)?'));
define('_ACA_VISIBLE', compa::encodeutf('Synlig'));
define('_ACA_INTRO_ONLY', compa::encodeutf('Endast Intro'));

// stats
define('_ACA_GLOBALSTATS', compa::encodeutf('Global status'));
define('_ACA_DETAILED_STATS', compa::encodeutf('Detaljerad stats'));
define('_ACA_MAILING_LIST_DETAILS', compa::encodeutf('List detaljer'));
define('_ACA_SEND_IN_HTML_FORMAT', compa::encodeutf('Skicka i HTML format'));
define('_ACA_VIEWS_FROM_HTML', compa::encodeutf('Visningar (fr�m html mail)'));
define('_ACA_SEND_IN_TEXT_FORMAT', compa::encodeutf('Skicka i text format'));
define('_ACA_HTML_READ', compa::encodeutf('HTML l�st'));
define('_ACA_HTML_UNREAD', compa::encodeutf('HTML ol�st'));
define('_ACA_TEXT_ONLY_SENT', compa::encodeutf('Endast Text'));

// Configuration panel
// main tabs
define('_ACA_MAIL_CONFIG', compa::encodeutf('Mail'));
define('_ACA_LOGGING_CONFIG', compa::encodeutf('Loggar & Status'));
define('_ACA_SUBSCRIBER_CONFIG', compa::encodeutf('Prenumeranter'));
define('_ACA_AUTO_CONFIG', compa::encodeutf('Cron'));
define('_ACA_MISC_CONFIG', compa::encodeutf('�vrig'));
define('_ACA_MAIL_SETTINGS', compa::encodeutf('Mail Inst�llningar'));
define('_ACA_MAILINGS_SETTINGS', compa::encodeutf('Mail Inst�llningar'));
define('_ACA_SUBCRIBERS_SETTINGS', compa::encodeutf('Prenumerant Inst�llningar'));
define('_ACA_CRON_SETTINGS', compa::encodeutf('Cron Inst�llningar'));
define('_ACA_SENDING_SETTINGS', compa::encodeutf('S�ndnings Inst�llningar'));
define('_ACA_STATS_SETTINGS', compa::encodeutf('Statistik Inst�llningar'));
define('_ACA_LOGS_SETTINGS', compa::encodeutf('Logg Inst�llningar'));
define('_ACA_MISC_SETTINGS', compa::encodeutf('�vriga Inst�llningar'));
// mail settings
define('_ACA_SEND_MAIL_FROM', compa::encodeutf('Bounce Back Address<br/>(used as Bounced back for all your messages)'));
define('_ACA_SEND_MAIL_NAME', compa::encodeutf('Fr�n Namn'));
define('_ACA_MAILSENDMETHOD', compa::encodeutf('Mail metod'));
define('_ACA_SENDMAILPATH', compa::encodeutf('Skicka mail s�kv�g'));
define('_ACA_SMTPHOST', compa::encodeutf('SMTP v�rd'));
define('_ACA_SMTPAUTHREQUIRED', compa::encodeutf('SMTP Autentificering kr�vs'));
define('_ACA_SMTPAUTHREQUIRED_TIPS', compa::encodeutf('V�lj ja om din SMTP server kr�ver autentificering'));
define('_ACA_SMTPUSERNAME', compa::encodeutf('SMTP anv�ndarnamn'));
define('_ACA_SMTPUSERNAME_TIPS', compa::encodeutf('Skriv in SMTP anv�ndarnamnet n�r din SMTP server kr�ver autentificering'));
define('_ACA_SMTPPASSWORD', compa::encodeutf('SMTP l�senord'));
define('_ACA_SMTPPASSWORD_TIPS', compa::encodeutf('Skriv in SMTP l�senord n�r din SMTP server kr�ver autentificering'));
define('_ACA_USE_EMBEDDED', compa::encodeutf('Anv�nd inb�ddade bilder'));
define('_ACA_USE_EMBEDDED_TIPS', compa::encodeutf('V�lj ja om bilderna i bifogat inneh�lls objekt ska b�ddas in i mailet f�r html meddelanden, eller nej f�r att anv�nda dig av standardbild tagar som l�nkas till bilderna p� hemsidan.'));
define('_ACA_UPLOAD_PATH', compa::encodeutf('Uppladdning/bifogade filer s�kv�g'));
define('_ACA_UPLOAD_PATH_TIPS', compa::encodeutf('Du kan specificera en uppladdningsmapp.<br />' .
		'Se till att mappen som du specificerade finns, annars skapa den.'));

// subscribers settings
define('_ACA_ALLOW_UNREG', compa::encodeutf('Till�t oregistrerade'));
define('_ACA_ALLOW_UNREG_TIPS', compa::encodeutf('V�lj Ja om du vill till�ta anv�ndare att prenumerera p� listor utan att vara registrerade p� hemsidan.'));
define('_ACA_REQ_CONFIRM', compa::encodeutf('Kr�ver bekr�ftelse'));
define('_ACA_REQ_CONFIRM_TIPS', compa::encodeutf('V�lj ja om du kr�ver att oregistrerade prenumeranter ska bekr�fta sin e-postadress.'));
define('_ACA_SUB_SETTINGS', compa::encodeutf('Prenumerations Inst�llningar'));
define('_ACA_SUBMESSAGE', compa::encodeutf('Prenumerations E-post'));
define('_ACA_SUBSCRIBE_LIST', compa::encodeutf('Prenumerera p� en lista'));

define('_ACA_USABLE_TAGS', compa::encodeutf('Anv�ndbara taggar'));
define('_ACA_NAME_AND_CONFIRM', compa::encodeutf('<b>[CONFIRM]</b> = Detta skapar en klickbar l�nk som prenumeranten kan bekr�fta sin prenumeration. Detta  <strong>kr�vs</strong> f�r att Acajoom ska fungera korrekt.<br />'
.'<br />[NAME] = Detta kommer att ers�ttas med namnet som prenumeranten uppgav, du skickar personlig e-post om du anv�nder dig av detta.<br />'
.'<br />[FIRSTNAME] = Detta kommer att ers�ttas med F�R namnet p� prenumeranten, F�rsta namnet DEFINERAS som f�rsta namnet som fylls i av prenumeranten.<br />'));
define('_ACA_CONFIRMFROMNAME', compa::encodeutf('Bekr�fta fr�n namn'));
define('_ACA_CONFIRMFROMNAME_TIPS', compa::encodeutf('Skriv in fr�n namn som visas i bekr�ftelse listor.'));
define('_ACA_CONFIRMFROMEMAIL', compa::encodeutf('Bekr�fta fr�n e-post'));
define('_ACA_CONFIRMFROMEMAIL_TIPS', compa::encodeutf('Skriv in en e-postadress som visas i bekr�ftelse listor.'));
define('_ACA_CONFIRMBOUNCE', compa::encodeutf('Studsadress'));
define('_ACA_CONFIRMBOUNCE_TIPS', compa::encodeutf('Skriv in en studsadress som visas i bekr�ftelse listor.'));
define('_ACA_HTML_CONFIRM', compa::encodeutf('HTML bekr�ftelse'));
define('_ACA_HTML_CONFIRM_TIPS', compa::encodeutf('V�lj ja om bekr�ftelse listor ska vara html om anv�ndaren till�ter html.'));
define('_ACA_TIME_ZONE_ASK', compa::encodeutf('Fr�ga tidszon'));
define('_ACA_TIME_ZONE_TIPS', compa::encodeutf('V�lj ja om du vill fr�ga om anv�ndarnas tidszon.  De k�ade mailen kommer att skickas enligt turordningen baserat p� vilken tidszon man befinner sig i'));

 // Cron Set up
define('_ACA_TIME_OFFSET_URL', compa::encodeutf('klicka h�r f�r att st�lla in offset i den globala konfigurationspanelen -> Lokal tabb'));
define('_ACA_TIME_OFFSET_TIPS', compa::encodeutf('St�ll in din servers tid offset s� det inspelade datumet och tiden �r exakt'));
define('_ACA_TIME_OFFSET', compa::encodeutf('Tid offset'));
define('_ACA_CRON_TITLE', compa::encodeutf('St�ller in cron funktion'));
define('_ACA_CRON_DESC', compa::encodeutf('<br />Genom att anv�nda cron funktionen s� kan du st�lla in en automatisk uppgift f�r din hemsida!<br />' .
		'F�r att st�lla in den s� beh�ver du i din crontab kontrollpanel skriva f�ljande kommando:<br />' .
		'<b>' . ACA_JPATH_LIVE . '/index2.php?option=com_acajoom&act=cron</b> ' .
		'<br /><br />Om du beh�ver hj�lp att st�lla in den eller har problem var god och konsultera v�rat forum <a href="http://www.ijoobi.com" target="_blank">http://www.ijoobi.com</a>'));
// sending settings
define('_ACA_PAUSEX', compa::encodeutf('Pausa x sekunder varje konfigurerad m�ngd av mail'));
define('_ACA_PAUSEX_TIPS', compa::encodeutf('Skriv in antalet sekunder som Acajoom kommer att ge SMTP servern tiden att s�nda ut meddelanden innan den forts�tter med n�sta konfigurerade m�ngd av meddelanden.'));
define('_ACA_EMAIL_BET_PAUSE', compa::encodeutf('Mail mellan pausar'));
define('_ACA_EMAIL_BET_PAUSE_TIPS', compa::encodeutf('Antalet mail att skicka innan den ska pausa.'));
define('_ACA_WAIT_USER_PAUSE', compa::encodeutf('V�nta p� anv�ndarinmatningsdata vid paus'));
define('_ACA_WAIT_USER_PAUSE_TIPS', compa::encodeutf('Om skriptet ska v�nta p� anv�ndarinmatningsdata n�r paus sker med mailande.'));
define('_ACA_SCRIPT_TIMEOUT', compa::encodeutf('Skript timeout'));
define('_ACA_SCRIPT_TIMEOUT_TIPS', compa::encodeutf('Antalet minuter som skriptet ska k�ras.'));
// Stats settings
define('_ACA_ENABLE_READ_STATS', compa::encodeutf('Aktivera l�s statistik'));
define('_ACA_ENABLE_READ_STATS_TIPS', compa::encodeutf('V�lj ja om du vill logga antalet visningar. Denna teknik kan endast anv�ndas med html mailande'));
define('_ACA_LOG_VIEWSPERSUB', compa::encodeutf('Logga visningar per prenumerant'));
define('_ACA_LOG_VIEWSPERSUB_TIPS', compa::encodeutf('V�lj ja om du vill logga antalet visningar per prenumerant. Denna teknik kan endast anv�ndas med html mailande'));
// Logs settings
define('_ACA_DETAILED', compa::encodeutf('Detaljerade loggar'));
define('_ACA_SIMPLE', compa::encodeutf('F�renklade loggar'));
define('_ACA_DIAPLAY_LOG', compa::encodeutf('Visa loggar'));
define('_ACA_DISPLAY_LOG_TIPS', compa::encodeutf('V�lj ja om du vill visa loggar medans du skickar mail.'));
define('_ACA_SEND_PERF_DATA', compa::encodeutf('S�nd ut prestanda'));
define('_ACA_SEND_PERF_DATA_TIPS', compa::encodeutf('V�lj ja om du vill till�ta Acajoom att s�nda ut ANONYMA rapporter om din konfiguration, antalet prenumeranter i en lista och tiden det tog att skicka ut mailen. Detta ger oss en id� om Acajoom prestandan och kommer att HJ�LPA OSS att f�rb�ttra Acajoom i framtida utvecklingar.'));
define('_ACA_SEND_AUTO_LOG', compa::encodeutf('Skicka logg f�r auto-responder'));
define('_ACA_SEND_AUTO_LOG_TIPS', compa::encodeutf('V�lj ja om du vill skicka en mail logg varje g�ng tek k�n behandlas.  VARNING: detta kan resultera i stor m�ngd mail.'));
define('_ACA_SEND_LOG', compa::encodeutf('Skicka logg'));
define('_ACA_SEND_LOG_TIPS', compa::encodeutf('Om en logg av mailandet ska e-postas till anv�ndarens e-postadress som skickade mailet.'));
define('_ACA_SEND_LOGDETAIL', compa::encodeutf('Skicka logg detaljer'));
define('_ACA_SEND_LOGDETAIL_TIPS', compa::encodeutf('Detaljerad inkluderar den lyckade eller felaktiga information f�r varje prenumerant och en �verblick utav informationen. Skickar endast en enkel �versikt.'));
define('_ACA_SEND_LOGCLOSED', compa::encodeutf('Skicka logg om �verf�ringen st�ngs'));
define('_ACA_SEND_LOGCLOSED_TIPS', compa::encodeutf(' Med detta val p� anv�ndaren som skickade mailet s� kommer den personen fortfarande f� en rapport via e-post.'));
define('_ACA_SAVE_LOG', compa::encodeutf('Spara logg'));
define('_ACA_SAVE_LOG_TIPS', compa::encodeutf('Om en logg p� mailen ska tas upp till loggfilen.'));
define('_ACA_SAVE_LOGDETAIL', compa::encodeutf('Spara loggdetaljer'));
define('_ACA_SAVE_LOGDETAIL_TIPS', compa::encodeutf('Detaljerad inkluderar den lyckade eller felaktiga information f�r varje prenumerant och en �verblick utav informationen. Sparar endast en enkel �versikt.'));
define('_ACA_SAVE_LOGFILE', compa::encodeutf('Spara loggfil'));
define('_ACA_SAVE_LOGFILE_TIPS', compa::encodeutf('Filen som logg informationen ska tas upp till. Denna fil kan bli riktigt stor.'));
define('_ACA_CLEAR_LOG', compa::encodeutf('Rensa logg'));
define('_ACA_CLEAR_LOG_TIPS', compa::encodeutf('Rensar loggfilen.'));

### control panel
define('_ACA_CP_LAST_QUEUE', compa::encodeutf('Senast k�rda k�'));
define('_ACA_CP_TOTAL', compa::encodeutf('Totalt'));
define('_ACA_MAILING_COPY', compa::encodeutf('Mailen kopierad!'));

// Miscellaneous settings
define('_ACA_SHOW_GUIDE', compa::encodeutf('Visa guide'));
define('_ACA_SHOW_GUIDE_TIPS', compa::encodeutf('Visar guiden vid start f�r att hj�lpa nya anv�ndare skapa ett nyhetsbrev, en auto-responder och att st�lla in Acajoom ordentligt.'));
define('_ACA_AUTOS_ON', compa::encodeutf('Anv�nd Auto-respondrar'));
define('_ACA_AUTOS_ON_TIPS', compa::encodeutf('V�lj Nej om du inte vill anv�nda Auto-respondrar, alla auto-responder val kommer att inaktiveras.'));
define('_ACA_NEWS_ON', compa::encodeutf('Anv�nd Nyhetsbrev'));
define('_ACA_NEWS_ON_TIPS', compa::encodeutf('V�lj Nej om du inte vill anv�nda Nyhetsbrev, alla nyhetsbrevsval kommer att inaktiveras.'));
define('_ACA_SHOW_TIPS', compa::encodeutf('Visa tips'));
define('_ACA_SHOW_TIPS_TIPS', compa::encodeutf('Visa tipsen, f�r att hj�lpa anv�ndare att anv�nda Acajoom mer effektivt.'));
define('_ACA_SHOW_FOOTER', compa::encodeutf('Visa sidfot'));
define('_ACA_SHOW_FOOTER_TIPS', compa::encodeutf('Om sidfots copyrights noteringar ska visas.'));
define('_ACA_SHOW_LISTS', compa::encodeutf('Visa listor p� f�rstasidan'));
define('_ACA_SHOW_LISTS_TIPS', compa::encodeutf('N�r anv�ndare inte �r registrerade visa en lista p� listor som dom kan prenumerera p� med arkivknapp f�r nyhetsbrev eller ett login formul�r s� dom kan registrera sig.'));
define('_ACA_CONFIG_UPDATED', compa::encodeutf('Konfigurations detaljerna har uppdaterats!'));
define('_ACA_UPDATE_URL', compa::encodeutf('Uppdatera URL'));
define('_ACA_UPDATE_URL_WARNING', compa::encodeutf('VARNING! �ndra inte p� denna URL om du inte har blivit tillsagd av Acajoom tekniska team att g�ra s�.<br />'));
define('_ACA_UPDATE_URL_TIPS', compa::encodeutf('Som exempel: http://www.ijoobi.com/update/ (inkludera det avslutande slashen)'));

// module
define('_ACA_EMAIL_INVALID', compa::encodeutf('E-posten som angavs �r felaktig.'));
define('_ACA_REGISTER_REQUIRED', compa::encodeutf('Var v�nlig och registrera dig p� hemsidan innan du kan anm�la dig som prenumerant.'));

// Access level box
define('_ACA_OWNER', compa::encodeutf('Skapare av lista:'));
define('_ACA_ACCESS_LEVEL', compa::encodeutf('St�ll in beh�righetsniv� f�r listan'));
define('_ACA_ACCESS_LEVEL_OPTION', compa::encodeutf('Beh�righetsniv� Val'));
define('_ACA_USER_LEVEL_EDIT', compa::encodeutf('V�lj vilken anv�ndarniv� som till�ter redigering av mailen (antingen fr�n f�rstasidan eller backend) '));

//  drop down options
define('_ACA_AUTO_DAY_CH1', compa::encodeutf('Daglig'));
define('_ACA_AUTO_DAY_CH2', compa::encodeutf('Daglig ingen helg'));
define('_ACA_AUTO_DAY_CH3', compa::encodeutf('Varannan dag'));
define('_ACA_AUTO_DAY_CH4', compa::encodeutf('Varannan dag ingen helg'));
define('_ACA_AUTO_DAY_CH5', compa::encodeutf('Veckovis'));
define('_ACA_AUTO_DAY_CH6', compa::encodeutf('Varannan vecka'));
define('_ACA_AUTO_DAY_CH7', compa::encodeutf('M�nadsvis'));
define('_ACA_AUTO_DAY_CH9', compa::encodeutf('�rligt'));
define('_ACA_AUTO_OPTION_NONE', compa::encodeutf('Nej'));
define('_ACA_AUTO_OPTION_NEW', compa::encodeutf('Nya Anv�ndare'));
define('_ACA_AUTO_OPTION_ALL', compa::encodeutf('Alla Anv�ndare'));

//
define('_ACA_UNSUB_MESSAGE', compa::encodeutf('Prenumerera Ej E-post'));
define('_ACA_UNSUB_SETTINGS', compa::encodeutf('Prenumerera Ej Inst�llningar'));
define('_ACA_AUTO_ADD_NEW_USERS', compa::encodeutf('Auto Prenumerera Anv�ndare?'));

// Update and upgrade messages
define('_ACA_NO_UPDATES', compa::encodeutf('Det finns f�rn�rvarande inga uppdateringar tillg�ngliga.'));
define('_ACA_VERSION', compa::encodeutf('Acajoom Version'));
define('_ACA_NEED_UPDATED', compa::encodeutf('Filer som beh�ver uppdateras:'));
define('_ACA_NEED_ADDED', compa::encodeutf('Filer som beh�ver l�ggas till:'));
define('_ACA_NEED_REMOVED', compa::encodeutf('Filer som beh�ver tas bort:'));
define('_ACA_FILENAME', compa::encodeutf('Filnamn:'));
define('_ACA_CURRENT_VERSION', compa::encodeutf('Nuvarande version:'));
define('_ACA_NEWEST_VERSION', compa::encodeutf('Senaste version:'));
define('_ACA_UPDATING', compa::encodeutf('Uppdaterar'));
define('_ACA_UPDATE_UPDATED_SUCCESSFULLY', compa::encodeutf('Filerna har uppdaterats.'));
define('_ACA_UPDATE_FAILED', compa::encodeutf('Uppdatering misslyckades!'));
define('_ACA_ADDING', compa::encodeutf('L�gger till'));
define('_ACA_ADDED_SUCCESSFULLY', compa::encodeutf('Tillagda.'));
define('_ACA_ADDING_FAILED', compa::encodeutf('Till�ggning misslyckades!'));
define('_ACA_REMOVING', compa::encodeutf('Tar bort'));
define('_ACA_REMOVED_SUCCESSFULLY', compa::encodeutf('Togs bort.'));
define('_ACA_REMOVING_FAILED', compa::encodeutf('Borttagning misslyckades!'));
define('_ACA_INSTALL_DIFFERENT_VERSION', compa::encodeutf('Installera en annan version'));
define('_ACA_CONTENT_ADD', compa::encodeutf('Skapa inneh�ll'));
define('_ACA_UPGRADE_FROM', compa::encodeutf('Importera data (nyhetsbrev och prenumeranter\' information) fr�n '));
define('_ACA_UPGRADE_MESS', compa::encodeutf('Det finns ingen risk f�r din existerande data. <br /> Denna process kommer importera data till Acajoom databasen.'));
define('_ACA_CONTINUE_SENDING', compa::encodeutf('Forts�tt skicka'));

// Acajoom message
define('_ACA_UPGRADE1', compa::encodeutf('Du kan enkelt importera dina anv�ndare och nyhetsbrev fr�n '));
define('_ACA_UPGRADE2', compa::encodeutf(' till Acajoom i uppdateringspanelen.'));
define('_ACA_UPDATE_MESSAGE', compa::encodeutf('En ny version av Acajoom finns tillg�nglig! '));
define('_ACA_UPDATE_MESSAGE_LINK', compa::encodeutf('Klicka h�r f�r att uppdatera!'));
define('_ACA_CRON_SETUP', compa::encodeutf('F�r att autorespondrarna ska skickas s� beh�ver du st�lla in en cron uppgift.'));
define('_ACA_THANKYOU', compa::encodeutf('Tack f�r att du valde Acajoom, Din kommunikationspartner!'));
define('_ACA_NO_SERVER', compa::encodeutf('Uppdatering av Server �r inte tillg�nglig, var god och f�rs�k senare.'));
define('_ACA_MOD_PUB', compa::encodeutf('Acajoom modulen �r inte publicerad.'));
define('_ACA_MOD_PUB_LINK', compa::encodeutf('Klicka h�r f�r att publicera den!'));
define('_ACA_IMPORT_SUCCESS', compa::encodeutf('Importerades'));
define('_ACA_IMPORT_EXIST', compa::encodeutf('Prenumeranten finns redan i databasen'));


// Acajoom's Guide
define('_ACA_GUIDE', compa::encodeutf('\'s Wizard'));
define('_ACA_GUIDE_FIRST_ACA_STEP', compa::encodeutf('<p>Acajoom har m�nga stora f�rdelar och denna wizard kommer att guida dig igenom fyra enkla steg f�r att hj�lpa dig att komma ig�ng med s�ndning av ditt nyhetsbrev och auto-respondrar!<p />'));
define('_ACA_GUIDE_FIRST_ACA_STEP_DESC', compa::encodeutf('F�rsta, du beh�ver skapa en lista.  En lista kan vara av tv� typer, antingen ett nyhetsbrev eller en auto-responder.' .
		'  I listan som du definerar alla m�jliga parametrar f�r att aktivera s�ndning av ditt nyhetsbrev eller auto-respondrar: avs�ndarens namn, layout, prenumeranter\' v�lkomst meddelande, etc...
<br /><br />Du kan st�lla in din f�rsta lista h�r: <a href="index2.php?option=com_acajoom&act=list" >skapa en lista</a> och klicka p� Ny knappen.'));
define('_ACA_GUIDE_FIRST_ACA_STEP_UPGRADE', compa::encodeutf('Acajoom tillhandah�ller dig med en enkel v�g genom att importera all data fr�n ett tidigare nyhetsbrevssystem.<br />' .
		' G� till Uppdaterapanelen och v�lj ditt tidigare nyhetsbrevssystem att importera alla dina nyhetsbrev och prenumeranter.<br /><br />' .
		'<span style="color:#FF5E00;" >VIKTIGT: importeringen �r riskfri och p�verkar inte p� n�got sett data fr�n ditt tidigare nyhetsbrevssystem</span><br />' .
		'Efter importering s� kommer du ha m�jlighet att hantera dina prenumeranter och mailen direkt genom Acajoom.<br /><br />'));
define('_ACA_GUIDE_SECOND_ACA_STEP', compa::encodeutf('Kanon din f�rsta lista �r inst�lld!  Du kan nu skriva din f�rsta %s.  F�r att skapa den g� till: '));
define('_ACA_GUIDE_SECOND_ACA_STEP_AUTO', compa::encodeutf('Auto-responder Hanterare'));
define('_ACA_GUIDE_SECOND_ACA_STEP_NEWS', compa::encodeutf('Nyhetsbrevs Hanterare'));
define('_ACA_GUIDE_SECOND_ACA_STEP_FINAL', compa::encodeutf(' och v�lj din %s. <br /> Sedan s� v�ljer du din %s i drop down listan.  Skapa din f�rsta mail genom att klicka p� Ny '));

define('_ACA_GUIDE_THRID_ACA_STEP_NEWS', compa::encodeutf('Innan du skickar ditt f�rsta nyhetsbrev s� ska du kolla genom mail konfigurationen.  ' .
		'G� till <a href="index2.php?option=com_acajoom&act=configuration" >konfigurations sidan</a> f�r att verifiera mail inst�llningarna. <br />'));
define('_ACA_GUIDE_THRID2_ACA_STEP_NEWS', compa::encodeutf('<br />N�r du �r klar g� tillbaka till Nyhetsbrevs menyn, v�lj din mail och klicka sedan p� Skicka'));

define('_ACA_GUIDE_THRID_ACA_STEP_AUTOS', compa::encodeutf('F�r att dina auto-respondrar ska s�ndas s� beh�ver du f�rst st�lla in en cron uppgift p� din server. ' .
		' Referera till Cron tabben i konfigurationspanelen.' .
		' <a href="index2.php?option=com_acajoom&act=configuration" >klicka h�r</a> f�r att l�ra dig om hur man st�ller in en cron uppgift. <br />'));

define('_ACA_GUIDE_MODULE', compa::encodeutf(' <br />Kolla �ven upp att du har publicerat Acajoom modulen s� personer kan skriva in sig f�r prenumerationer.'));

define('_ACA_GUIDE_FOUR_ACA_STEP_NEWS', compa::encodeutf(' Du kan nu ocks� st�lla in en auto-responder.'));
define('_ACA_GUIDE_FOUR_ACA_STEP_AUTOS', compa::encodeutf(' Du kan nu ocks� st�lla in ett nyhetsbrev.'));

define('_ACA_GUIDE_FOUR_ACA_STEP', compa::encodeutf('<p><br />Voila! Du �r nu redo f�r att effektivt kommunicera med dina bes�kare och anv�ndare. Denna wizard kommer att avslutas n�r du har fixat din andra omg�ng med mail eller s� kan du st�nga av det i <a href="index2.php?option=com_acajoom&act=configuration" >konfigurationspanelen</a>.' .
		'<br /><br />  Om du har n�gra fr�gor medans du anv�nder Acajoom, refera till ' .
		'<a target="_blank" href="http://www.ijoobi.com/index.php?option=com_agora&Itemid=60" >forum</a>. ' .
		' Du hittar �ven massor med information p� hur du kommunicerar effektivt med dina prenumeranter p� <a href="http://www.ijoobi.com/" target="_blank">www.ijoobi.com</a>.' .
		'<p /><br /><b>Tack f�r att du anv�nder Acajoom. Din Kommunikations Partner!</b> '));
define('_ACA_GUIDE_TURNOFF', compa::encodeutf('Wizarden st�ngs nu av!'));
define('_ACA_STEP', compa::encodeutf('STEG '));

// Acajoom Install
define('_ACA_INSTALL_CONFIG', compa::encodeutf('Acajoom Konfiguration'));
define('_ACA_INSTALL_SUCCESS', compa::encodeutf('Installerades'));
define('_ACA_INSTALL_ERROR', compa::encodeutf('Installations Fel'));
define('_ACA_INSTALL_BOT', compa::encodeutf('Acajoom Plugin (Bot)'));
define('_ACA_INSTALL_MODULE', compa::encodeutf('Acajoom Modul'));
//Others
define('_ACA_JAVASCRIPT', compa::encodeutf('!Varning! Javascript m�ste vara aktiverat f�r en fungerande operation.'));
define('_ACA_EXPORT_TEXT', compa::encodeutf('Prenumeranterna som exporterades baseras p� listan som du angav. <br />Exportera prenumeranter f�r lista'));
define('_ACA_IMPORT_TIPS', compa::encodeutf('Importera prenumeranter. Informationen i filen beh�ver vara i f�ljande format: <br />' .
		'Namn,e-post,mottaHTML(1/0),<span style="color: rgb(255, 0, 0);">bekr�ftad(1/0)</span>'));
define('_ACA_SUBCRIBER_EXIT', compa::encodeutf('�r redan en prenumerant'));
define('_ACA_GET_STARTED', compa::encodeutf('Klicka h�r f�r att k�ra ig�ng!'));

//News since 1.0.1
define('_ACA_WARNING_1011', compa::encodeutf('Varning: 1011: Uppdatera kommer inte att fungera p� grund av dina server restrektioner.'));
define('_ACA_SEND_MAIL_FROM_TIPS', compa::encodeutf('used as Bounced back for all your messages'));
define('_ACA_SEND_MAIL_NAME_TIPS', compa::encodeutf('V�lj vilket namn som ska visas som avs�ndare.'));
define('_ACA_MAILSENDMETHOD_TIPS', compa::encodeutf('V�lj vilken mail som du vill ska anv�ndas: PHP mail funktion, <span>Sendmail</span> eller SMTP Server.'));
define('_ACA_SENDMAILPATH_TIPS', compa::encodeutf('Detta �r mappen till Mailservern'));
define('_ACA_LIST_T_TEMPLATE', compa::encodeutf('Mall'));
define('_ACA_NO_MAILING_ENTERED', compa::encodeutf('Inget mailande tillhandah�lls'));
define('_ACA_NO_LIST_ENTERED', compa::encodeutf('Ingen lista tillhandah�lls'));
define('_ACA_SENT_MAILING', compa::encodeutf('Skickade mail'));
define('_ACA_SELECT_FILE', compa::encodeutf('V�lj en fil att '));
define('_ACA_LIST_IMPORT', compa::encodeutf('Kolla lista(or) som du vill att prenumeranter ska associeras med.'));
define('_ACA_PB_QUEUE', compa::encodeutf('Prenumerant inlagd men problem att ansluta han/henne till lista(or). Kolla manuellt.'));
define('_ACA_UPDATE_MESS', compa::encodeutf(''));
define('_ACA_UPDATE_MESS1', compa::encodeutf('Uppdatering rekommenderas Mycket!'));
define('_ACA_UPDATE_MESS2', compa::encodeutf('Patch och sm� �tg�rder.'));
define('_ACA_UPDATE_MESS3', compa::encodeutf('Ny utg�va.'));
define('_ACA_UPDATE_MESS5', compa::encodeutf('Joomla 1.5 beh�vs f�r att kunna uppdatera.'));
define('_ACA_UPDATE_IS_AVAIL', compa::encodeutf(' fins tillg�nglig!'));
define('_ACA_NO_MAILING_SENT', compa::encodeutf('Inga mail skickade!'));
define('_ACA_SHOW_LOGIN', compa::encodeutf('Visa logga in formul�r'));
define('_ACA_SHOW_LOGIN_TIPS', compa::encodeutf('V�lj Ja f�r att visa ett logga in formul�r i f�rstaside Acajoom kontrollpanelen s� att anv�ndare kan registrera sig p� hemsidan.'));
define('_ACA_LISTS_EDITOR', compa::encodeutf('Listans Beskrivnings Redigerare'));
define('_ACA_LISTS_EDITOR_TIPS', compa::encodeutf('V�lj Ja f�r att anv�nda en HTML redigerare f�r att redigera listans beskrivningsf�lt.'));
define('_ACA_SUBCRIBERS_VIEW', compa::encodeutf('Visa prenumeranter'));

//News since 1.0.2
define('_ACA_FRONTEND_SETTINGS', compa::encodeutf('F�rstaside Inst�llningar'));
define('_ACA_SHOW_LOGOUT', compa::encodeutf('Visa logga ut knapp'));
define('_ACA_SHOW_LOGOUT_TIPS', compa::encodeutf('V�lj Ja f�r att visa en logga ut knapp P� f�rstasidans Acajoom kontrollpanel.'));

//News since 1.0.3 CB integration
define('_ACA_CONFIG_INTEGRATION', compa::encodeutf('Integration'));
define('_ACA_CB_INTEGRATION', compa::encodeutf('Community Builder Integrering'));
define('_ACA_INSTALL_PLUGIN', compa::encodeutf('Community Builder Plugin (Acajoom
Integrering) '));
define('_ACA_CB_PLUGIN_NOT_INSTALLED', compa::encodeutf('Acajoom Plugin f�r Community Builder �r �nnu inte installerad!'));
define('_ACA_CB_PLUGIN', compa::encodeutf('Listor vid registrering'));
define('_ACA_CB_PLUGIN_TIPS', compa::encodeutf('V�lj Ja f�r att visa maillistor i community builders registrerings formul�r'));
define('_ACA_CB_LISTS', compa::encodeutf('List ID:er'));
define('_ACA_CB_LISTS_TIPS', compa::encodeutf('DETTA �R ETT OBLIGATORISKT F�LT. Skriv in id nummer p� listor som du vill att anv�ndare ska ha till�telse att prenumerera p� separera med kommatecken,  (0 visa alla listor)'));
define('_ACA_CB_INTRO', compa::encodeutf('Introduktionstext'));
define('_ACA_CB_INTRO_TIPS', compa::encodeutf('En text som visas kommer att visas f�re listorna. L�MNA TOMT F�R ATT INTE VISA N�GONTING. Anv�nd cb_f�rtext f�r CSS layout.'));
define('_ACA_CB_SHOW_NAME', compa::encodeutf('Visa Listnamn'));
define('_ACA_CB_SHOW_NAME_TIPS', compa::encodeutf('V�lj om namnet p� listan ska visas efter introduktionen.'));
define('_ACA_CB_LIST_DEFAULT', compa::encodeutf('Kolla lista som standard'));
define('_ACA_CB_LIST_DEFAULT_TIPS', compa::encodeutf('V�lj om du vill att kryssrutan f�r varje lista ska kollas som standard.'));
define('_ACA_CB_HTML_SHOW', compa::encodeutf('Visa Mottag HTML'));
define('_ACA_CB_HTML_SHOW_TIPS', compa::encodeutf('St�ll in till Ja f�r att till�ta anv�ndare att besluta om dom ska ha HTML e-post eller inte. St�ll in till Nej f�r att anv�nda mottag html som standard.'));
define('_ACA_CB_HTML_DEFAULT', compa::encodeutf('Standard Mottag HTML'));
define('_ACA_CB_HTML_DEFAULT_TIPS', compa::encodeutf('St�ll in detta alternativ f�r att visa standard html mail konfiguration. Om Visa Mottag HTML �r inst�llt till Nej s� kommer detta val att vara standard.'));

// Since 1.0.4
define('_ACA_BACKUP_FAILED', compa::encodeutf('Kunde inte g�ra en backup p� filen! Filen ersattes inte.'));
define('_ACA_BACKUP_YOUR_FILES', compa::encodeutf('De �ldre versionsfilerna har backats upp till f�ljande mapp:'));
define('_ACA_SERVER_LOCAL_TIME', compa::encodeutf('Server lokaltid'));
define('_ACA_SHOW_ARCHIVE', compa::encodeutf('Visa arkivknapp'));
define('_ACA_SHOW_ARCHIVE_TIPS', compa::encodeutf('V�lj Ja f�r att visa arkivknappen p� f�rstasidan i Nyhetsbrevslistan'));
define('_ACA_LIST_OPT_TAG', compa::encodeutf('Taggar'));
define('_ACA_LIST_OPT_IMG', compa::encodeutf('Bilder'));
define('_ACA_LIST_OPT_CTT', compa::encodeutf('Inneh�ll'));
define('_ACA_INPUT_NAME_TIPS', compa::encodeutf('Fyll i ditt fullst�ndiga namn (f�rnamnet f�rst)'));
define('_ACA_INPUT_EMAIL_TIPS', compa::encodeutf('Fyll i din e-postadress (Var noga med att detta �r en giltig e-postadress om du vill mottaga v�ra nyhetsbrev.)'));
define('_ACA_RECEIVE_HTML_TIPS', compa::encodeutf('V�lj Ja om du vill mottaga HTML mail - Nej f�r att mottaga endast Text mail'));
define('_ACA_TIME_ZONE_ASK_TIPS', compa::encodeutf('Specificera din tidszon.'));

// Since 1.0.5
define('_ACA_FILES', compa::encodeutf('Filer'));
define('_ACA_FILES_UPLOAD', compa::encodeutf('Ladda Upp'));
define('_ACA_MENU_UPLOAD_IMG', compa::encodeutf('Ladda Upp Bilder'));
define('_ACA_TOO_LARGE', compa::encodeutf('Filstorleken �r f�r stor. Den till�tna maximala storleken �r'));
define('_ACA_MISSING_DIR', compa::encodeutf('Destinations mappen existerar inte'));
define('_ACA_IS_NOT_DIR', compa::encodeutf('Destinations mappen existerar inte eller �r inte en ordin�r fil.'));
define('_ACA_NO_WRITE_PERMS', compa::encodeutf('Destinations mappen �r skrivskyddad.'));
define('_ACA_NO_USER_FILE', compa::encodeutf('Du har inte valt en fil att ladda upp.'));
define('_ACA_E_FAIL_MOVE', compa::encodeutf('Om�jligt att flytta filen.'));
define('_ACA_FILE_EXISTS', compa::encodeutf('Destinationsfilen finns redan.'));
define('_ACA_CANNOT_OVERWRITE', compa::encodeutf('Destinationsfilen finns redan och kan d�rf�r inte skrivas �ver.'));
define('_ACA_NOT_ALLOWED_EXTENSION', compa::encodeutf('Fil�ndelsen �r inte till�ten.'));
define('_ACA_PARTIAL', compa::encodeutf('Filen laddades delvis bara upp.'));
define('_ACA_UPLOAD_ERROR', compa::encodeutf('Uppladdningsfel:'));
define('DEV_NO_DEF_FILE', compa::encodeutf('Filen laddades delvis bara upp.'));

define('_ACA_CONTENTREP', compa::encodeutf('[SUBSCRIPTIONS] = Detta kommer att ers�ttas med prenumerationsl�nkar.' .
		'Detta �r <strong>n�dv�ndigt</strong> f�r att Acajoom ska fungera korrekt.<br />' .
		'Om du placerar annat inneh�ll i denna ruta s� kommer det att visas i alla mail som h�nvisas till denna lista.' .
		' <br />Infoga ditt prenumerations meddelande i slutet.  Acajoom kommer automatiskt att l�gga till en l�nk f�r prenumeranten att �ndra sin information och en l�nk f�r att sluta prenumera fr�n listan.'));

// since 1.0.6
define('_ACA_NOTIFICATION', compa::encodeutf('Meddelande'));  // shortcut for Email notification
define('_ACA_NOTIFICATIONS', compa::encodeutf('Meddelanden'));
define('_ACA_USE_SEF', compa::encodeutf('SEF i mail'));
define('_ACA_USE_SEF_TIPS', compa::encodeutf('Det �r rekommenderat att du v�ljer Nej.  Men om du vill att URL,en ska inkluderas i din mail f�r att anv�nda SEF v�lj d� Ja.' .
		' <br /><b>L�nkarna fungerar p� samma sett oavsett val.  Nej kommer att f�rs�kra dig att l�nkarna i mailen kommer alltid att fungera �ven om du �ndrar din SEF.</b> '));
define('_ACA_ERR_NB', compa::encodeutf('Fel #: ERR'));
define('_ACA_ERR_SETTINGS', compa::encodeutf('Felhanterings inst�llningar'));
define('_ACA_ERR_SEND', compa::encodeutf('Skicka felrapport'));
define('_ACA_ERR_SEND_TIPS', compa::encodeutf('Om du vill att Acajoom ska bli en b�ttre produkt v�lj JA.  Detta kommer att s�nda oss en felrapport.  S� du beh�ver inte sj�lv rapportera buggar l�ngre ;-) <br /> <b>INGEN PRIVAT INFORMATION KOMMER ATT SKICKAS</b>.  Vi vet inte ens fr�n vilken hemsida felet kommer ifr�n. Vi skickar endast information om Acajoom, PHP inst�llningarna och SQL fr�gor. '));
define('_ACA_ERR_SHOW_TIPS', compa::encodeutf('V�lj Ja f�r att visa felnummer p� sk�rmen.  Anv�nds oftast f�r att avbuggnings syfte. '));
define('_ACA_ERR_SHOW', compa::encodeutf('Visa fel'));
define('_ACA_LIST_SHOW_UNSUBCRIBE', compa::encodeutf('Visa prenumerera Inte l�nkar'));
define('_ACA_LIST_SHOW_UNSUBCRIBE_TIPS', compa::encodeutf('V�lj Ja f�r att visa prenumerera Inte l�nkar i botten av mailen f�r anv�ndare f�r m�jligheten att �ndra sina prenumerationer. <br /> Nej avaktivera footer och l�nkar.'));
define('_ACA_UPDATE_INSTALL', compa::encodeutf('<span style="color: rgb(255, 0, 0);">VIKTIGT MEDDELANDE!</span> <br />Om du uppgraderar fr�n en tidigare version av Acajoom installation s� beh�ver du �ven uppgradera din databas struktur genom att klicka p� f�ljande knapp (Din data kommer fortfarande att vara fullst�ndig)'));
define('_ACA_UPDATE_INSTALL_BTN', compa::encodeutf('Uppgradera tabeller och konfiguration'));
define('_ACA_MAILING_MAX_TIME', compa::encodeutf('Max k�tid'));
define('_ACA_MAILING_MAX_TIME_TIPS', compa::encodeutf('Definera den maximala tiden f�r varje mailutskick skickad av k�n. Rekommenderat mellan 30 s och 2 min.'));

// virtuemart integration beta
define('_ACA_VM_INTEGRATION', compa::encodeutf('VirtueMart Integrering'));
define('_ACA_VM_COUPON_NOTIF', compa::encodeutf('Kupong meddelande ID'));
define('_ACA_VM_COUPON_NOTIF_TIPS', compa::encodeutf('Specificera ID numret av mail som du vill anv�nda f�r att skicka kuponger till dina k�pare.'));
define('_ACA_VM_NEW_PRODUCT', compa::encodeutf('Ny produkt meddelande ID'));
define('_ACA_VM_NEW_PRODUCT_TIPS', compa::encodeutf('Specificera ID numret av mail som du vill anv�nda f�r att skicka ny produkt meddelande.'));

// since 1.0.8
// create forms for subscriptions
define('_ACA_FORM_BUTTON', compa::encodeutf('Skapa formul�r'));
define('_ACA_FORM_COPY', compa::encodeutf('HTML kod'));
define('_ACA_FORM_COPY_TIPS', compa::encodeutf('Kopiera den generade HTML koden till din HTML sida.'));
define('_ACA_FORM_LIST_TIPS', compa::encodeutf('V�lj listan som du vill inkludera i forml�ret'));
// update messages
define('_ACA_UPDATE_MESS4', compa::encodeutf('Det kan inte uppdateras automatiskt.'));
define('_ACA_WARNG_REMOTE_FILE', compa::encodeutf('Ingen m�jlighet att komma �t den fj�rranv�nda filen.'));
define('_ACA_ERROR_FETCH', compa::encodeutf('Fel vid h�mtning av fil.'));

define('_ACA_CHECK', compa::encodeutf('Kolla'));
define('_ACA_MORE_INFO', compa::encodeutf('Mer info'));
define('_ACA_UPDATE_NEW', compa::encodeutf('Uppdatera till en nyare version'));
define('_ACA_UPGRADE', compa::encodeutf('Uppgradera till en h�gre produkt'));
define('_ACA_DOWNDATE', compa::encodeutf('�terg� till f�reg�ende version'));
define('_ACA_DOWNGRADE', compa::encodeutf('Tillbaka till standard produkten'));
define('_ACA_REQUIRE_JOOM', compa::encodeutf('Beh�ver Joomla'));
define('_ACA_TRY_IT', compa::encodeutf('Prova p�!'));
define('_ACA_NEWER', compa::encodeutf('Nyare'));
define('_ACA_OLDER', compa::encodeutf('�ldre'));
define('_ACA_CURRENT', compa::encodeutf('Nuvarande'));

// since 1.0.9
define('_ACA_CHECK_COMP', compa::encodeutf('Prova n�gon annan komponent'));
define('_ACA_MENU_VIDEO', compa::encodeutf('Video undervisning'));
define('_ACA_AUTO_SCHEDULE', compa::encodeutf('Schema'));
define('_ACA_SCHEDULE_TITLE', compa::encodeutf('Automatiska schemafunktions inst�llningar'));
define('_ACA_ISSUE_NB_TIPS', compa::encodeutf('Utf�rdar nummer generades automatiskt av systemet'));
define('_ACA_SEL_ALL', compa::encodeutf('Alla mail'));
define('_ACA_SEL_ALL_SUB', compa::encodeutf('Alla listor'));
define('_ACA_INTRO_ONLY_TIPS', compa::encodeutf('Om du markerar denna ruta s� kommer endast introduktionen av artikeln att s�ttas in i mailet med en l�s mer l�nk f�r att se hela artikeln p� din sida.'));
define('_ACA_TAGS_TITLE', compa::encodeutf('Inneh�llstagg'));
define('_ACA_TAGS_TITLE_TIPS', compa::encodeutf('Kopiera och klistra denna tagg i ditt mail d�r du vill ha inneh�llet placerat.'));
define('_ACA_PREVIEW_EMAIL_TEST', compa::encodeutf('Markera emailadressen att skicka testet till'));
define('_ACA_PREVIEW_TITLE', compa::encodeutf('F�rhandsgranska'));
define('_ACA_AUTO_UPDATE', compa::encodeutf('Nytt uppdaterings meddelande'));
define('_ACA_AUTO_UPDATE_TIPS', compa::encodeutf('V�lj Ja om du vill bli meddelad vid nya uppdateringar f�r din komponent. <br />VIKTIGT!! Visa tips beh�ver vara p� f�r att denna funktion ska fungera.'));

// since 1.1.0
define('_ACA_LICENSE', compa::encodeutf('Licens Information'));


// since 1.1.1
define('_ACA_NEW', compa::encodeutf('Ny'));
define('_ACA_SCHEDULE_SETUP', compa::encodeutf('F�r att autorespondrarna ska skickas s� beh�ver du st�lla in schemat i konfigurationen.'));
define('_ACA_SCHEDULER', compa::encodeutf('Schema'));
define('_ACA_ACAJOOM_CRON_DESC', compa::encodeutf('om du inte har tillg�ng till cron hanteraren p� din hemsida, s� kan du registrera dig f�r ett fritt Acajoom Cron konto hos:'));
define('_ACA_CRON_DOCUMENTATION', compa::encodeutf('Du kan hitta ytterliggare information om att st�lla in Acajoom Schemat vid f�ljande url:'));
define('_ACA_CRON_DOC_URL', compa::encodeutf('<a href="http://www.ijoobi.com/index.php?option=com_content&view=article&id=4249&catid=29&Itemid=72"
 target="_blank">http://www.ijoobi.com/index.php?option=com_content&Itemid=72&view=category&layout=blog&id=29&limit=60</a>'));
define( '_ACA_QUEUE_PROCESSED', compa::encodeutf('K� behandling lyckades...'));
define( '_ACA_ERROR_MOVING_UPLOAD', compa::encodeutf('Fel vid flytt av importerad fil'));

//since 1.1.4
define( '_ACA_SCHEDULE_FREQUENCY', compa::encodeutf('Schema frekvens'));
define( '_ACA_CRON_MAX_FREQ', compa::encodeutf('Schemats maximala frekvens'));
define( '_ACA_CRON_MAX_FREQ_TIPS', compa::encodeutf('Specificera den maximala frekvensen som schemat kan k�ra ( i minuter ).  Detta kommer att begr�nsa schemat �ven om cron hanteraren �r uppsatt mer frekvent.'));
define( '_ACA_CRON_MAX_EMAIL', compa::encodeutf('Maximala antalet mail per uppgift'));
define( '_ACA_CRON_MAX_EMAIL_TIPS', compa::encodeutf('Specificera det maximala antalet mail s�nda per uppgift (0 obegr�nsat).'));
define( '_ACA_CRON_MINUTES', compa::encodeutf(' minuter'));
define( '_ACA_SHOW_SIGNATURE', compa::encodeutf('Visa mailfooter'));
define( '_ACA_SHOW_SIGNATURE_TIPS', compa::encodeutf('Oavsett om du vill eller inte vill promota Acajoom i footern av dina mail.'));
define( '_ACA_QUEUE_AUTO_PROCESSED', compa::encodeutf('Auto-responder behandling lyckades...'));
define( '_ACA_QUEUE_NEWS_PROCESSED', compa::encodeutf('Schemalagd nyhetsbrevsbehandling lyckades...'));
define( '_ACA_MENU_SYNC_USERS', compa::encodeutf('Synkronisera Anv�ndare'));
define( '_ACA_SYNC_USERS_SUCCESS', compa::encodeutf('Anv�ndar Synkroniseringen Lyckades!'));

// compatibility with Joomla 15
if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', compa::encodeutf('Logga Ut'));
if (!defined('_CMN_YES')) define( '_CMN_YES', compa::encodeutf('Ja'));
if (!defined('_CMN_NO')) define( '_CMN_NO', compa::encodeutf('Nej'));
if (!defined('_HI')) define( '_HI', compa::encodeutf('Hej'));
if (!defined('_CMN_TOP')) define( '_CMN_TOP', compa::encodeutf('Topp'));
if (!defined('_CMN_BOTTOM')) define( '_CMN_BOTTOM', compa::encodeutf('Botten'));
//if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', compa::encodeutf('Logout'));

// For include title only or full article in content item tab in newsletter edit - p0stman911
define('_ACA_TITLE_ONLY_TIPS', compa::encodeutf('Om du v�ljer detta s� kommer endast titeln i artikeln att s�ttas in i mailet som en l�nk till den kompletta artikeln p� din sida.'));
define('_ACA_TITLE_ONLY', compa::encodeutf('Endast Titel'));
define('_ACA_FULL_ARTICLE_TIPS', compa::encodeutf('Om du v�ljer detta s� kommer hela artiklen att s�ttas in i mailet'));
define('_ACA_FULL_ARTICLE', compa::encodeutf('Hel Artikel'));
define('_ACA_CONTENT_ITEM_SELECT_T', compa::encodeutf('V�lj ett inneh�llsobjekt att visas i meddelandet. <br />Kopiera och klistra <b>inneh�lls taggen</b> i mailet.  Du kan v�lja att ha hela texten, endast intro, eller endast titel med (0, 1, eller 2 var f�r sig). '));
define('_ACA_SUBSCRIBE_LIST2', compa::encodeutf('Mail lista(or)'));

// smart-newsletter function
define('_ACA_AUTONEWS', compa::encodeutf('Smart-Nyhetsbrev'));
define('_ACA_MENU_AUTONEWS', compa::encodeutf('Smart-Nyhetsbrev'));
define('_ACA_AUTO_NEWS_OPTION', compa::encodeutf('Smart-Nyhetsbrevs val'));
define('_ACA_AUTONEWS_FREQ', compa::encodeutf('Nyhetsbrevs Frekvens'));
define('_ACA_AUTONEWS_FREQ_TIPS', compa::encodeutf('Specificera frekvensen som du vill skicka smart-nyhetsbrevet.'));
define('_ACA_AUTONEWS_SECTION', compa::encodeutf('Artikel Sektion'));
define('_ACA_AUTONEWS_SECTION_TIPS', compa::encodeutf('Specificera sektionen som du vill v�lja artiklar ifr�n.'));
define('_ACA_AUTONEWS_CAT', compa::encodeutf('Artikel Kategori'));
define('_ACA_AUTONEWS_CAT_TIPS', compa::encodeutf('Specificera kategorin som du vill v�lja artiklar ifr�n (Alla f�r alla artiklar i den sektionen).'));
define('_ACA_SELECT_SECTION', compa::encodeutf('V�lj en sektion'));
define('_ACA_SELECT_CAT', compa::encodeutf('Alla Kategorier'));
define('_ACA_AUTO_DAY_CH8', compa::encodeutf('Kvartalsvis'));
define('_ACA_AUTONEWS_STARTDATE', compa::encodeutf('Start datum'));
define('_ACA_AUTONEWS_STARTDATE_TIPS', compa::encodeutf('Specificera datumet som du vill starta s�ndning av Smart Nyhetsbrev.'));
define('_ACA_AUTONEWS_TYPE', compa::encodeutf('Inneh�lls �tergivning'));// how we see the content which is included in the newsletter
define('_ACA_AUTONEWS_TYPE_TIPS', compa::encodeutf('Hel Artikel: kommer att inkludera hela artikeln i nyhetsbrevet.<br />' .
		'Endast Intro: kommer endast att inkludera introduktionen av artikeln i nyhetsbrevet.<br/>' .
		'Endast Titel: kommer endast att inkludera titeln p� artikeln i nyhetsbrevet.'));
define('_ACA_TAGS_AUTONEWS', compa::encodeutf('[SMARTNYHETSBREV] = Detta kommer att ers�ttas med Smart-nyhetsbrevet.'));

//since 1.1.3
define('_ACA_MALING_EDIT_VIEW', compa::encodeutf('Skapa / Visa Mail'));
define('_ACA_LICENSE_CONFIG', compa::encodeutf('Licens'));
define('_ACA_ENTER_LICENSE', compa::encodeutf('Fyll i licens'));
define('_ACA_ENTER_LICENSE_TIPS', compa::encodeutf('Fyll i ditt licensnummer och tryck p� spara.'));
define('_ACA_LICENSE_SETTING', compa::encodeutf('Licensinst�llningar'));
define('_ACA_GOOD_LIC', compa::encodeutf('Din licens �r giltig.'));
define('_ACA_NOTSO_GOOD_LIC', compa::encodeutf('Din licens �r inte giltig: '));
define('_ACA_PLEASE_LIC', compa::encodeutf('Kontakta Acajoom support f�r att uppgradera din licens ( license@ijoobi.com ).'));

define('_ACA_DESC_PLUS', compa::encodeutf('Acajoom Plus �r den f�rsta auto-responder sekvensen f�r Joomla CMS.  ' . _ACA_FEATURES));
define('_ACA_DESC_PRO', compa::encodeutf('Acajoom PRO �r det ultimata mailsystemet f�r Joomla CMS.  ' . _ACA_FEATURES));

//since 1.1.4
define('_ACA_ENTER_TOKEN', compa::encodeutf('Fyll i bevis'));
define('_ACA_ENTER_TOKEN_TIPS', compa::encodeutf('Var v�nlig och fyll i ditt bevisnummer som du mottog via mail n�r du k�pte Acajoom. '));
define('_ACA_ACAJOOM_SITE', compa::encodeutf('Acajoom sidan:'));
define('_ACA_MY_SITE', compa::encodeutf('Min sida:'));
define( '_ACA_LICENSE_FORM', compa::encodeutf(' ' .
 		'Klicka h�r f�r att forts�tta till licensformul�ret.</a>'));
define('_ACA_PLEASE_CLEAR_LICENSE', compa::encodeutf('T�m licensf�ltet och prova p� nytt igen.<br />  Om problemet kvarst�r, '));
define( '_ACA_LICENSE_SUPPORT', compa::encodeutf('Om du fortfarande har fr�gor, ' . _ACA_PLEASE_LIC));
define( '_ACA_LICENSE_TWO', compa::encodeutf('du kan f� din licensmanual genom att fylla i bevisnumret och sidans URL (som �r belyst i gr�nt i toppen av denna sida) i Licensformul�ret. '
			. _ACA_LICENSE_FORM . '<br /><br/>' . _ACA_LICENSE_SUPPORT));
define('_ACA_ENTER_TOKEN_PATIENCE', compa::encodeutf('Efter att du sparat ditt bevis s� kommer en licens att automatiskt genereras. ' .
		' Vanligtvis s� �r blir beviset validerat inom 2 minuter.  Men, i vissa fall s� kan det ta upp till 15 minuter.<br />' .
		'<br />�terkom till denna kontrollpanel om ett par minuter.  <br /><br />' .
		'Om du inte mottagit en giltig licensnyckel inom 15 minuter, '. _ACA_LICENSE_TWO));
define( '_ACA_ENTER_NOT_YET', compa::encodeutf('Ditt bevis har �nnu inte blivit validerat.'));
define( '_ACA_UPDATE_CLICK_HERE', compa::encodeutf('Bes�k <a href="http://www.ijoobi.com" target="_blank">www.ijoobi.com</a> f�r att ladda ner den senaste versionen.'));
define( '_ACA_NOTIF_UPDATE', compa::encodeutf('F�r att bli meddelad om nya uppdateringar skriv in din emailadress och klicka p� prenumerera '));

define('_ACA_THINK_PLUS', compa::encodeutf('Om du vill f� ut mer av mailsystemet t�nk d� p� Plus!'));
define('_ACA_THINK_PLUS_1', compa::encodeutf('Auto-responder Sekvens'));
define('_ACA_THINK_PLUS_2', compa::encodeutf('Schemal�gg leveransen av ditt nyhetsbrev med ett f�rdefinerat datum'));
define('_ACA_THINK_PLUS_3', compa::encodeutf('Ingen mer serverbegr�nsning'));
define('_ACA_THINK_PLUS_4', compa::encodeutf('och mycket mer...'));


//since 1.2.2
define( '_ACA_LIST_ACCESS', compa::encodeutf('List �tkomst'));
define( '_ACA_INFO_LIST_ACCESS', compa::encodeutf('Specificera vilken grupp av anv�ndare som kan se och prenumerera p� denna lista'));
define( 'ACA_NO_LIST_PERM', compa::encodeutf('Du har inte tillr�cklig beh�righet f�r att prenumerera p� denna lista'));

//Archive Configuration
 define('_ACA_MENU_TAB_ARCHIVE', compa::encodeutf('Arkivera'));
 define('_ACA_MENU_ARCHIVE_ALL', compa::encodeutf('Arkivera Alla'));

//Archive Lists
 define('_FREQ_OPT_0', compa::encodeutf('Inga'));
 define('_FREQ_OPT_1', compa::encodeutf('Varje Vecka'));
 define('_FREQ_OPT_2', compa::encodeutf('Varannan Vecka'));
 define('_FREQ_OPT_3', compa::encodeutf('Varje M�nad'));
 define('_FREQ_OPT_4', compa::encodeutf('Varje Kvartal'));
 define('_FREQ_OPT_5', compa::encodeutf('Varje �r'));
 define('_FREQ_OPT_6', compa::encodeutf('Annat'));

define('_DATE_OPT_1', compa::encodeutf('Skapar datum'));
define('_DATE_OPT_2', compa::encodeutf('�ndrings datum'));

define('_ACA_ARCHIVE_TITLE', compa::encodeutf('St�ller in auto-arkiv frekvensen'));
define('_ACA_FREQ_TITLE', compa::encodeutf('Arkiv frekvens'));
define('_ACA_FREQ_TOOL', compa::encodeutf('Definera hur ofta som du vill att Arkiv Hanteraren ska arkivera din hemsidas inneh�ll.'));
define('_ACA_NB_DAYS', compa::encodeutf('Antal dagar'));
define('_ACA_NB_DAYS_TOOL', compa::encodeutf('Detta �r endast f�r Annat alternativet! Specificera antalet dagar mellan varje arkivering.'));
define('_ACA_DATE_TITLE', compa::encodeutf('Datumtyp'));
define('_ACA_DATE_TOOL', compa::encodeutf('Definera om arkiveringen ska ske vis skapardatumet eller vid �ndringsdatumet.'));

define('_ACA_MAINTENANCE_TAB', compa::encodeutf('Underh�llsinst�llningar'));
define('_ACA_MAINTENANCE_FREQ', compa::encodeutf('Underh�llsfrekvens'));
define( '_ACA_MAINTENANCE_FREQ_TIPS', compa::encodeutf('Specificera frekvensen som du vill att underh�llsrutinen ska k�ras.'));
define( '_ACA_CRON_DAYS', compa::encodeutf('timme(ar)'));

define( '_ACA_LIST_NOT_AVAIL', compa::encodeutf('Det finns ingen lista tillg�nglig.'));
define( '_ACA_LIST_ADD_TAB', compa::encodeutf('Skapa/Redigera'));

define( '_ACA_LIST_ACCESS_EDIT', compa::encodeutf('Mail Skapa/Redigera �tkomst'));
define( '_ACA_INFO_LIST_ACCESS_EDIT', compa::encodeutf('Specificera vilken grupp av anv�ndare som kan redigera nya mail f�r denna lista'));
define( '_ACA_MAILING_NEW_FRONT', compa::encodeutf('Skapa en Ny Mail'));

define('_ACA_AUTO_ARCHIVE', compa::encodeutf('Auto-Arkiv'));
define('_ACA_MENU_ARCHIVE', compa::encodeutf('Auto-Arkiv'));

//Extra tags:
define('_ACA_TAGS_ISSUE_NB', compa::encodeutf('[ISSUENB] = Detta kommer att ers�ttas av utg�vonumret p� nyhetsbrevet.'));
define('_ACA_TAGS_DATE', compa::encodeutf('[DATE] = Detta kommer att ers�ttas av s�ndningsdatum.'));
define('_ACA_TAGS_CB', compa::encodeutf('[CBTAG:{field_name}] = Detta kommer att ers�ttas av v�rdet som kommer fr�n Community Builder f�ltet: ex. [CBTAG:firstname] '));
define( '_ACA_MAINTENANCE', compa::encodeutf('Joobi Care'));


define('_ACA_THINK_PRO', compa::encodeutf('N�r du har professionella �nskem�l, s� anv�nder du professionella komponenter!'));
define('_ACA_THINK_PRO_1', compa::encodeutf('Smart-Nyhetsbrev'));
define('_ACA_THINK_PRO_2', compa::encodeutf('Definera �tkomstniv� f�r din lista'));
define('_ACA_THINK_PRO_3', compa::encodeutf('Definera vem som kan redigera/skapa mail'));
define('_ACA_THINK_PRO_4', compa::encodeutf('Mera taggar: skapa ditt CB f�lt'));
define('_ACA_THINK_PRO_5', compa::encodeutf('Joomla inneh�lls Auto-arkiv'));
define('_ACA_THINK_PRO_6', compa::encodeutf('Databasoptimering'));

define('_ACA_LIC_NOT_YET', compa::encodeutf('Din licens �r �nnu inte giltig.  Var v�nlig och unders�k licensfliken i konfigurationspanelen.'));
define('_ACA_PLEASE_LIC_GREEN', compa::encodeutf('Var noga med att ange den gr�na informationen vid toppen av fliken till v�rat supportteam.'));

define('_ACA_FOLLOW_LINK', compa::encodeutf('Skaffa Din Licens'));
define( '_ACA_FOLLOW_LINK_TWO', compa::encodeutf('Du kan f� din licens genom att fylla i bevisnumret och sidans URL (som belyses med gr�nt i toppen p� denna sida) i Licensformul�ret. '));
define( '_ACA_ENTER_TOKEN_TIPS2', compa::encodeutf(' Klicka sedan p� L�gg till knappen i den �vre h�gra menyn.'));
define( '_ACA_ENTER_LIC_NB', compa::encodeutf('Fyll i Din Licens'));
define( '_ACA_UPGRADE_LICENSE', compa::encodeutf('Uppgradera Din Licens'));
define( '_ACA_UPGRADE_LICENSE_TIPS', compa::encodeutf('Om du mottagit ett bevis f�r uppgradering av din licens var d� v�nlig och fyll i den h�r, klicka p� L�gg till och forts�tt till nummer <b>2</b> f�r att f� ditt nya licensnummer.'));

define( '_ACA_MAIL_FORMAT', compa::encodeutf('Kodformat'));
define( '_ACA_MAIL_FORMAT_TIPS', compa::encodeutf('Vilket format vill du anv�nda f�r att koda dina mail, Endast text eller MIME'));
define( '_ACA_ACAJOOM_CRON_DESC_ALT', compa::encodeutf('Om du inte har tillg�ng till en cronjobbs hanteraren p� din hemsida, s� kan du anv�nda den Fria jCron komponenten f�r att skapa ett cron jobb fr�n din hemsida.'));

//since 1.3.1
define('_ACA_SHOW_AUTHOR', compa::encodeutf('Visa F�rfattarens Namn'));
define('_ACA_SHOW_AUTHOR_TIPS', compa::encodeutf('V�lj Ja om du vill infoga f�rfattarens namn n�r du l�gger till en artikel till Mailen'));

//since 1.3.5
define('_ACA_REGWARN_NAME', compa::encodeutf('Ange ditt namn.'));
define('_ACA_REGWARN_MAIL', compa::encodeutf('Ange en giltig e-postadress.'));

//since 1.5.6
define('_ACA_ADDEMAILREDLINK_TIPS', compa::encodeutf('Om du v�ljer Ja, s� kommer e-postmeddelandet av anv�ndaren att infogas som en parameter i slutet av din omdirigerade URL (den omdirigerade l�nken till din modul eller till ett externt Acajoom formul�r).<br/>Det kan vara anv�ndbart om du vill k�ra ett speciellt skript i din omdirigerade sida.'));
define('_ACA_ADDEMAILREDLINK', compa::encodeutf('Infoga e-post till den omdirigerade l�nken'));

//since 1.6.3
define('_ACA_ITEMID', compa::encodeutf('ObjektId'));
define('_ACA_ITEMID_TIPS', compa::encodeutf('Detta ObjektId kommer att infogas till dina Acajoom l�nkar.'));

//since 1.6.5
define('_ACA_SHOW_JCALPRO', compa::encodeutf('jCalPRO'));
define('_ACA_SHOW_JCALPRO_TIPS', compa::encodeutf('Visa integrerings tabb f�r jCalPRO <br/>(endast om jCalPRO �r installerad p� din hemsida!)'));
define('_ACA_JCALTAGS_TITLE', compa::encodeutf('jCalPRO Tagg:'));
define('_ACA_JCALTAGS_TITLE_TIPS', compa::encodeutf('Kopiera och klistra in denna tagg i mailet mailing d�r du vill ha h�ndelsen placerad.'));
define('_ACA_JCALTAGS_DESC', compa::encodeutf('Beskrivning:'));
define('_ACA_JCALTAGS_DESC_TIPS', compa::encodeutf('V�lj Ja om du vill infoga beskrivning p� h�ndelsen'));
define('_ACA_JCALTAGS_START', compa::encodeutf('Start datum:'));
define('_ACA_JCALTAGS_START_TIPS', compa::encodeutf('V�lj Ja om du vill infoga ett startdatum p� h�ndelsen'));
define('_ACA_JCALTAGS_READMORE', compa::encodeutf('L�s mer:'));
define('_ACA_JCALTAGS_READMORE_TIPS', compa::encodeutf('V�lj Ja om du vill infoga en <b>l�s mer l�nk</b> f�r denna h�ndelse'));
define('_ACA_REDIRECTCONFIRMATION', compa::encodeutf('Omdirigera URL'));
define('_ACA_REDIRECTCONFIRMATION_TIPS', compa::encodeutf('Om du kr�ver ett bekr�ftelse e-postmeddelande, s� kommer anv�ndaren att bli bekr�ftat och omdirigerad till denna URL om han/hon klickar p� bekr�ftelsel�nken.'));

//since 2.0.0 compatibility with Joomla 1.5
if(!defined('_CMN_SAVE') and defined('CMN_SAVE')) define('_CMN_SAVE',CMN_SAVE);
if(!defined('_CMN_SAVE')) define('_CMN_SAVE','para');
if(!defined('_NO_ACCOUNT')) define('_NO_ACCOUNT','Inget konto �nnu?');
if(!defined('_CREATE_ACCOUNT')) define('_CREATE_ACCOUNT','Registrera');
if(!defined('_NOT_AUTH')) define('_NOT_AUTH','Du har inte till�telse att se p� den h�r k�llan.');

//since 3.0.0
define('_ACA_DISABLETOOLTIP','Disable Tooltip');
define('_ACA_DISABLETOOLTIP_TIPS', 'Disable the tooltip on the frontend');
define('_ACA_MINISENDMAIL', 'Use Mini SendMail');
define('_ACA_MINISENDMAIL_TIPS', 'If your server uses Mini SendMail, select this option to do not add the name of the user in the header of the e-mail');

//Since 3.1.5
define('_ACA_READMORE',compa::encodeutf('Read more...'));
define('_ACA_VIEWARCHIVE',compa::encodeutf('Click here'));

//Acajoom GPL
define('_ACA_DESC_GPL',_ACA_DESC_NEWS);