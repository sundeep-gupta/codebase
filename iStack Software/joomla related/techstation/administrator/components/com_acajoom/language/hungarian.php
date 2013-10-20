<?php
defined('_JEXEC') OR defined('_VALID_MOS') OR die('...Direct Access to this location is not allowed...');


/**
* <p>Hungarian language file</p>
* @author Joobi Ltd <support@ijoobi.com>
* @version $Id: hungarian.php 401 2006-12-05 15:07:13Z divivo $
* @link http://www.joobiweb.com
*/

### General ###
 //acajoom Description
define('_ACA_DESC_NEWS', compa::encodeutf('Az Acajoom komponens egy h�rlev�lkezel�, automatikus v�laszol� �s ellen�rz� eszk�z a felhaszn�l�kkal val� kapcsolattart�s hat�konys�ga �rdek�ben.  Acajoom, az �n kommunik�ci�s partnere!'));
define('_ACA_FEATURES', compa::encodeutf('Acajoom, az �n kommunik�ci�s partnere!'));

// Type of lists
define('_ACA_NEWSLETTER', compa::encodeutf('H�rlev�l'));
define('_ACA_AUTORESP', compa::encodeutf('Automatikus v�laszol�'));
define('_ACA_AUTORSS', compa::encodeutf('Automatikus RSS'));
define('_ACA_ECARD', compa::encodeutf('eCard'));
define('_ACA_POSTCARD', compa::encodeutf('K�peslap'));
define('_ACA_PERF', compa::encodeutf('M�k�d�s'));
define('_ACA_COUPON', compa::encodeutf('Kupon'));
define('_ACA_CRON', compa::encodeutf('Id�z�t�s feladat'));
define('_ACA_MAILING', compa::encodeutf('Levelez�s'));
define('_ACA_LIST', compa::encodeutf('Lista'));

 //acajoom Menu
define('_ACA_MENU_LIST', compa::encodeutf('Listakezel�s'));
define('_ACA_MENU_SUBSCRIBERS', compa::encodeutf('Feliratkoz�k'));
define('_ACA_MENU_NEWSLETTERS', compa::encodeutf('H�rlevelek'));
define('_ACA_MENU_AUTOS', compa::encodeutf('Automatikus v�laszol�k'));
define('_ACA_MENU_COUPONS', compa::encodeutf('Kuponok'));
define('_ACA_MENU_CRONS', compa::encodeutf('Id�z�t�s feladatok'));
define('_ACA_MENU_AUTORSS', compa::encodeutf('Automatikus RSS'));
define('_ACA_MENU_ECARD', compa::encodeutf('eK�peslapok'));
define('_ACA_MENU_POSTCARDS', compa::encodeutf('K�peslapok'));
define('_ACA_MENU_PERFS', compa::encodeutf('M�k�d�sek'));
define('_ACA_MENU_TAB_LIST', compa::encodeutf('List�k'));
define('_ACA_MENU_MAILING_TITLE', compa::encodeutf('Levelez�sek'));
define('_ACA_MENU_MAILING', compa::encodeutf('Levelez�s: '));
define('_ACA_MENU_STATS', compa::encodeutf('Statisztika'));
define('_ACA_MENU_STATS_FOR', compa::encodeutf('Statisztika: '));
define('_ACA_MENU_CONF', compa::encodeutf('Be�ll�t�s'));
define('_ACA_MENU_UPDATE', compa::encodeutf('Friss�t�sek'));
define('_ACA_MENU_ABOUT', compa::encodeutf('N�vjegy'));
define('_ACA_MENU_LEARN', compa::encodeutf('K�pz�s k�zpont'));
define('_ACA_MENU_MEDIA', compa::encodeutf('M�dia kezel�'));
define('_ACA_MENU_HELP', compa::encodeutf('S�g�'));
define('_ACA_MENU_CPANEL', compa::encodeutf('Vez�rl�pult'));
define('_ACA_MENU_IMPORT', compa::encodeutf('Import'));
define('_ACA_MENU_EXPORT', compa::encodeutf('Export'));
define('_ACA_MENU_SUB_ALL', compa::encodeutf('Mindet felirat'));
define('_ACA_MENU_UNSUB_ALL', compa::encodeutf('Mindet leirat'));
define('_ACA_MENU_VIEW_ARCHIVE', compa::encodeutf('Archivum'));
define('_ACA_MENU_PREVIEW', compa::encodeutf('El�n�zet'));
define('_ACA_MENU_SEND', compa::encodeutf('K�ld'));
define('_ACA_MENU_SEND_TEST', compa::encodeutf('Teszt lev�l k�ld�s'));
define('_ACA_MENU_SEND_QUEUE', compa::encodeutf('Feladatsor'));
define('_ACA_MENU_VIEW', compa::encodeutf('Megtekint�s'));
define('_ACA_MENU_COPY', compa::encodeutf('M�sol�s'));
define('_ACA_MENU_VIEW_STATS', compa::encodeutf('Megtekint�si statisztika'));
define('_ACA_MENU_CRTL_PANEL', compa::encodeutf(' Vez�rl�pult'));
define('_ACA_MENU_LIST_NEW', compa::encodeutf(' �j lista'));
define('_ACA_MENU_LIST_EDIT', compa::encodeutf(' Lista szerkeszt�s'));
define('_ACA_MENU_BACK', compa::encodeutf('Vissza'));
define('_ACA_MENU_INSTALL', compa::encodeutf('Telep�t�s'));
define('_ACA_MENU_TAB_SUM', compa::encodeutf('�sszegz�s'));
define('_ACA_STATUS', compa::encodeutf('�llapot'));

// messages
define('_ACA_ERROR', compa::encodeutf(' Hiba t�rt�nt! '));
define('_ACA_SUB_ACCESS', compa::encodeutf('Hozz�f�r�si jogok'));
define('_ACA_DESC_CREDITS', compa::encodeutf('K�sz�t�k'));
define('_ACA_DESC_INFO', compa::encodeutf('Inform�ci�'));
define('_ACA_DESC_HOME', compa::encodeutf('Webhely'));
define('_ACA_DESC_MAILING', compa::encodeutf('Levelez� lista'));
define('_ACA_DESC_SUBSCRIBERS', compa::encodeutf('Feliratkoz�k'));
define('_ACA_PUBLISHED', compa::encodeutf('Publik�lva'));
define('_ACA_UNPUBLISHED', compa::encodeutf('Visszavonva'));
define('_ACA_DELETE', compa::encodeutf('T�rl�s'));
define('_ACA_FILTER', compa::encodeutf('Sz�r�'));
define('_ACA_UPDATE', compa::encodeutf('Friss�t�s'));
define('_ACA_SAVE', compa::encodeutf('Ment�s'));
define('_ACA_CANCEL', compa::encodeutf('M�gsem'));
define('_ACA_NAME', compa::encodeutf('N�v'));
define('_ACA_EMAIL', compa::encodeutf('Email'));
define('_ACA_SELECT', compa::encodeutf('V�lasszon!'));
define('_ACA_ALL', compa::encodeutf('�sszes'));
define('_ACA_SEND_A', compa::encodeutf('K�ld�s: '));
define('_ACA_SUCCESS_DELETED', compa::encodeutf(' sikeresen t�r�lve'));
define('_ACA_LIST_ADDED', compa::encodeutf('A lista sikeresen elk�sz�lt'));
define('_ACA_LIST_COPY', compa::encodeutf('A lista sikeresen m�solva'));
define('_ACA_LIST_UPDATED', compa::encodeutf('A lista sikeresen friss�tve'));
define('_ACA_MAILING_SAVED', compa::encodeutf('A levelez�s sikeresen mentve.'));
define('_ACA_UPDATED_SUCCESSFULLY', compa::encodeutf('sikeresen friss�tve.'));

### Subscribers information ###
//subscribe and unsubscribe info
define('_ACA_SUB_INFO', compa::encodeutf('Feliratkoz�i inform�ci�k'));
define('_ACA_VERIFY_INFO', compa::encodeutf('Ellen�rizze a bek�ld�tt linket, n�h�ny inform�ci� elveszett.'));
define('_ACA_INPUT_NAME', compa::encodeutf('N�v'));
define('_ACA_INPUT_EMAIL', compa::encodeutf('Email'));
define('_ACA_RECEIVE_HTML', compa::encodeutf('HTML form�tum?'));
define('_ACA_TIME_ZONE', compa::encodeutf('Id�z�na'));
define('_ACA_BLACK_LIST', compa::encodeutf('Fekete lista'));
define('_ACA_REGISTRATION_DATE', compa::encodeutf('Felhaszn�l�i regisztr�ci�s d�tum'));
define('_ACA_USER_ID', compa::encodeutf('Felhaszn�l� az'));
define('_ACA_DESCRIPTION', compa::encodeutf('Le�r�s'));
define('_ACA_ACCOUNT_CONFIRMED', compa::encodeutf('A regisztr�ci�ja akt�v�lva.'));
define('_ACA_SUB_SUBSCRIBER', compa::encodeutf('Feliratkoz�'));
define('_ACA_SUB_PUBLISHER', compa::encodeutf('Publik�l�'));
define('_ACA_SUB_ADMIN', compa::encodeutf('Adminisztr�tor'));
define('_ACA_REGISTERED', compa::encodeutf('Regisztr�lt'));
define('_ACA_SUBSCRIPTIONS', compa::encodeutf('Feliratkoz�sok'));
define('_ACA_SEND_UNSUBCRIBE', compa::encodeutf('Leiratkoz�si �zenet k�ld�se'));
define('_ACA_SEND_UNSUBCRIBE_TIPS', compa::encodeutf('Kattintson az Igen-re a leiratkoz�st meger�s�t� lev�l elk�ld�s�hez!'));
define('_ACA_SUBSCRIBE_SUBJECT_MESS', compa::encodeutf('K�rj�k, er�s�tse meg a feliratkoz�s�t!'));
define('_ACA_UNSUBSCRIBE_SUBJECT_MESS', compa::encodeutf('Leiratkoz�s meger�s�t�se'));
define('_ACA_DEFAULT_SUBSCRIBE_MESS', compa::encodeutf('Kedves [NAME]!<br /><br />M�g egy l�p�st kell megtennie a feliratkoz�s befejez�s�ig. Kattintson az al�bbi linkre a feliratkoz�s meger�s�t�s�hez!<br /><br />[CONFIRM]<br /><br />B�rmilyen k�rd�ssel forduljon az adminisztr�torhoz!<br /><br />Varanka Zolt�n<br />(webmester - adminisztr�tor)'));
define('_ACA_DEFAULT_UNSUBSCRIBE_MESS', compa::encodeutf('Kedves [NAME]!<br /><br />Ez egy meger�s�t� lev�l a h�rlev�l lemond�s�hoz. Sajn�ljuk a d�nt�s�t. Term�szetesen b�rmikor �jra feliratkozhat a list�ra. B�rmilyen k�rd�ssel forduljon az adminisztr�torhoz!<br /><br />Varanka Zolt�n<br />(webmester - adminisztr�tor)'));

// Acajoom subscribers
define('_ACA_SIGNUP_DATE', compa::encodeutf('Bejelentkez�si d�tum'));
define('_ACA_CONFIRMED', compa::encodeutf('Meger�s�tve'));
define('_ACA_SUBSCRIB', compa::encodeutf('Feliratkoz�s'));
define('_ACA_HTML', compa::encodeutf('HTML levelez�sek'));
define('_ACA_RESULTS', compa::encodeutf('Eredm�nyek'));
define('_ACA_SEL_LIST', compa::encodeutf('V�lasszon egy list�t!'));
define('_ACA_SEL_LIST_TYPE', compa::encodeutf('- V�lasszon egy listat�pust! -'));
define('_ACA_SUSCRIB_LIST', compa::encodeutf('Feliratkoz�k teljes list�ja'));
define('_ACA_SUSCRIB_LIST_UNIQUE', compa::encodeutf('Feliratkoz�k : '));
define('_ACA_NO_SUSCRIBERS', compa::encodeutf('Ebben a list�ban nincsenek feliratkoz�k.'));
define('_ACA_COMFIRM_SUBSCRIPTION', compa::encodeutf('K�ldt�nk �nnek egy meger�s�t� levelet. N�zze �t a postal�d�j�t �s kattintson a lev�lben lev� linkre.<br />A feliratkoz�s�t meg kell er�s�tenie a lev�l seg�ts�g�vel.'));
define('_ACA_SUCCESS_ADD_LIST', compa::encodeutf('�n sikeresen beker�lt a list�ba.'));


 // Subcription info
define('_ACA_CONFIRM_LINK', compa::encodeutf('Kattintson ide a feliratkoz�s meger�s�t�s�hez!'));
define('_ACA_UNSUBSCRIBE_LINK', compa::encodeutf('Kattintson ide a leiratkoz�shoz!'));
define('_ACA_UNSUBSCRIBE_MESS', compa::encodeutf('Az �n email c�m�t elt�vol�tottuk a list�b�l!'));

define('_ACA_QUEUE_SENT_SUCCESS', compa::encodeutf('Minden lev�l sikeresen elk�ld�sre ker�lt.'));
define('_ACA_MALING_VIEW', compa::encodeutf('Levelez�sek megtekint�se'));
define('_ACA_UNSUBSCRIBE_MESSAGE', compa::encodeutf('Biztosan szeretne leiratkozni a list�r�l?'));
define('_ACA_MOD_SUBSCRIBE', compa::encodeutf('Feliratkoz�s'));
define('_ACA_SUBSCRIBE', compa::encodeutf('Feliratkoz�s'));
define('_ACA_UNSUBSCRIBE', compa::encodeutf('Leiratkoz�s'));
define('_ACA_VIEW_ARCHIVE', compa::encodeutf('Arch�vum megtekint�se'));
define('_ACA_SUBSCRIPTION_OR', compa::encodeutf(' vagy kattintson ide az �n inform�ci�inak a friss�t�s�hez!'));
define('_ACA_EMAIL_ALREADY_REGISTERED', compa::encodeutf('Ez az email c�m m�r a list�ban van.'));
define('_ACA_SUBSCRIBER_DELETED', compa::encodeutf('A feliratkoz� sikeresen t�r�lve.'));


### UserPanel ###
 //User Menu
define('_UCP_USER_PANEL', compa::encodeutf('Felhaszn�l�i vez�rl�pult'));
define('_UCP_USER_MENU', compa::encodeutf('Felhaszn�l�i men�'));
define('_UCP_USER_CONTACT', compa::encodeutf('Feliratkoz�saim'));
 //Acajoom Cron Menu
define('_UCP_CRON_MENU', compa::encodeutf('Id�z�t� feladat kezel�'));
define('_UCP_CRON_NEW_MENU', compa::encodeutf('�j id�z�t�s'));
define('_UCP_CRON_LIST_MENU', compa::encodeutf('Id�z�t�m list�ja'));
 //Acajoom Coupon Menu
define('_UCP_COUPON_MENU', compa::encodeutf('Kupon kezel�'));
define('_UCP_COUPON_LIST_MENU', compa::encodeutf('Kupon lista'));
define('_UCP_COUPON_ADD_MENU', compa::encodeutf('�j kupon hozz�ad�s'));

### lists ###
// Tabs
define('_ACA_LIST_T_GENERAL', compa::encodeutf('Le�r�s'));
define('_ACA_LIST_T_LAYOUT', compa::encodeutf('Kialak�t�s'));
define('_ACA_LIST_T_SUBSCRIPTION', compa::encodeutf('Feliratkoz�s'));
define('_ACA_LIST_T_SENDER', compa::encodeutf('Inf� a k�ld�r�l'));

define('_ACA_LIST_TYPE', compa::encodeutf('Lista t�pus'));
define('_ACA_LIST_NAME', compa::encodeutf('Lista n�v'));
define('_ACA_LIST_ISSUE', compa::encodeutf('Kiad�s sz�ma'));
define('_ACA_LIST_DATE', compa::encodeutf('K�ld�s d�tuma'));
define('_ACA_LIST_SUB', compa::encodeutf('T�rgy'));
define('_ACA_ATTACHED_FILES', compa::encodeutf('Csatolt f�jlok'));
define('_ACA_SELECT_LIST', compa::encodeutf('V�lassza ki a szerkesztend� list�t!'));

// Auto Responder box
define('_ACA_AUTORESP_ON', compa::encodeutf('Lista t�pus'));
define('_ACA_AUTO_RESP_OPTION', compa::encodeutf('Automatikus v�laszol� opci�k'));
define('_ACA_AUTO_RESP_FREQ', compa::encodeutf('A feliratkoz�k kiv�laszthatj�k a gyakoris�got'));
define('_ACA_AUTO_DELAY', compa::encodeutf('K�sleltet�s (napokban)'));
define('_ACA_AUTO_DAY_MIN', compa::encodeutf('Minim�lis gyakoris�g'));
define('_ACA_AUTO_DAY_MAX', compa::encodeutf('Maxim�lis gyakoris�g'));
define('_ACA_FOLLOW_UP', compa::encodeutf('Az automatikus v�laszol� be�ll�t�sa'));
define('_ACA_AUTO_RESP_TIME', compa::encodeutf('A feliratkoz�k id�t v�laszthatnak'));
define('_ACA_LIST_SENDER', compa::encodeutf('Lista k�ld�'));

define('_ACA_LIST_DESC', compa::encodeutf('Lista le�r�s'));
define('_ACA_LAYOUT', compa::encodeutf('Kialak�t�s'));
define('_ACA_SENDER_NAME', compa::encodeutf('K�ld� neve'));
define('_ACA_SENDER_EMAIL', compa::encodeutf('K�ld� email c�me'));
define('_ACA_SENDER_BOUNCE', compa::encodeutf('K�ld� v�lasz c�me'));
define('_ACA_LIST_DELAY', compa::encodeutf('K�sleltet�s'));
define('_ACA_HTML_MAILING', compa::encodeutf('HTML lev�l?'));
define('_ACA_HTML_MAILING_DESC', compa::encodeutf('(ha megv�ltoztatja ezt, mentenie kell majd visszat�rni ehhez a k�perny�h�z a v�ltoz�sok megtekint�s�re.)'));
define('_ACA_HIDE_FROM_FRONTEND', compa::encodeutf('Elrejt�s a webes fel�leten?'));
define('_ACA_SELECT_IMPORT_FILE', compa::encodeutf('V�lassza ki az import�land� f�jlt!'));;
define('_ACA_IMPORT_FINISHED', compa::encodeutf('Az import�l�s befejez�d�tt'));
define('_ACA_DELETION_OFFILE', compa::encodeutf('F�jl t�rl�se'));
define('_ACA_MANUALLY_DELETE', compa::encodeutf('meghiusult, k�zzel kell t�r�lnie a f�jlt'));
define('_ACA_CANNOT_WRITE_DIR', compa::encodeutf('A k�nyvt�r nem �rhat�'));
define('_ACA_NOT_PUBLISHED', compa::encodeutf('A lev�l nem k�ldhet� el, a lista nincs publik�lva.'));

//  List info box
define('_ACA_INFO_LIST_PUB', compa::encodeutf('Kattintson ide a lista publik�l�s�hoz!'));
define('_ACA_INFO_LIST_NAME', compa::encodeutf('Adja meg a lista nev�t itt! Ezzel a n�vvel azonos�thatja a list�t!'));
define('_ACA_INFO_LIST_DESC', compa::encodeutf('Adja meg a lista r�vid le�r�s�t! Ezt a le�r�st l�tj�k a felhaszn�l�k.'));
define('_ACA_INFO_LIST_SENDER_NAME', compa::encodeutf('Adja meg a lev�l k�ld�j�nek a nev�t! Ezt a nevetl�tj�k a feliratkoz�k, amikor levelet kapnak a list�r�l.'));
define('_ACA_INFO_LIST_SENDER_EMAIL', compa::encodeutf('Adja meg azt az email c�met, ahonnan az �zenetek k�ld�sre ker�lnek.'));
define('_ACA_INFO_LIST_SENDER_BOUNCED', compa::encodeutf('Adja meg azt az email c�met,, ahova a feliratkoz�k v�laszolhatnak. Aj�nlatos, hogy ez megegyezzen a k�ld� email c�mmel, mivel a spam sz�r�k magasabb kock�zatk�nt kezelik, ha ezek k�l�nb�z�ek.'));
define('_ACA_INFO_LIST_AUTORESP', compa::encodeutf('V�lassza ki a levelez�s t�pus�t ehhez a list�hoz!<br />H�rlev�l: norm�l h�rlev�l<br />Automatikus v�laszol�: ez egy lista, amely megadott id�k�z�nk�nt k�ld levelet.'));
define('_ACA_INFO_LIST_FREQUENCY', compa::encodeutf('A felhasznl�k megv�laszthatj�k, hogy milyen gyakran kapjanak levelet. Ez nagy rugalmass�got biztos�t.'));
define('_ACA_INFO_LIST_TIME', compa::encodeutf('A felhaszn�l�k megv�laszthatj�k, hogy a h�t melyik napj�n kapjanak levelet.'));
define('_ACA_INFO_LIST_MIN_DAY', compa::encodeutf('Milyen legyen az a minim�lis gyakoris�g, amelyet a felhaszn�l�k megv�laszthatnak, ha be akarj�k �ll�tani a levelek fogad�s�nak gyakoriss�g�t?'));
define('_ACA_INFO_LIST_DELAY', compa::encodeutf('Adja meg a k�sleltet�st az el�z� �s ezen automatikus v�laszol� k�z�tt!'));
define('_ACA_INFO_LIST_DATE', compa::encodeutf('Adja meg, mikor legyen publik�lva a herlev�l, ha k�sleltetettnek lett be�ll�tva!<br /> Form�tum: ����-HH-NN ��:PP:MM'));
define('_ACA_INFO_LIST_MAX_DAY', compa::encodeutf('Milyen legyen az a maxim�lis gyakoris�g, amelyet a felhaszn�l�k megv�laszthatnak, ha be akarj�k �ll�tani a levelek fogad�s�nak gyakoriss�g�t?'));
define('_ACA_INFO_LIST_LAYOUT', compa::encodeutf('Itt adhatja meg a lev�l kialak�t�s�t. B�rmilyen kialak�t�st megadhat.'));
define('_ACA_INFO_LIST_SUB_MESS', compa::encodeutf('Ez a lev�l ker�l elk�ld�sre a felhaszn�l�nak az els� feliratkoz�skor. B�rmilyen sz�veget meg lehet itt adni.'));
define('_ACA_INFO_LIST_UNSUB_MESS', compa::encodeutf('Ez a lev�l ker�l elk�ld�sre a felhaszn�l�nak az leiratkozik. B�rmilyen sz�veget meg lehet itt adni.'));
define('_ACA_INFO_LIST_HTML', compa::encodeutf('Pip�lja ki a kijel�l�dobozt, ha HTMLform�ban akarja a levelet elk�ldeni. A feliratkoz�k megadhatj�k, hogy HTML vagy sz�veges form�ban k�v�nj�k-e fogadnia leveleket, amikor egy HTML list�ra iratkoznak fel.'));
define('_ACA_INFO_LIST_HIDDEN', compa::encodeutf('Kattintson az Igen-re a lista elrejt�s�hez a webes fel�leten, a felhaszn�l�k ugyan nem iratkozhatnak fel,de az�rt meg lehet levelet k�ldeni.'));
define('_ACA_INFO_LIST_ACA_AUTO_SUB', compa::encodeutf('Szeretn�, hogy a felhaszn�l�k automatikusan feliratkozzanak erre a list�ra?<br /><B>�j felhaszn�l�k:</B>minden �j felhaszn�l�, aki regisztr�l, feliratkoz� is lesz egyben.<br /><B>�sszes felhaszn�l�:</B> minden regisztr�lt felhaszn�l� feliratkoz� is lesz egyben.<br />(t�mogatja a Community Buildert)'));
define('_ACA_INFO_LIST_ACC_LEVEL', compa::encodeutf('V�lassza ki a webes fel�let hozz�f�r�si szintj�t! Ez megjelen�ti vagy elrejti a levelez�st azon csoportok eset�n, amelynek nincs hozz�f�r�si joga, teh�t nem tudnak feliratkozni.'));
define('_ACA_INFO_LIST_ACC_USER_ID', compa::encodeutf('V�lassza ki a hozz�f�r�si szintj�t annak a csoportnak, amelynek enged�lyezni szeretm� a szerkeszt�st. Ez �s az e feletti csoport szerkesztheti a levelez�st �s levelet k�ldhet ki mind a webes mind az adminisztr�ci�s fel�letr�l.'));
define('_ACA_INFO_LIST_FOLLOW_UP', compa::encodeutf('Ha szeretn� az automatikus v�laszol�t egy m�sokba mozgatni, amint el�ri az utols� �zenetet, megadhatja itt a nyomk�vet� automatikus v�laszol�t.'));
define('_ACA_INFO_LIST_ACA_OWNER', compa::encodeutf('Ez a list�t l�rtehoz� szem�ly azonos�t�ja.'));
define('_ACA_INFO_LIST_WARNING', compa::encodeutf('   Ez az utols� opci� csak a lista l�trehoz�sakor el�rhet�.'));
define('_ACA_INFO_LIST_SUBJET', compa::encodeutf(' A levelez�s t�rgya. Ez a sz�veg ker�l a lev�l t�rgy�ba.'));
define('_ACA_INFO_MAILING_CONTENT', compa::encodeutf('Ez az elk�ldend� lev�l t�rzse.'));
define('_ACA_INFO_MAILING_NOHTML', compa::encodeutf('Adja meg a lev�l t�rzs�t, amelyet azoknak a feliratkoz�knak kell elk�ldeni, akik csak sz�veges levelet fogadnak. <BR/> Megjegyz�s: ha �resen hagyja, a html form�tum� sz�vegr�sz ker�l ide sz�veges form�tumban.'));
define('_ACA_INFO_MAILING_VISIBLE', compa::encodeutf('Kattintson az Igen-re a levelez�sek megjelen�t�s�hez a webes fel�leten.'));
define('_ACA_INSERT_CONTENT', compa::encodeutf('L�tez� tartalom besz�r�sa'));

// Coupons
define('_ACA_SEND_COUPON_SUCCESS', compa::encodeutf('A kupon sikeresen elk�ldve!'));
define('_ACA_CHOOSE_COUPON', compa::encodeutf('V�lasszon kupont!'));
define('_ACA_TO_USER', compa::encodeutf(' ennek a felhaszn�l�nak'));

### Cron options
//drop down frequency(CRON)
define('_ACA_FREQ_CH1', compa::encodeutf('Minden �r�ban'));
define('_ACA_FREQ_CH2', compa::encodeutf('Minden 6 �r�ban'));
define('_ACA_FREQ_CH3', compa::encodeutf('Minden 12 �r�ban'));
define('_ACA_FREQ_CH4', compa::encodeutf('Naponta'));
define('_ACA_FREQ_CH5', compa::encodeutf('Hetente'));
define('_ACA_FREQ_CH6', compa::encodeutf('Havonta'));
define('_ACA_FREQ_NONE', compa::encodeutf('Nem'));
define('_ACA_FREQ_NEW', compa::encodeutf('�j felhaszn�l�l'));
define('_ACA_FREQ_ALL', compa::encodeutf('�sszes felhaszn�l�'));

//Label CRON form
define('_ACA_LABEL_FREQ', compa::encodeutf('Acajoom id�z�t�?'));
define('_ACA_LABEL_FREQ_TIPS', compa::encodeutf('Kattintson az Igen-re, ha haszn�lni szeretn� az Acajoom id�z�t�tCron, A Nem be�ll�t�sa m�s id�z�t� haszn�lat�t teszi lehet�v�.<br />Ha az Igem-re kattint, nem kell megadnia az id�z�t� c�m�t, ez automatikusan hozz�ad�dik.'));
define('_ACA_SITE_URL', compa::encodeutf('Az �n webhely�nek URL-je'));
define('_ACA_CRON_FREQUENCY', compa::encodeutf('Id�z�t� gyakoris�g'));
define('_ACA_STARTDATE_FREQ', compa::encodeutf('Kezd� d�tum'));
define('_ACA_LABELDATE_FREQ', compa::encodeutf('Adja meg a d�tumot!'));
define('_ACA_LABELTIME_FREQ', compa::encodeutf('Adja meg az id�t!'));
define('_ACA_CRON_URL', compa::encodeutf('Id�z�t� URL'));
define('_ACA_CRON_FREQ', compa::encodeutf('Gyakoris�g'));
define('_ACA_TITLE_CRONLIST', compa::encodeutf('Id�z�t� lista'));
define('_NEW_LIST', compa::encodeutf('�j lista k�sz�t�se'));

//title CRON form
define('_ACA_TITLE_FREQ', compa::encodeutf('Id�z�t� szerkeszt�se'));
define('_ACA_CRON_SITE_URL', compa::encodeutf('�rv�nyes webhely URL-t adjon meg, kezdje http://-vel!'));

### Mailings ###
define('_ACA_MAILING_ALL', compa::encodeutf('�sszes levelez�s'));
define('_ACA_EDIT_A', compa::encodeutf('Szerkeszt�s: '));
define('_ACA_SELCT_MAILING', compa::encodeutf('V�lasszon egy list�t a leg�rd�l� men�ben �j levelez�s hozz�ad�s�hoz!'));
define('_ACA_VISIBLE_FRONT', compa::encodeutf('L�that� a webes fel�leten'));

// mailer
define('_ACA_SUBJECT', compa::encodeutf('T�rgy'));
define('_ACA_CONTENT', compa::encodeutf('Tartalom'));
define('_ACA_NAMEREP', compa::encodeutf('[NAME] = A feliratkoz� nev�re cser�l�dik ki ez a k�d, ezzel szem�lyre szabhatja a levelet.<br />'));
define('_ACA_FIRST_NAME_REP', compa::encodeutf('[FIRSTNAME] = A feliratkoz� vezet�knev�re (els� n�v) cser�l�dik ki ez a k�d.<br />'));
define('_ACA_NONHTML', compa::encodeutf('Nem-html verzi�'));
define('_ACA_ATTACHMENTS', compa::encodeutf('Mell�kletek'));
define('_ACA_SELECT_MULTIPLE', compa::encodeutf('Tartsa lenyomva a CTRL (vagy a Command) gombot t�bb mell�klet kiv�laszt�s�hoz.<br />A mell�kletek list�j�ban megjelen� f�jlokat egy k�l�n k�nyvt�rban helyezheti el, ez a k�nyvt�r be�ll�that� a be�ll�t�sok panelj�n.'));
define('_ACA_CONTENT_ITEM', compa::encodeutf('Tartalmi elem'));
define('_ACA_SENDING_EMAIL', compa::encodeutf('Lev�l k�ld�se'));
define('_ACA_MESSAGE_NOT', compa::encodeutf('A lev�l nem k�ldhet� el'));
define('_ACA_MAILER_ERROR', compa::encodeutf('Lev�lk�ld�si hiba'));
define('_ACA_MESSAGE_SENT_SUCCESSFULLY', compa::encodeutf('A lev�l sikeresen elk�ldve'));
define('_ACA_SENDING_TOOK', compa::encodeutf('A lev�l elk�ld�se'));
define('_ACA_SECONDS', compa::encodeutf('m�sodpercet vett ig�nybe'));
define('_ACA_NO_ADDRESS_ENTERED', compa::encodeutf('Nincs email c�m vagy feliratkoz� megadva!'));
define('_ACA_CHANGE_SUBSCRIPTIONS', compa::encodeutf('V�ltoztat�s'));
define('_ACA_CHANGE_EMAIL_SUBSCRIPTION', compa::encodeutf('V�ltoztat a feliratkoz�son?'));
define('_ACA_WHICH_EMAIL_TEST', compa::encodeutf('Adja meg a tesztel�sre haszn�lt email c�met vagy v�lassza az el�n�zetet!'));
define('_ACA_SEND_IN_HTML', compa::encodeutf('K�ld�s HTML m�dban (HTML levelekn�l)?'));
define('_ACA_VISIBLE', compa::encodeutf('L�that�'));
define('_ACA_INTRO_ONLY', compa::encodeutf('Csak bevezet�'));

// stats
define('_ACA_GLOBALSTATS', compa::encodeutf('Globalis statisztika'));
define('_ACA_DETAILED_STATS', compa::encodeutf('R�szletes statisztika'));
define('_ACA_MAILING_LIST_DETAILS', compa::encodeutf('Lista r�szletek'));
define('_ACA_SEND_IN_HTML_FORMAT', compa::encodeutf('K�ld�s HTML form�tumban'));
define('_ACA_VIEWS_FROM_HTML', compa::encodeutf('Megtekintve (csak html levelekn�l)'));
define('_ACA_SEND_IN_TEXT_FORMAT', compa::encodeutf('K�ld�s sz�veges form�tumban'));
define('_ACA_HTML_READ', compa::encodeutf('HTML olvasott'));
define('_ACA_HTML_UNREAD', compa::encodeutf('HTML nem olvasott'));
define('_ACA_TEXT_ONLY_SENT', compa::encodeutf('Csak sz�veg'));

// Configuration panel
// main tabs
define('_ACA_MAIL_CONFIG', compa::encodeutf('Lev�l'));
define('_ACA_LOGGING_CONFIG', compa::encodeutf('Napl�-statisztika'));
define('_ACA_SUBSCRIBER_CONFIG', compa::encodeutf('Feliratkoz�k'));
define('_ACA_MISC_CONFIG', compa::encodeutf('Egy�b'));
define('_ACA_MAIL_SETTINGS', compa::encodeutf('Lev�l be�ll�t�sok'));
define('_ACA_MAILINGS_SETTINGS', compa::encodeutf('Levelez�si be�ll�t�sok'));
define('_ACA_SUBCRIBERS_SETTINGS', compa::encodeutf('Feliratkoz� be�ll�t�sok'));
define('_ACA_CRON_SETTINGS', compa::encodeutf('Id�z�t� be�ll�t�sok'));
define('_ACA_SENDING_SETTINGS', compa::encodeutf('K�ld�si be�ll�t�sok'));
define('_ACA_STATS_SETTINGS', compa::encodeutf('Statisztikai be�ll�t�sok'));
define('_ACA_LOGS_SETTINGS', compa::encodeutf('Napl� be�ll�t�sok'));
define('_ACA_MISC_SETTINGS', compa::encodeutf('Egy�b be�ll�t�sok'));
// mail settings
define('_ACA_SEND_MAIL_FROM', compa::encodeutf('Bounce Back Address<br/>(used as Bounced back for all your messages)'));
define('_ACA_SEND_MAIL_NAME', compa::encodeutf('K�ld� n�v'));
define('_ACA_MAILSENDMETHOD', compa::encodeutf('Lev�lk�ld� m�d'));
define('_ACA_SENDMAILPATH', compa::encodeutf('Sendmail �tvonal'));
define('_ACA_SMTPHOST', compa::encodeutf('SMTP kiszolg�l�'));
define('_ACA_SMTPAUTHREQUIRED', compa::encodeutf('SMTP hiteles�t�s sz�ks�ges'));
define('_ACA_SMTPAUTHREQUIRED_TIPS', compa::encodeutf('V�lassza az Igen-t, ha az MTP szerver hiteles�t�st ig�nyel'));
define('_ACA_SMTPUSERNAME', compa::encodeutf('SMTP felhaszn�l�n�v'));
define('_ACA_SMTPUSERNAME_TIPS', compa::encodeutf('Adja meg az SMTP felhaszn�l�nevet, ha az SMTP szerver hiteles�t�st ig�nyel!'));
define('_ACA_SMTPPASSWORD', compa::encodeutf('SMTP jelsz�'));
define('_ACA_SMTPPASSWORD_TIPS', compa::encodeutf('Adja meg az SMTP jelsz�t, ha az SMTP szerver hiteles�t�st ig�nyel!'));
define('_ACA_USE_EMBEDDED', compa::encodeutf('Be�gyazott k�pek'));
define('_ACA_USE_EMBEDDED_TIPS', compa::encodeutf('V�lassza az Igen-t, ha a mell�kelt k�peket be kell �gyazni a lev�lbe html form�tum eset�n vagy a Nem-et, ha a k�pek linkjeit szeretn� elk�ldeni a lev�lben.'));
define('_ACA_UPLOAD_PATH', compa::encodeutf('Felt�lt�si/csatol�si �tvonal'));
define('_ACA_UPLOAD_PATH_TIPS', compa::encodeutf('Megadhatja a felt�lt�si k�nyvt�rat.<br />Ellen�rizze, hogy a k�nyvt�r l�tezik-e, ha sz�ks�ges hozza l�tre!'));

// subscribers settings
define('_ACA_ALLOW_UNREG', compa::encodeutf('Nem regisztr�ltak is'));
define('_ACA_ALLOW_UNREG_TIPS', compa::encodeutf('V�lassza az Igen-t, ha a nem regisztr�lt felhaszn�l�k is feliratkozhatnak a list�kra.'));
define('_ACA_REQ_CONFIRM', compa::encodeutf('Meger�s�t�s sz�ks�ges'));
define('_ACA_REQ_CONFIRM_TIPS', compa::encodeutf('V�lassza az Igen-t, ha a nem regisztr�lt felhaszn�l�knak meg kell er�s�teni�k az email c�m�ket.'));
define('_ACA_SUB_SETTINGS', compa::encodeutf('Feliratkoz�si be�ll�t�sok'));
define('_ACA_SUBMESSAGE', compa::encodeutf('Feliratkoz� lev�l'));
define('_ACA_SUBSCRIBE_LIST', compa::encodeutf('Feliratkoz�s egy list�ra'));

define('_ACA_USABLE_TAGS', compa::encodeutf('Haszn�lhat� c�mk�k'));
define('_ACA_NAME_AND_CONFIRM', compa::encodeutf('<b>[CONFIRM]</b> = Kattinthat� linket k�sz�t, amellyel a feliratkoz� meger�s�theti a feliratkoz�s�t. Ez <strong>sz�ks�ges</strong> az Acajoom megfelel� m�k�d�s�hez.<br /><br />[NAME] = Lecser�l�dik a feliratkoz� nev�re, szem�lyreszabva a k�ld�tt levelet.<br /><br />[FIRSTNAME] = Lecser�l�dik a feliratkoz� els� nev�re (vezet�kn�v).<br />'));
define('_ACA_CONFIRMFROMNAME', compa::encodeutf('Meger�s�t� felad� n�v'));
define('_ACA_CONFIRMFROMNAME_TIPS', compa::encodeutf('Adja meg a meger�s�t� list�ban megjelen� nevet!'));
define('_ACA_CONFIRMFROMEMAIL', compa::encodeutf('Meger�s�t� felad� email c�m'));
define('_ACA_CONFIRMFROMEMAIL_TIPS', compa::encodeutf('Adja meg a meger�s�t� list�ban megjelen� email c�met!'));
define('_ACA_CONFIRMBOUNCE', compa::encodeutf('V�lasz c�m'));
define('_ACA_CONFIRMBOUNCE_TIPS', compa::encodeutf('Adja meg a meger�s�t� list�ban megjelen� v�lasz email c�met!'));
define('_ACA_HTML_CONFIRM', compa::encodeutf('HTML meger�s�t�s'));
define('_ACA_HTML_CONFIRM_TIPS', compa::encodeutf('V�lassza az Igen-t, ha a meger�s�t� levelet html form�ban szeretn� elk�ldeni, ha a feliratjoz� lehet�v� teszi a html lev�l fogad�s�t..'));
define('_ACA_TIME_ZONE_ASK', compa::encodeutf('R�k�rdez�s az id�z�n�ra'));
define('_ACA_TIME_ZONE_TIPS', compa::encodeutf('V�lassza az Igen-t, ha r� szeretne k�rdezni a felhaszn�l� id�z�n�j�ra. A lev�l a felhaszn�l�nak megfelel� id�z�na szerinti id�ben lesz elk�ldve, ahol ez alkalmazhat�.'));

 // Cron Set up
define('_ACA_AUTO_CONFIG', compa::encodeutf('Id�z�t�'));
define('_ACA_TIME_OFFSET_URL', compa::encodeutf('kattintson ide az eltol�s be�ll�t�s�hoz az General Settings oldal Locale f�l�n'));
define('_ACA_TIME_OFFSET_TIPS', compa::encodeutf('Be�ll�tja a szerver id�eltol�s�t, hogy a felvett d�tum �s id� adatok pontosak legyenek'));
define('_ACA_TIME_OFFSET', compa::encodeutf('Id� eltol�s'));
define('_ACA_CRON_DESC', compa::encodeutf('<br />Az id�z�t� funkci�val automatikus feladatot lehet be�ll�tani a Joomla webhelyen!<br />Be�ll�t�s�hoz az al�bbi utas�t�st kell adni az id�z�t� vez�rl�pulthoz:<br /><b>' . ACA_JPATH_LIVE . '/index2.php?option=com_acajoom&act=cron</b> <br /><br />Ha seg�ts�gre van sz�ks�ge, keresse fel a <a href="http://www.ijoobi.com" target="_blank">http://www.ijoobi.com</a> oldal f�rum�t!'));
// sending settings
define('_ACA_PAUSEX', compa::encodeutf('V�rakozzon x m�sodpercet minden be�ll�tott mennyis�g� lev�ln�l'));
define('_ACA_PAUSEX_TIPS', compa::encodeutf('Adja meg azt at id�t m�sodpercben, ameddig az Acajoom v�rakozik, miel�tt a k�vetkez� adag levelet elk�ldi.'));
define('_ACA_EMAIL_BET_PAUSE', compa::encodeutf('Lev�ladagok sz�ma'));
define('_ACA_EMAIL_BET_PAUSE_TIPS', compa::encodeutf('Az egyszerre elk�ldhet� levelek sz�ma.'));
define('_ACA_WAIT_USER_PAUSE', compa::encodeutf('V�rakoz�s felhaszn�l�i bevitelte'));
define('_ACA_WAIT_USER_PAUSE_TIPS', compa::encodeutf('K�t adag lev�l elk�ld�se k�zben v�rakozzon-e a program felhaszn�l�i bevitelre?'));
define('_ACA_SCRIPT_TIMEOUT', compa::encodeutf('Id� kifut�s'));
define('_ACA_SCRIPT_TIMEOUT_TIPS', compa::encodeutf('Id� m�sodpercben, ameddig a program futhat.'));
// Stats settings
define('_ACA_ENABLE_READ_STATS', compa::encodeutf('Statisztika olvas�s�nak enged�lyez�se'));
define('_ACA_ENABLE_READ_STATS_TIPS', compa::encodeutf('V�lasszon Igen-t, ha szeretn� napl�zni a megtekint�sek sz�m�t. Ez csak html levelekn�l haszn�lhat�'));
define('_ACA_LOG_VIEWSPERSUB', compa::encodeutf('Megtekint�sek napl�z�sa feliratkoz�kk�nt'));
define('_ACA_LOG_VIEWSPERSUB_TIPS', compa::encodeutf('V�lasszon Igen-t, ha szeretn� napl�zni a megtekint�sek sz�m�t felhaszn�l�kk�nt. Ez csak html levelekn�l haszn�lhat�'));
// Logs settings
define('_ACA_DETAILED', compa::encodeutf('R�szletes napl�'));
define('_ACA_SIMPLE', compa::encodeutf('Egyszer� napl�'));
define('_ACA_DIAPLAY_LOG', compa::encodeutf('Napl� megjelen�t�se'));
define('_ACA_DISPLAY_LOG_TIPS', compa::encodeutf('V�lassza az Igen-t, ha szeretn� megjelen�teni a napl�z�st a levelek elk�ld�se sor�n.'));
define('_ACA_SEND_PERF_DATA', compa::encodeutf('K�ld�si m�velet'));
define('_ACA_SEND_PERF_DATA_TIPS', compa::encodeutf('V�lassza az Igen-t, ha szeretne jelent�st kapni a be�ll�t�sokr�l, a feliratkoz�k sz�m�r�l �s az elk�ld�s id�tartam�r�l. Ez inform�i�t ad az Acajoom m�k�d�s�r�l.'));
define('_ACA_SEND_AUTO_LOG', compa::encodeutf('Napl� elk�ld�se az automatikus v�laszol�nak.'));
define('_ACA_SEND_AUTO_LOG_TIPS', compa::encodeutf('V�lassza az Igen-t, ha a napl�t szeretn� elk�ldeni minden alkalommal, amikor a rendszer levelet k�ld. Figyelem: ez nagy m�ret� levelet is jelenthet.'));
define('_ACA_SEND_LOG', compa::encodeutf('Napl� k�ld�se'));
define('_ACA_SEND_LOG_TIPS', compa::encodeutf('K�ldj�n-e napl�t a rendszer a lev�l k�ld�j�nek a c�m�re.'));
define('_ACA_SEND_LOGDETAIL', compa::encodeutf('R�szletes napl� k�ld�se'));
define('_ACA_SEND_LOGDETAIL_TIPS', compa::encodeutf('Inform�ci� arr�l, hogy sikeres volt-e a lev�l elk�ld�se az egyes feliratkoz�knak. Alapban csak �ttekint�st k�ld.'));
define('_ACA_SEND_LOGCLOSED', compa::encodeutf('Napl� k�ld�se, ha megszakad a kapcsolat'));
define('_ACA_SEND_LOGCLOSED_TIPS', compa::encodeutf('Ezzel az opci�val a k�ld� minden esetben jelent�st kap az elk�ld�sekr�l.'));
define('_ACA_SAVE_LOG', compa::encodeutf('Napl� ment�se'));
define('_ACA_SAVE_LOG_TIPS', compa::encodeutf('A levelez�s napl�bejegyz�se beker�lj�n-e a napl�f�jlba?'));
define('_ACA_SAVE_LOGDETAIL', compa::encodeutf('R�szletes napl� ment�se'));
define('_ACA_SAVE_LOGDETAIL_TIPS', compa::encodeutf('A r�szletes bejegyz�s tartalmazza minden feliratkoz�hoz elk�ld�tt lev�l sikeress�g�t vagy meghi�sul�s�t. At egyszer� csak �ttekint�st ad.'));
define('_ACA_SAVE_LOGFILE', compa::encodeutf('Napl�f�jl ment�se'));
define('_ACA_SAVE_LOGFILE_TIPS', compa::encodeutf('Az a f�jl, amibe a napl�bejegyz�s ker�l.Ez a f�jl nagy m�ret�re is n�vekedhet.'));
define('_ACA_CLEAR_LOG', compa::encodeutf('Napl� t�rl�se'));
define('_ACA_CLEAR_LOG_TIPS', compa::encodeutf('T�rli a napl� f�jl tartalm�t.'));

### control panel
define('_ACA_CP_LAST_QUEUE', compa::encodeutf('Utolj�ra lefuttatott feladat'));
define('_ACA_CP_TOTAL', compa::encodeutf('�sszes'));
define('_ACA_MAILING_COPY', compa::encodeutf('A levelez�s sikeresen m�solva!'));

// Miscellaneous settings
define('_ACA_SHOW_GUIDE', compa::encodeutf('Sorvezet� haszn�lata'));
define('_ACA_SHOW_GUIDE_TIPS', compa::encodeutf('Jelen�tse meg a sorvezet�t a haszn�lat elej�n seg�tve az �j felhaszn�l�kat egy h�rlv�l, egy automatikus v�laszol� l�trehoz�s�ban �s az Acajoom megfelel� be�ll�t�s�ban.'));
define('_ACA_AUTOS_ON', compa::encodeutf('Automatikus v�laszol�k haszn�lata'));
define('_ACA_AUTOS_ON_TIPS', compa::encodeutf('V�lasszon Nem-et, ha nem akarja haszn�lni az automatikus v�laszok�kat, minden automatikus v�laszol� kikapcsol.'));
define('_ACA_NEWS_ON', compa::encodeutf('H�rlevelek haszn�lata'));
define('_ACA_NEWS_ON_TIPS', compa::encodeutf('V�lasszon Nem-t, ha nem akarja haszn�lni a h�rleveleket, minden h�rlev�l opci� kikapcsol.'));
define('_ACA_SHOW_TIPS', compa::encodeutf('Tippek megjelen�t�se'));
define('_ACA_SHOW_TIPS_TIPS', compa::encodeutf('Tippek megjelen�t�se a nagyobb hat�konys�g �rdek�ben.'));
define('_ACA_SHOW_FOOTER', compa::encodeutf('L�bl�c megjelen�t�se'));
define('_ACA_SHOW_FOOTER_TIPS', compa::encodeutf('Megjelenjen-e a l�bl�c a copyright sz�veggel.'));
define('_ACA_SHOW_LISTS', compa::encodeutf('List�k megjelen�t�se a webes fel�leten'));
define('_ACA_SHOW_LISTS_TIPS', compa::encodeutf('Ha a felhaszn�l� nincs bejelentkezve, megjelen�ti a list�t illetve bejelentkezhetnek vagy regisztr�lhatnak.'));
define('_ACA_CONFIG_UPDATED', compa::encodeutf('A konfigur�ci�s be�l�t�sok friss�tve!'));
define('_ACA_UPDATE_URL', compa::encodeutf('URL friss�t�se'));
define('_ACA_UPDATE_URL_WARNING', compa::encodeutf('Figyelem! Ne v�ltoztassa meg az URL-t, hacsak nem k�rt enged�lyt az Acajoom technikai csapat�t�l.<br />'));
define('_ACA_UPDATE_URL_TIPS', compa::encodeutf('P�ld�ul: http://www.ijoobi.com/update/ (tartalmazza a lez�r� perjelet)'));

// module
define('_ACA_EMAIL_INVALID', compa::encodeutf('A megadott email c�m �rv�nytelen!'));
define('_ACA_REGISTER_REQUIRED', compa::encodeutf('Regisztr�ljon a feliratkoz�s el�tt!'));

// Access level box
define('_ACA_OWNER', compa::encodeutf('Lista k�sz�t�:'));
define('_ACA_ACCESS_LEVEL', compa::encodeutf('Adja meg a lista hozz�f�r�s�nek a szintj�t!'));
define('_ACA_ACCESS_LEVEL_OPTION', compa::encodeutf('Hozz�f�r�si szint opci�k'));
define('_ACA_USER_LEVEL_EDIT', compa::encodeutf('V�lassza ki, melyik szintnek van enged�lyezve a levelez�sek szerkeszt�se (a webes vagy az adminisztr�ci�s fel�letr�l'));

//  drop down options
define('_ACA_AUTO_DAY_CH1', compa::encodeutf('Naponta'));
define('_ACA_AUTO_DAY_CH2', compa::encodeutf('Naponta h�tv�ge kiv�tel�vel'));
define('_ACA_AUTO_DAY_CH3', compa::encodeutf('Minden m�snap'));
define('_ACA_AUTO_DAY_CH4', compa::encodeutf('Minden m�snap h�tv�ge kiv�tel�vel'));
define('_ACA_AUTO_DAY_CH5', compa::encodeutf('Hetente'));
define('_ACA_AUTO_DAY_CH6', compa::encodeutf('K�thetente'));
define('_ACA_AUTO_DAY_CH7', compa::encodeutf('Havonta'));
define('_ACA_AUTO_DAY_CH9', compa::encodeutf('�vente'));
define('_ACA_AUTO_OPTION_NONE', compa::encodeutf('Nem'));
define('_ACA_AUTO_OPTION_NEW', compa::encodeutf('�j felhaszn�l�k'));
define('_ACA_AUTO_OPTION_ALL', compa::encodeutf('�sszes felhaszn�l�'));

//
define('_ACA_UNSUB_MESSAGE', compa::encodeutf('Leiratkoz� lev�l'));
define('_ACA_UNSUB_SETTINGS', compa::encodeutf('Leiratkoz� be�ll�t�sok'));
define('_ACA_AUTO_ADD_NEW_USERS', compa::encodeutf('Felhaszn�l�k automatikus feliratkoz�sa?'));

// Update and upgrade messages
define('_ACA_NO_UPDATES', compa::encodeutf('Jelenleg nincs el�rhet� friss�t�s.'));
define('_ACA_VERSION', compa::encodeutf('Acajoom verzi�'));
define('_ACA_NEED_UPDATED', compa::encodeutf('Friss�tend� f�jlok:'));
define('_ACA_NEED_ADDED', compa::encodeutf('Hozz�adand� f�jlok:'));
define('_ACA_NEED_REMOVED', compa::encodeutf('Elt�vol�tand� f�jlok:'));
define('_ACA_FILENAME', compa::encodeutf('F�jln�v:'));
define('_ACA_CURRENT_VERSION', compa::encodeutf('Aktu�lis verzi�:'));
define('_ACA_NEWEST_VERSION', compa::encodeutf('Legfrissebb verzi�:'));
define('_ACA_UPDATING', compa::encodeutf('Friss�t�s'));
define('_ACA_UPDATE_UPDATED_SUCCESSFULLY', compa::encodeutf('A f�jlok sikeresen friss�tve.'));
define('_ACA_UPDATE_FAILED', compa::encodeutf('A friss�t�s meghi�sult'));
define('_ACA_ADDING', compa::encodeutf('Hozz�ad�s'));
define('_ACA_ADDED_SUCCESSFULLY', compa::encodeutf('Sikeresen hozz�adva.'));
define('_ACA_ADDING_FAILED', compa::encodeutf('A hozz�ad�s meghi�sult!'));
define('_ACA_REMOVING', compa::encodeutf('Elt�vol�t�s'));
define('_ACA_REMOVED_SUCCESSFULLY', compa::encodeutf('Sikeresen elt�vol�tva.'));
define('_ACA_REMOVING_FAILED', compa::encodeutf('Az elt�vol�t�s meghi�sult!'));
define('_ACA_INSTALL_DIFFERENT_VERSION', compa::encodeutf('M�sik verzi� telep�t�se'));
define('_ACA_CONTENT_ADD', compa::encodeutf('Tartalom hozz�ad�s'));
define('_ACA_UPGRADE_FROM', compa::encodeutf('Adatok import�l�sa (n�vlev�l �s feliratkoz� inform�ci�) : '));
define('_ACA_UPGRADE_MESS', compa::encodeutf('A l�tez� adatok nincsenek vesz�lyben.<br />Ez a m�velet csak import�lja az adatokat az Acajoom adatb�zis�ba.'));
define('_ACA_CONTINUE_SENDING', compa::encodeutf('K�ld�s folytat�sa'));

// Acajoom message
define('_ACA_UPGRADE1', compa::encodeutf('K�nnyen import�lhatja a felhaszn�l�kat �s a h�rleveleket: '));
define('_ACA_UPGRADE2', compa::encodeutf(' az Acajoomba a friss�t�si panelen.'));
define('_ACA_UPDATE_MESSAGE', compa::encodeutf('El�rhet� az Acajoom �j verzi�ja! '));
define('_ACA_UPDATE_MESSAGE_LINK', compa::encodeutf('Kattintson ide a friss�t�shez!'));
define('_ACA_THANKYOU', compa::encodeutf('K�sz�nj�k, hogy az Acajoom-ot, az �n kommunik�ci�s partner�t v�lasztotta!'));
define('_ACA_NO_SERVER', compa::encodeutf('A friss�t� szerver nem �rhet� el, ellen�rizze k�s�bb!'));
define('_ACA_MOD_PUB', compa::encodeutf('Az Acajoom modul m�g nincs publik�lva!'));
define('_ACA_MOD_PUB_LINK', compa::encodeutf('Kattintson ide a publik�l�shoz!'));
define('_ACA_IMPORT_SUCCESS', compa::encodeutf('Sikeresen import�lva'));
define('_ACA_IMPORT_EXIST', compa::encodeutf('A feliratkoz� m�r az adatb�zisban van'));

// Acajoom's Guide
define('_ACA_GUIDE', compa::encodeutf(' var�zsl�'));
define('_ACA_GUIDE_FIRST_ACA_STEP', compa::encodeutf('<p>Az Acajoom sz�mtalan saj�ts�ggal rendelkezik, ez a var�zsl� v�gig vezeti �nt n�gy egyszer� l�p�sen, amellyel el tudja k�sz�teni h�rleveleit �s automatikus v�laszol�it!<p />'));
define('_ACA_GUIDE_FIRST_ACA_STEP_DESC', compa::encodeutf('Els� l�p�sk�nt l�tre kell hozni egy list�t. Egy lista k�t t�pus egyike lehet vagy h�rlev�l vagy automatikus v�laszol�. A list�ban param�terekkel lehet szab�lyozni a h�rlevelek k�ld�s�t �s �s az automatikus v�laszol�k m�k�d�s�t: k�ld� neve, kialak�t�s, feliratkoz�k �dv�zl� �zenetei stb.<br /><br />Itt k�sz�theti el az els� list�t: <a href="index2.php?option=com_acajoom&act=list" >lista k�sz�t�s</a> �s kattintson a New gombon!'));
define('_ACA_GUIDE_FIRST_ACA_STEP_UPGRADE', compa::encodeutf('Az Acajoom lehet�s�get ny�jt egy kor�bbi h�rlev�l rendszerv�l adatok import�l�s�ra.<br />Menjen a Friss�t�s panelre �s v�lassza ki azt a h�rlev�l rendszert, ahonnan import�lni szeretn� a h�rleveleket �s a feliratkoz�kat.<br /><br /><span style="color:#FF5E00;" >Fontos: az import�l�s nem �rinti a kor�bbi h�rlev�l rendszer adatait.</span><br />Az import�l�s ut�n a levelez�seket �s a feliratkoz�kat k�zvetlen�l az Acajoom-ban tudja kezelni.<br /><br />'));
define('_ACA_GUIDE_SECOND_ACA_STEP', compa::encodeutf('Gratul�kunk, elk�sz�lt az els� lista!  Meg�rhatja az els� valamit: %s.  Ehhet menjen ide: '));
define('_ACA_GUIDE_SECOND_ACA_STEP_AUTO', compa::encodeutf('Automatikus v�laszol� kezel�'));
define('_ACA_GUIDE_SECOND_ACA_STEP_NEWS', compa::encodeutf('H�rlev�l kezel�'));
define('_ACA_GUIDE_SECOND_ACA_STEP_FINAL', compa::encodeutf(' �s v�lassza ki: %s. <br />Majd v�lassza: %s a leg�rd�l� list�ban. Az els� levelez�s elk�sz�t�s�hez kattintson a New gombra!'));

define('_ACA_GUIDE_THRID_ACA_STEP_NEWS', compa::encodeutf('Miel�tt elk�ldi az els� h�rlevelet, be kell �ll�tani a levelez�si konfigur�ci�t. Menjen a <a href="index2.php?option=com_acajoom&act=configuration" >be�ll�t�sok oldalra</a> ellen�rizni a be�ll�t�sokat. <br />'));
define('_ACA_GUIDE_THRID2_ACA_STEP_NEWS', compa::encodeutf('<br />Ha ez k�sz, menjen vissza a H�rlevelek men�be �s v�lassza ki a levelet �s kattintson a K�ld�s gombra!'));

define('_ACA_GUIDE_THRID_ACA_STEP_AUTOS', compa::encodeutf('Az els� automatikus v��laszol� hasznlat�hoz egy id�z�t�t kell be�ll�tania a szerveren. Keresse meg a be�ll�t�sok panelen az Id�z�t� f�let! <a href="index2.php?option=com_acajoom&act=configuration" >Kattintson ide</a> az id�z�t� be�ll�t�s�val kapcsolatps tov�bbi inform�ci�k�rt!<br />'));

define('_ACA_GUIDE_MODULE', compa::encodeutf(' <br />Ellen�rizze, hogy publik�lta-e az Acajoom modult, amivel a �rdekl�d�k feliratkozhatnak a list�ra.'));

define('_ACA_GUIDE_FOUR_ACA_STEP_NEWS', compa::encodeutf(' Be�ll�thatja az automatikus v�laszol�t is.'));
define('_ACA_GUIDE_FOUR_ACA_STEP_AUTOS', compa::encodeutf(' Be�ll�that egy h�rlevelet is!'));

define('_ACA_GUIDE_FOUR_ACA_STEP', compa::encodeutf('<p><br />�n k�szen �ll a hat�kony kapcsolatra l�togat�ival �s felhaszn�l�ival. Ez a var�zsl� befejezi m�k�d�s�t, amint elk�sz�ti a m�sodik levelez�st vagy kikapcsolhatja <a href="index2.php?option=com_acajoom&act=configuration" >be�ll�t�sok panelen</a>.<br /><br />Ha k�rd�se van az Acajoom, haszn�lat�val kapcsolatban, haszn�lja a <a target="_blank" href="http://www.ijoobi.com/index.php?option=com_agora&Itemid=60" >f�rumot</a>! Emellett sz�mos inform�ci�t is tal�l, hogy kommunik�ljon hat�konyan a feliratkoz�kkal a <a href="http://www.ijoobi.com/" target="_blank">www.ijoobi.com</a> oldal�n.<p /><br /><b>K�sz�nj�k, hogy az Acajoom-ot haszn�lja. Az �n kommunik�ci�s partnere!</b> '));
define('_ACA_GUIDE_TURNOFF', compa::encodeutf('A var�zsl� kikapcsol�sra ker�l.'));
define('_ACA_STEP', compa::encodeutf('l�p�s '));

// Acajoom Install
define('_ACA_INSTALL_CONFIG', compa::encodeutf('Acajoom be�ll�t�s'));
define('_ACA_INSTALL_SUCCESS', compa::encodeutf('Sikeres telep�t�s'));
define('_ACA_INSTALL_ERROR', compa::encodeutf('Telep�t�si hiba'));
define('_ACA_INSTALL_BOT', compa::encodeutf('Acajoom be�p�l� (robot)'));
define('_ACA_INSTALL_MODULE', compa::encodeutf('Acajoom modul'));
//Others
define('_ACA_JAVASCRIPT', compa::encodeutf('Figyelem: A Javascript-et enged�lyezni kell a megfelel� m�k�d�shez.'));
define('_ACA_EXPORT_TEXT', compa::encodeutf('Az export�lt feliratkoz�k a v�laszott list�n alapulnak.<br />Feliratkoz�k export�l�sa list�b�l'));
define('_ACA_IMPORT_TIPS', compa::encodeutf('Feliratkoz�k import�l�sa. A f�jlban lev� tartalomnak az al�bbi form�tum�nak kell lennie: <br />Name,Email,ReceiveHTML(1/0),<span style="color: rgb(255, 0, 0);">Registered(1/0)</span>'));
define('_ACA_SUBCRIBER_EXIT', compa::encodeutf('m�r l�tez� feliratkoz�'));
define('_ACA_GET_STARTED', compa::encodeutf('Kattintson ide az ind�t�shoz!'));

//News since 1.0.1
define('_ACA_WARNING_1011', compa::encodeutf('Figyelem: 1011: A friss�t�s nem m�k�dik, mert a szerver visszautas�totta.'));
define('_ACA_SEND_MAIL_FROM_TIPS', compa::encodeutf('used as Bounced back for all your messages'));
define('_ACA_SEND_MAIL_NAME_TIPS', compa::encodeutf('V�lassza ki, milyen n�v jelenjen meg k�ld�k�nt!'));
define('_ACA_MAILSENDMETHOD_TIPS', compa::encodeutf('V�lassza ki milyen lev�lk�ld�t szeretne jaszn�lni: PHP mail f�ggv�ny, <span>Sendmail</span> or SMTP szerver.'));
define('_ACA_SENDMAILPATH_TIPS', compa::encodeutf('Ez a lev�l szerver k�nyvt�ra'));
define('_ACA_LIST_T_TEMPLATE', compa::encodeutf('Sablon'));
define('_ACA_NO_MAILING_ENTERED', compa::encodeutf('Nincs levelez�s megadva'));
define('_ACA_NO_LIST_ENTERED', compa::encodeutf('Nincs lista megadva'));
define('_ACA_SENT_MAILING', compa::encodeutf('Levelek elk�ld�se'));
define('_ACA_SELECT_FILE', compa::encodeutf('V�lasszon egy f�jlt: '));
define('_ACA_LIST_IMPORT', compa::encodeutf('Ellen�rizze a list�t, amelyhez feliratkoz�kat szeretne hozz�rendelni.'));
define('_ACA_PB_QUEUE', compa::encodeutf('A feliratkoz� be lett sz�rva de probl�ma van vele a list�hoz csatol�sn�l. Ellen�rizze manu�lisan!'));
define('_ACA_UPDATE_MESS', compa::encodeutf(''));
define('_ACA_UPDATE_MESS1', compa::encodeutf('A friss�t�s er�sen aj�nlott!'));
define('_ACA_UPDATE_MESS2', compa::encodeutf('Folt �s kisebb jav�t�sok.'));
define('_ACA_UPDATE_MESS3', compa::encodeutf('�j kiad�s.'));
define('_ACA_UPDATE_MESS5', compa::encodeutf('Joomla 1.5 sz�ks�ges a friss�t�shez.'));
define('_ACA_UPDATE_IS_AVAIL', compa::encodeutf(' el�rhet�!'));
define('_ACA_NO_MAILING_SENT', compa::encodeutf('Nem lett elk�ldve lev�l!'));
define('_ACA_SHOW_LOGIN', compa::encodeutf('Bejelentkez�si �rlap megjelen�t�se'));
define('_ACA_SHOW_LOGIN_TIPS', compa::encodeutf('V�lasszon Igen-t, ha szeretn�, hogy a bejelentkez�si �rlap megjelenjen az Acajoom webes fel�let�nek vez�rl�pultj�n, hogy a felhaszn�l�k regisztr�lhassanak a webhelyen..'));
define('_ACA_LISTS_EDITOR', compa::encodeutf('Lista le�r� szerkeszt�'));
define('_ACA_LISTS_EDITOR_TIPS', compa::encodeutf('V�lasszon Igen-t HTML sz�vegszerkeszt� haszn�lat�hoz a a lista le�r�s�nak mez�j�ben.'));
define('_ACA_SUBCRIBERS_VIEW', compa::encodeutf('Feliratkoz�k megtekint�se'));

//News since 1.0.2
define('_ACA_FRONTEND_SETTINGS', compa::encodeutf('Webes be�ll�t�sok'));
define('_ACA_SHOW_LOGOUT', compa::encodeutf('Kijelentkez�s gomb megjelen�t�se'));
define('_ACA_SHOW_LOGOUT_TIPS', compa::encodeutf('V�lassza az Igen-t, ha meg akarja jelen�teni a Kijelentkez�s gombot az AcaJoom vez�rl�pult webes fel�let�n.'));

//News since 1.0.3 CB integration
define('_ACA_CONFIG_INTEGRATION', compa::encodeutf('Integr�ci�'));
define('_ACA_CB_INTEGRATION', compa::encodeutf('Community Builder integr�ci�'));
define('_ACA_INSTALL_PLUGIN', compa::encodeutf('Community Builder be�p�l� (Acajoom integr�ci�) '));
define('_ACA_CB_PLUGIN_NOT_INSTALLED', compa::encodeutf('Az Acajoom be�p�l� a Community Builderbe m�g nincs telep�tve!'));
define('_ACA_CB_PLUGIN', compa::encodeutf('List�k regisztr�l�skor'));
define('_ACA_CB_PLUGIN_TIPS', compa::encodeutf('V�lassza az Igen-t, ha a levelez� list�kat meg akarja jelen�teni a Community Builder regisztr�ci�s �rlapj�n'));
define('_ACA_CB_LISTS', compa::encodeutf('Lista azonos�t�k'));
define('_ACA_CB_LISTS_TIPS', compa::encodeutf('EZ K�TELEZ� MEZ�. Adja meg a list�k azonos�t�j�t vessz�vel elv�lasztva, amely ekre a felhaszn�l� feliratkozhat . (0 az �sszes list�t megjelen�ti)'));
define('_ACA_CB_INTRO', compa::encodeutf('Bevezet� sz�veg'));
define('_ACA_CB_INTRO_TIPS', compa::encodeutf('A lista el�tt megjelen� sz�veg. HAGYJA �RESEN, HA NEM AKAR MEGJELEN�TENI SEMMIT!. Haszn�lja a cb_pretext-et a CSS-hez!.'));
define('_ACA_CB_SHOW_NAME', compa::encodeutf('Listan�v megjelen�t�se'));
define('_ACA_CB_SHOW_NAME_TIPS', compa::encodeutf('D�ntse el, hogy szeretn�-e megjelen�teni a listaneveket a bevezet� ut�n!'));
define('_ACA_CB_LIST_DEFAULT', compa::encodeutf('List�k bejel�l�se alap�rtelmez�sk�nt'));
define('_ACA_CB_LIST_DEFAULT_TIPS', compa::encodeutf('D�ntse el, hogy szeretn�-e alap�rtelmez�sk�nt bejel�lni minden list�t!'));
define('_ACA_CB_HTML_SHOW', compa::encodeutf('HTML form�tumban?'));
define('_ACA_CB_HTML_SHOW_TIPS', compa::encodeutf('V�lassza az Igen-t, ha a felhaszn�l�k eld�nthetik, hogy szeretn�nek-e HTML leveleket vagy sem. �ll�tsa Nem-re, ha alap�rtelmez�sk�nt HTML levelet akar haszn�lni!'));
define('_ACA_CB_HTML_DEFAULT', compa::encodeutf('Alap�rtelmezetten HTML form�tumban?'));
define('_ACA_CB_HTML_DEFAULT_TIPS', compa::encodeutf('�ll�tsa be ezt a lehet�s�get az alap�rtelmezett HTML levelez�si be�ll�t�sok megjelen�t�s�hez! Ha a HTML form�tumban? bejegyz�s Nem, akkor ez az opci� lesz az alap�rtelmezett.'));

// Since 1.0.4
define('_ACA_BACKUP_FAILED', compa::encodeutf('A f�jlr�l nem k�sz�thet� biztons�gi m�solat! A f�jl nem ker�lt lecser�l�sre.'));
define('_ACA_BACKUP_YOUR_FILES', compa::encodeutf('A f�jlok r�gebbi verzi�ja ment�sre ker�lt a k�vetkez� k�nyvt�rban:'));
define('_ACA_SERVER_LOCAL_TIME', compa::encodeutf('Helyi szerver id�'));
define('_ACA_SHOW_ARCHIVE', compa::encodeutf('Arch�vum gomb megjelen�t�se'));
define('_ACA_SHOW_ARCHIVE_TIPS', compa::encodeutf('V�lasszon Igen-t a h�rlevelek list�j�nak v�g�n az Arch�vum gomb megjelen�t�s�hez'));
define('_ACA_LIST_OPT_TAG', compa::encodeutf('K�dok'));
define('_ACA_LIST_OPT_IMG', compa::encodeutf('K�pek'));
define('_ACA_LIST_OPT_CTT', compa::encodeutf('Tartalom'));
define('_ACA_INPUT_NAME_TIPS', compa::encodeutf('Adja meg a teljes nev�t (a keresztnev�vel kezdje)!'));
define('_ACA_INPUT_EMAIL_TIPS', compa::encodeutf('Adja meg az email c�m�t! Ellen�rizze, hogy ez egy val�di email c�m, ha val�ban szeretne h�rleveletet kapni!'));
define('_ACA_RECEIVE_HTML_TIPS', compa::encodeutf('V�lasszon Igen-t, ha HTML h�rleveleket szeretne kapni - vagy Nem-et, ha csak sz�veges h�rleveleket.'));
define('_ACA_TIME_ZONE_ASK_TIPS', compa::encodeutf('Adja meg az id�z�n�j�t!'));

// Since 1.0.5
define('_ACA_FILES', compa::encodeutf('F�jlok'));
define('_ACA_FILES_UPLOAD', compa::encodeutf('Felt�lt�s'));
define('_ACA_MENU_UPLOAD_IMG', compa::encodeutf('K�pek felt�lt�se'));
define('_ACA_TOO_LARGE', compa::encodeutf('A f�jl m�rete t�l nagy. A maxim�lis m�ret:'));
define('_ACA_MISSING_DIR', compa::encodeutf('A c�lk�nyvt�r nem l�tezik'));
define('_ACA_IS_NOT_DIR', compa::encodeutf('A c�lk�nyvt�r nem l�tezik vagy pedig egy szab�lyos f�jl.'));
define('_ACA_NO_WRITE_PERMS', compa::encodeutf('A c�lk�nyvt�ron nincs �r�si jog.'));
define('_ACA_NO_USER_FILE', compa::encodeutf('Nem v�laszotta ki a felt�ltend� f�jlt!'));
define('_ACA_E_FAIL_MOVE', compa::encodeutf('A f�jl nem helyezhet� �t!'));
define('_ACA_FILE_EXISTS', compa::encodeutf('A c�lf�jl m�r l�tezik.'));
define('_ACA_CANNOT_OVERWRITE', compa::encodeutf('A c�lf�jl m�r l�tezik vagy nem �rhat� fel�l.'));
define('_ACA_NOT_ALLOWED_EXTENSION', compa::encodeutf('Nem enged�lyezett f�jlkiterjeszt�s.'));
define('_ACA_PARTIAL', compa::encodeutf('A f�jl csak r�szben ker�lt felt�lt�sre.'));
define('_ACA_UPLOAD_ERROR', compa::encodeutf('Felt�lt�si hiba:'));
define('DEV_NO_DEF_FILE', compa::encodeutf('A f�jl csak r�szben ker�lt felt�lt�sre.'));

// already exist but modified  added a <br/ on first line and added [SUBSCRIPTIONS] line>
define('_ACA_CONTENTREP', compa::encodeutf('[SUBSCRIPTIONS] = Ez lecser�l�sre ker�l a feliratkoz�si linkekkel. Ez <strong>sz�ks�ges</strong> az Acajoom helyes m�k�d�s�hez.<br />Ha b�rmilyen m�s tartalmat helyez el ebben a dobozban, ez a lista �sszes levelez�s�ben meg fog jelenni.<br />Tegye a saj�t feiratkoz�si �zeneteit a v�g�re Az Acajoom automatikusan hozz�adja a feliratkoz�s megv�ltoztat�s�hoz �s a leiratkoz�shoz sz�ks�ges linkeket.'));

// since 1.0.6
define('_ACA_NOTIFICATION', compa::encodeutf('�rtes�t�s'));  // shortcut for Email notification
define('_ACA_NOTIFICATIONS', compa::encodeutf('�rtes�t�sek'));
define('_ACA_USE_SEF', compa::encodeutf('SEF a levelez�sben'));
define('_ACA_USE_SEF_TIPS', compa::encodeutf('Aj�nlott a nem v�laszt�sa. Ha szeretn�, hogy a levelez�sben haszn�lt URL haszn�lja a SEF-et, akkor v�lassza az igent!<br /><b>A linkek mindegyik opci�hoz ugyan�gy m�k�dnek. Nem biztos, hogy a levelez�sben a linkek mindig m�k�dnek, ha megv�ltozik a SEF.</b> '));
define('_ACA_ERR_SETTINGS', compa::encodeutf('Hibakezel� be�ll�t�sok'));
define('_ACA_ERR_SEND', compa::encodeutf('Hiba jelent�s k�ld�se'));
define('_ACA_ERR_SEND_TIPS', compa::encodeutf('Ha szeretn�, hogy az Acajoom jobb term�kk� v�ljon, v�lassza az Igen-t! Ez hibajelent�st k�ld a fejleszt�knek. �gy nem sz�ks�ges hibakutat�st v�geznie.<br /> <b>SEMMILYEN MAG�NJELLEG� INFORM�CI�NEM KER�L ELK�LD�SRE</b>. M�g azt sem fogj�k tudni, melyik webhelyr�l �rkezik a hibajelent�s. Csak az Acojoomr�l kapnak informci�t, a PHP be�ll�t�sokr�l �s az SQL lek�rdez�sekr�l. '));
define('_ACA_ERR_SHOW_TIPS', compa::encodeutf('V�lasszon Igen-t a hiba sorsz�m�nak megjelen�t�s�hez a k�perny�n. F�leg hibakeres�sre lehet haszn�lni. '));
define('_ACA_ERR_SHOW', compa::encodeutf('Hib�k megjelen�t�se'));
define('_ACA_LIST_SHOW_UNSUBCRIBE', compa::encodeutf('Leiratkoz�si linkek megtekint�se'));
define('_ACA_LIST_SHOW_UNSUBCRIBE_TIPS', compa::encodeutf('V�lasszon Igen-t a leiratkoz�so linkek megjelen�t�s�hez  a lev�l alj�n, ahol a felhaszn�l�k megv�ltoztathatj�k a feliratkoz�saikat. <br /> A Nem letiltja a l�bl�cet �s a linkeket.'));
define('_ACA_UPDATE_INSTALL', compa::encodeutf('<span style="color: rgb(255, 0, 0);">FONTOS MEGJEGYZ�S!</span> <br />Ha kor�bbi Acajoom verzi�r�l friss�t, friss�teni kell az adatb�zis strukt�r�t is a k�vetkez� gombra kattintva (az adatok integrit�sa megmarad)'));
define('_ACA_UPDATE_INSTALL_BTN', compa::encodeutf('A t�bl�k �s a be�ll�t�sok friss�t�se'));
define('_ACA_MAILING_MAX_TIME', compa::encodeutf('Maxim�lis v�rakoz�si id�'));
define('_ACA_MAILING_MAX_TIME_TIPS', compa::encodeutf('Megadja azt a maxim�lis id�t, ameddig a leveleknek v�rakozniuk kell asorban. Az aj�nlott �rt�k 30 m�sodperc �s 2 perc k�z�ztt van.'));

// virtuemart integration beta
define('_ACA_VM_INTEGRATION', compa::encodeutf('VirtueMart integr�ci�'));
define('_ACA_VM_COUPON_NOTIF', compa::encodeutf('Kupon �rtes�t�si azonos�t�'));
define('_ACA_VM_COUPON_NOTIF_TIPS', compa::encodeutf('Megadja a levelez�s azonos�t�sz�m�t, amit kuponok k�ld�sekor szeretne haszn�lni.'));
define('_ACA_VM_NEW_PRODUCT', compa::encodeutf('�j term�k �rtes�t�s azonos�t�'));
define('_ACA_VM_NEW_PRODUCT_TIPS', compa::encodeutf('Megadja a levelez�s azonos�t�sz�m�t, amit �j term�k �rtes�t�sn�l szeretne haszn�lni.'));

// since 1.0.8
// create forms for subscriptions
define('_ACA_FORM_BUTTON', compa::encodeutf('�rlap l�trehoz�sa'));
define('_ACA_FORM_COPY', compa::encodeutf('HTML k�d'));
define('_ACA_FORM_COPY_TIPS', compa::encodeutf('M�solja a gener�lt HTML k�dot a HTML oldalra!'));
define('_ACA_FORM_LIST_TIPS', compa::encodeutf('V�lassza ki a list�b�l az �rlapba besz�rand� tartalmat!'));
// update messages
define('_ACA_UPDATE_MESS4', compa::encodeutf('Nem friss�thet� automatikusan.'));
define('_ACA_WARNG_REMOTE_FILE', compa::encodeutf('T�voli f�jl nem �rhet� el.'));
define('_ACA_ERROR_FETCH', compa::encodeutf('Hiba a f�jl el�r�sekor.'));

define('_ACA_CHECK', compa::encodeutf('Ellen�rz�s'));
define('_ACA_MORE_INFO', compa::encodeutf('Tov�bbi inf�'));
define('_ACA_UPDATE_NEW', compa::encodeutf('Friss�t�s �jabb verzi�ra'));
define('_ACA_UPGRADE', compa::encodeutf('Friss�t�s a legfrissebb term�kre'));
define('_ACA_DOWNDATE', compa::encodeutf('Vissza�ll�s el�z� verzi�ra'));
define('_ACA_DOWNGRADE', compa::encodeutf('Vissza az alapterm�kre'));
define('_ACA_REQUIRE_JOOM', compa::encodeutf('Joomla sz�ks�ges'));
define('_ACA_TRY_IT', compa::encodeutf('Pr�b�lja ki!'));
define('_ACA_NEWER', compa::encodeutf('�jabb'));
define('_ACA_OLDER', compa::encodeutf('R�gebbi'));
define('_ACA_CURRENT', compa::encodeutf('Aktu�lis'));

// since 1.0.9
define('_ACA_CHECK_COMP', compa::encodeutf('Pr�b�ljon ki egyet a t�bbi komponens k�z�l!'));
define('_ACA_MENU_VIDEO', compa::encodeutf('Vide� bemutat�k'));
define('_ACA_SCHEDULE_TITLE', compa::encodeutf('Automatikus id�be�ll�t� funkci� be�ll�t�sa'));
define('_ACA_ISSUE_NB_TIPS', compa::encodeutf('A kiad�s sz�m�nak automatikus gener�l�sa'));
define('_ACA_SEL_ALL', compa::encodeutf('�sszes levelez�s'));
define('_ACA_SEL_ALL_SUB', compa::encodeutf('�sszes lista'));
define('_ACA_INTRO_ONLY_TIPS', compa::encodeutf('Ha kipip�lja ezt a dobozt, csak a cikk bevezet� sz�vege ker�l be a lev�lbe egy Tov�bb linkkel.'));
define('_ACA_TAGS_TITLE', compa::encodeutf('Tartalom k�d'));
define('_ACA_TAGS_TITLE_TIPS', compa::encodeutf('V�g�lapon kereszt�l tegye ezt a k�dot a lev�l, ahol a tartalmat szeretn� elhelyezni.'));
define('_ACA_PREVIEW_EMAIL_TEST', compa::encodeutf('Jelzi az email c�met, ahova a tesztet el kell k�ldeni'));
define('_ACA_PREVIEW_TITLE', compa::encodeutf('El�n�zet'));
define('_ACA_AUTO_UPDATE', compa::encodeutf('�j friss�t�si �rtes�t�s'));
define('_ACA_AUTO_UPDATE_TIPS', compa::encodeutf('V�lasszon Igen-t, ha szeretne �rtes�t�st a komponens friss�t�s�r�l! <br />FONTOS! A tippek megjelen�t�se sz�ks�ges ennek afunkci�nak a m�k�d�s�hez.'));

// since 1.1.0
define('_ACA_LICENSE', compa::encodeutf('Licensz inform�ci�'));

// since 1.1.1
define('_ACA_NEW', compa::encodeutf('�j'));
define('_ACA_SCHEDULE_SETUP', compa::encodeutf('Az automatikus v�laszol� m�k�d�s�hez be kell �ll�tani az id�z�t�t a be�ll�t�sokn�l..'));
define('_ACA_SCHEDULER', compa::encodeutf('Id�z�t�'));
define('_ACA_ACAJOOM_CRON_DESC', compa::encodeutf('ha nincs hozz�f�r�se a webhelyen az id�z�t� feladat kezel�h�z, regisztr�lhat egy ingyenes Acajoom id�z�t�t itt:'));
define('_ACA_CRON_DOCUMENTATION', compa::encodeutf('Az Acajoom id�z�t� be�ll�t�saihoz tov�bbi inform�ci�kat itt tal�l:'));
define('_ACA_CRON_DOC_URL', compa::encodeutf('<a href="http://www.ijoobi.com/index.php?option=com_content&view=article&id=4249&catid=29&Itemid=72"
 target="_blank">http://www.ijoobi.com/index.php?option=com_content&Itemid=72&view=category&layout=blog&id=29&limit=60</a>'));
define( '_ACA_QUEUE_PROCESSED', compa::encodeutf('A feladatsor sikeresen feldolgoz�sra ker�lt...'));
define( '_ACA_ERROR_MOVING_UPLOAD', compa::encodeutf('Hiba az import�lt f�jl mozgat�sa k�zben'));

//since 1.1.2
define( '_ACA_SCHEDULE_FREQUENCY', compa::encodeutf('Id�z�t� gyakoris�g'));
define( '_ACA_CRON_MAX_FREQ', compa::encodeutf('Id�z�t� maxim�lis gyakoris�g'));
define( '_ACA_CRON_MAX_FREQ_TIPS', compa::encodeutf('Adja meg azt a maxim�lis gykoris�got, amikor az id�z�t� fut (percekben).  Ez korl�zozza az id�z�t�t m�g akkor is, ha az id�z�t� feladat gyakoris�ga enn�l r�videbb id�re van be�ll�tva.'));
define( '_ACA_CRON_MAX_EMAIL', compa::encodeutf('Feladatonk�nti maxim�lis lev�lsz�m'));
define( '_ACA_CRON_MAX_EMAIL_TIPS', compa::encodeutf('Megadja meg a feladatonk�nt elk�ldhet� levelek maxim�lis sz�m�t (0 - korl�tlan).'));
define( '_ACA_CRON_MINUTES', compa::encodeutf(' perc'));
define( '_ACA_SHOW_SIGNATURE', compa::encodeutf('Lev�l l�bl�c megjelen�t�se'));
define( '_ACA_SHOW_SIGNATURE_TIPS', compa::encodeutf('Megjelenjen-e az Acajoom-ot n�pszer�s�t� l�bl�c a levelekben.'));
define( '_ACA_QUEUE_AUTO_PROCESSED', compa::encodeutf('Az automatikus v�laszol�k feladatai sikeresen feldolgozva...'));
define( '_ACA_QUEUE_NEWS_PROCESSED', compa::encodeutf('Az id�z�tett h�rlevelek feldolgoz�sa sikeres...'));
define( '_ACA_MENU_SYNC_USERS', compa::encodeutf('Felhaszn�l�k szinkroniz�s�sa'));
define( '_ACA_SYNC_USERS_SUCCESS', compa::encodeutf('A felhaszn�l�k szinkroniz�s�sa sikeres!'));

// compatibility with Joomla 15
if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', compa::encodeutf('Kijelentkez�s'));
if (!defined('_CMN_YES')) define( '_CMN_YES', compa::encodeutf('Igen'));
if (!defined('_CMN_NO')) define( '_CMN_NO', compa::encodeutf('Nem'));
if (!defined('_HI')) define( '_HI', compa::encodeutf('�dv�z�lj�k'));
if (!defined('_CMN_TOP')) define( '_CMN_TOP', compa::encodeutf('Fel�l'));
if (!defined('_CMN_BOTTOM')) define( '_CMN_BOTTOM', compa::encodeutf('Lent'));
//if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', compa::encodeutf('Kijelentkez�s'));

// For include title only or full article in content item tab in newsletter edit - p0stman911
define('_ACA_TITLE_ONLY_TIPS', compa::encodeutf('Ha ezt kijel�li, csak a teljes cikkre mutat� cikk c�m ker�l be linkk�nt a lev�lbe.'));
define('_ACA_TITLE_ONLY', compa::encodeutf('Csak c�m'));
define('_ACA_FULL_ARTICLE_TIPS', compa::encodeutf('Ha ezt kijel�li, a lev�lbe a cikk teljes tartalma beker�l'));
define('_ACA_FULL_ARTICLE', compa::encodeutf('Teljes cikk'));
define('_ACA_CONTENT_ITEM_SELECT_T', compa::encodeutf('V�lasszon ki egy tartalmi elemet, amely beker�l a lev�lba.<br />V�g�lapon kereszt�l helyezze el a <b>tartalom k�dot</b> a lev�lbe!  V�laszthatja a teljes sz�veget, csak a bevezet�t vagy csak a c�met (0, 1, vagy 2). '));
define('_ACA_SUBSCRIBE_LIST2', compa::encodeutf('Levelez� list�k'));

// smart-newsletter function
define('_ACA_AUTONEWS', compa::encodeutf('Gyors h�rlev�l'));
define('_ACA_MENU_AUTONEWS', compa::encodeutf('Gyors h�rlevelek'));
define('_ACA_AUTO_NEWS_OPTION', compa::encodeutf('Gyors h�rlev�l opci�k'));
define('_ACA_AUTONEWS_FREQ', compa::encodeutf('H�rlev�l gyakoris�g'));
define('_ACA_AUTONEWS_FREQ_TIPS', compa::encodeutf('Adja meg azt a gyakoris�got, ami szerint k�ldeni szeretn� a gyors h�rleveleket!'));
define('_ACA_AUTONEWS_SECTION', compa::encodeutf('Cikk szekci�'));
define('_ACA_AUTONEWS_SECTION_TIPS', compa::encodeutf('V�lassza ki a szekci�t, amelyb�l cikket szeretne kijel�lni!'));
define('_ACA_AUTONEWS_CAT', compa::encodeutf('Cikk kateg�ria'));
define('_ACA_AUTONEWS_CAT_TIPS', compa::encodeutf('V�lassza ki a kateg�ri�t, amelyb�l cikket szeretne kijel�lni (Mind - �sszes cikk az adott szekci�b�l)!'));
define('_ACA_SELECT_SECTION', compa::encodeutf('V�lasszon szekci�t!'));
define('_ACA_SELECT_CAT', compa::encodeutf('�sszes kateg�ria'));
define('_ACA_AUTO_DAY_CH8', compa::encodeutf('Negyed�vente'));
define('_ACA_AUTONEWS_STARTDATE', compa::encodeutf('Kezd� d�tum'));
define('_ACA_AUTONEWS_STARTDATE_TIPS', compa::encodeutf('Adja meg azt a kezd� d�tumot, amit�l a gyors h�rleveleket k�ldeni szeretn�!'));
define('_ACA_AUTONEWS_TYPE', compa::encodeutf('Tartalom �ssze�ll�t�s'));// how we see the content which is included in the newsletter
define('_ACA_AUTONEWS_TYPE_TIPS', compa::encodeutf('Teljes cikk: a teljes cikk beker�l a lev�lbe<br />' .		'Csak bevezet�: csak a cikk bevezet�je ker�l be a lev�lbe<br/>' .		'Csak c�m: csak a cikk c�me ker�l be a lev�lbe'));
define('_ACA_TAGS_AUTONEWS', compa::encodeutf('[SMARTNEWSLETTER] = Ezt a gyors h�rlev�l cser�li le.'));

//since 1.1.3
define('_ACA_MALING_EDIT_VIEW', compa::encodeutf('Levelez�s l�trehoz�s / megtekint�s'));
define('_ACA_LICENSE_CONFIG', compa::encodeutf('Licensz'));
define('_ACA_ENTER_LICENSE', compa::encodeutf('Adja meg a licensz k�dot!'));
define('_ACA_ENTER_LICENSE_TIPS', compa::encodeutf('�rja be a licensz k�dot �s mentse el.'));
define('_ACA_LICENSE_SETTING', compa::encodeutf('Licensz be�ll�t�sok'));
define('_ACA_GOOD_LIC', compa::encodeutf('�rv�nyes licensz.'));
define('_ACA_NOTSO_GOOD_LIC', compa::encodeutf('Nem �rv�nyes licensz: '));
define('_ACA_PLEASE_LIC', compa::encodeutf('Vegye fel a kapcsolatot az Acajoom t�mogat�ival a licensz friss�t�se �rdek�ben  ( license@ijoobi.com ).'));
define('_ACA_DESC_PLUS', compa::encodeutf('Az Acajoom Plus az els� szekvenci�lis automatikus v�laszol� komponens Joomla rendszerre.  ' . _ACA_FEATURES));
define('_ACA_DESC_PRO', compa::encodeutf('Az Acajoom PRO egy fejlett h�rlev�lk�ld� rendszer Joomla rendszerre.  ' . _ACA_FEATURES));

//since 1.1.4
define('_ACA_ENTER_TOKEN', compa::encodeutf('Adja meg az azonos�t�t!'));

define('_ACA_ENTER_TOKEN_TIPS', compa::encodeutf('Adja meg azt az azonos�t�t, amit emailben kapott meg az Acajoom megv�s�rl�sakor!<br />Ezut�n mentsen! Az Acajoom automatikusan kapcsol�dik a szerverhez egy licenszsz�m lek�r�s�hez.'));

define('_ACA_ACAJOOM_SITE', compa::encodeutf('Acajoom webhely:'));
define('_ACA_MY_SITE', compa::encodeutf('Webhelyem:'));

define( '_ACA_LICENSE_FORM', compa::encodeutf(' ' .	'Kattintson ide a licensz �rlaphoz ugr�shoz!</a>'));
define('_ACA_PLEASE_CLEAR_LICENSE', compa::encodeutf('T�r�lje a licensz mez�t �s pr�b�lja meg �jra!<br />Ha a probl�ma tov�bba is fenn�ll, '));

define( '_ACA_LICENSE_SUPPORT', compa::encodeutf('A m�g mindig van k�rd�se, ' . _ACA_PLEASE_LIC));

define( '_ACA_LICENSE_TWO', compa::encodeutf('a Licensz �rlapon lek�rheti a licenszet k�zi m�dszerrel is az azonos�t� �s a saj�t webhely URL megad�s�val (amelyik z�ld sz�nnek jelenik meg ennek az oldalnak a fels� r�sz�n). ' . _ACA_LICENSE_FORM . '<br /><br/>' . _ACA_LICENSE_SUPPORT));

define('_ACA_ENTER_TOKEN_PATIENCE', compa::encodeutf('Az azonos�t� ment�se ut�n automatikusan egy licensz k�d gener�l�dik. Az azonos�t� �ltal�ban 2 percen bel�l ellen�rz�sre ker�l, de bizonyos esetekben 15 percig is eltarthat..<br /><br />T�rjen vissza erre az ellen�rz�sre n�h�ny perc mulva!<br /><br />Ha nem kap �rv�nyes licensz k�dot 15 percen bel�l, '. _ACA_LICENSE_TWO));


define( '_ACA_ENTER_NOT_YET', compa::encodeutf('A megadott azonos�t� m�g nem lett ellen�rizve.'));
define( '_ACA_UPDATE_CLICK_HERE', compa::encodeutf('L�togasson el a <a href="http://www.ijoobi.com" target="_blank">www.ijoobi.com</a> oldalra a legfrissebb verzi� let�lt�s�hez.'));
define( '_ACA_NOTIF_UPDATE', compa::encodeutf('Ahhoz, hogy �rtes�lj�n az �j friss�t�sekr�l, adja meg az email c�m�t �s kattintson a Feliratkoz�s linkre!'));

define('_ACA_THINK_PLUS', compa::encodeutf('Ha t�bbet szeretne kihozni levelez� rendszer�b�l, gondoljon a Plus verzi�ra!'));
define('_ACA_THINK_PLUS_1', compa::encodeutf('Szekvenci�lis automatikus v�laszol�k'));
define('_ACA_THINK_PLUS_2', compa::encodeutf('H�rlev�l id�z�t�se egy el�re megadott id�pontra!'));
define('_ACA_THINK_PLUS_3', compa::encodeutf('Nincs t�bb� szerver korl�t'));
define('_ACA_THINK_PLUS_4', compa::encodeutf('�s sok m�s egy�b...'));

//since 1.2.2
define( '_ACA_LIST_ACCESS', compa::encodeutf('Lista hozz�f�r�s'));
define( '_ACA_INFO_LIST_ACCESS', compa::encodeutf('Adja meg, hogy milyen felhaszn�l�csoportok l�thatj�k �s iratkozhatnak fel erre a list�ra!'));
define( 'ACA_NO_LIST_PERM', compa::encodeutf('Nincs jogosults�ga feliratkozni erre a list�ra!'));

//Archive Configuration
 define('_ACA_MENU_TAB_ARCHIVE', compa::encodeutf('Arch�v�l'));
 define('_ACA_MENU_ARCHIVE_ALL', compa::encodeutf('Mindet arch�v�l'));

//Archive Lists
 define('_FREQ_OPT_0', compa::encodeutf('Nincs'));
 define('_FREQ_OPT_1', compa::encodeutf('Hetente'));
 define('_FREQ_OPT_2', compa::encodeutf('K�t hetente'));
 define('_FREQ_OPT_3', compa::encodeutf('Havonta'));
 define('_FREQ_OPT_4', compa::encodeutf('Negyed �vente'));
 define('_FREQ_OPT_5', compa::encodeutf('�vente'));
 define('_FREQ_OPT_6', compa::encodeutf('Egy�b'));

define('_DATE_OPT_1', compa::encodeutf('L�trehoz�s d�tum'));
define('_DATE_OPT_2', compa::encodeutf('M�dos�t�s d�tum'));

define('_ACA_ARCHIVE_TITLE', compa::encodeutf('Automatikus arch�v�l�s gyakoris�g�nak be�ll�t�sa'));
define('_ACA_FREQ_TITLE', compa::encodeutf('Arch�v�l�si gyakoris�g'));
define('_ACA_FREQ_TOOL', compa::encodeutf('Adja meg, hogy milyen gyakran arh�v�lja az Arch�vum kezel� a webhelye tartalm�t!.'));
define('_ACA_NB_DAYS', compa::encodeutf('Napok sz�ma'));
define('_ACA_NB_DAYS_TOOL', compa::encodeutf('Ez csak az Egy�b opci�ra vonatkozik! Adja meg a napok sz�m�t k�t arch�v�l�s k�z�tt!'));
define('_ACA_DATE_TITLE', compa::encodeutf('D�tum t�pus'));
define('_ACA_DATE_TOOL', compa::encodeutf('Adja meg, hogy a l�trehoz�s d�tuma vagy a m�dos�t�s d�tuma alapj�n arch�v�ljon!'));

define('_ACA_MAINTENANCE_TAB', compa::encodeutf('Karbantart�si be�ll�t�sok'));
define('_ACA_MAINTENANCE_FREQ', compa::encodeutf('Karbantart�si gyakoris�g'));
define( '_ACA_MAINTENANCE_FREQ_TIPS', compa::encodeutf('Adja meg azt a gyakoris�got, amikor a karbantart�si m�velet lefut!'));
define( '_ACA_CRON_DAYS', compa::encodeutf('�ra'));

define( '_ACA_LIST_NOT_AVAIL', compa::encodeutf('Jelenleg nincs el�rhet� lista.'));
define( '_ACA_LIST_ADD_TAB', compa::encodeutf('Hozz�ad/szerkeszt'));

define( '_ACA_LIST_ACCESS_EDIT', compa::encodeutf('Levelez�s hozz�f�r�s hozz�ad�s/szerkeszt�s'));
define( '_ACA_INFO_LIST_ACCESS_EDIT', compa::encodeutf('Adja meg azt a felhaszn�l�i csoportot, amely b�v�theti vagy szerkesztheti ehhez az list�hoz tartoz� levelez�seket!'));
define( '_ACA_MAILING_NEW_FRONT', compa::encodeutf('�j levelez�s l�trehoz�s'));

define('_ACA_AUTO_ARCHIVE', compa::encodeutf('Auto-Arch�v�l'));
define('_ACA_MENU_ARCHIVE', compa::encodeutf('Auto-Arch�v�l'));

//Extra tags:
define('_ACA_TAGS_ISSUE_NB', compa::encodeutf('[ISSUENB] = Lecser�l�dik a h�rlev�l kiad�s sz�m�ra.'));
define('_ACA_TAGS_DATE', compa::encodeutf('[DATE] = Lecser�l�dik a k�ld�s d�tum�ra.'));
define('_ACA_TAGS_CB', compa::encodeutf('[CBTAG:{field_name}] = Lecser�l�dik a Community Builder mez�j�nek �rt�k�re: pl.: [CBTAG:firstname] '));
define( '_ACA_MAINTENANCE', compa::encodeutf('Joobi Care'));

define('_ACA_THINK_PRO', compa::encodeutf('Professzion�lis ig�nyekhez professzion�lis komponensek!'));
define('_ACA_THINK_PRO_1', compa::encodeutf('Okos h�rlevelek'));
define('_ACA_THINK_PRO_2', compa::encodeutf('Adja meg a hozz�f�r�s szintj�t a list�hoz!'));
define('_ACA_THINK_PRO_3', compa::encodeutf('Adja meg, hogy ki szerkeszthet/adhat hozz� levelez�st!'));
define('_ACA_THINK_PRO_4', compa::encodeutf('Tov�bbi adatok: adja hozz� saj�t CB mez�it!'));
define('_ACA_THINK_PRO_5', compa::encodeutf('A Joomla tartalmaz Auto-archiv�l�st!'));
define('_ACA_THINK_PRO_6', compa::encodeutf('Adatb�zis optimaliz�l�s'));

define('_ACA_LIC_NOT_YET', compa::encodeutf('Az �n licensze m�g nem �rv�nyes. Ellen�rizze a Licensz f�let a konfigur�ci�s panelen!'));
define('_ACA_PLEASE_LIC_GREEN', compa::encodeutf('�gyeljen, hogy friss �s val�di inform�ci�kat adjon t�mogat� csoportunknak ennek a f�lnek a tetej�n!'));

define('_ACA_FOLLOW_LINK', compa::encodeutf('Licensz k�r�s'));
define( '_ACA_FOLLOW_LINK_TWO', compa::encodeutf('K�rheti licensz�t azonos�t�ja �s webhely�nek URL-je megad�s�val (amelyik z�ld sz�nnel jelenik meg az oldal tetej�n) a Licensz �rlapban.'));
define( '_ACA_ENTER_TOKEN_TIPS2', compa::encodeutf(' Majd kattintson az Alkalmaz gombon a jobb fels� men�ben!'));
define( '_ACA_ENTER_LIC_NB', compa::encodeutf('�rja be a licensz�t!'));
define( '_ACA_UPGRADE_LICENSE', compa::encodeutf('Licensz friss�t�se'));
define( '_ACA_UPGRADE_LICENSE_TIPS', compa::encodeutf('Ha kapott azonos�t�t a licensz friss�t�s�hez, azt itt adja meg, majd kattintson az Alkalmaz gombon �s folytassa a <b>2.</b> l�p�ssel licensz sz�m�nak lek�r�s�hez!'));

define( '_ACA_MAIL_FORMAT', compa::encodeutf('K�dol�si form�tum'));
define( '_ACA_MAIL_FORMAT_TIPS', compa::encodeutf('Milyen k�dol�si form�t szeretne haszn�lni levelez�seiben: csak sz�veges vagy MIME'));
define( '_ACA_ACAJOOM_CRON_DESC_ALT', compa::encodeutf('Ha nincs hozz�f�r�se a webhely�n id�z�t� kezel�h�z, haszn�lhatja az ingyenes jCron komponenst az id�z�t�si feladatok megold�s�ra!'));

//since 1.3.1
define('_ACA_SHOW_AUTHOR', compa::encodeutf('A szerz� nev�nek megjelen�t�se'));
define('_ACA_SHOW_AUTHOR_TIPS', compa::encodeutf('V�lasszon Igen-t, ha a szerz� nev�t is el szeretn� helyezni a lev�lbe elhelyezett cikkn�l!'));

//since 1.3.5
define('_ACA_REGWARN_NAME', compa::encodeutf('Adja meg a nev�t!'));
define('_ACA_REGWARN_MAIL', compa::encodeutf('�rv�nyes email c�met adjon meg!'));

//since 1.5.6
define('_ACA_ADDEMAILREDLINK_TIPS', compa::encodeutf('If you select Yes, the e-mail of the user will be added as a parameter at the end of your redirect URL (the redirect link for your module or for an external Acajoom form).<br/>That can be usefull if you want to execute a special script in your redirect page.'));
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
define('_ACA_MINISENDMAIL_TIPS', compa::encodeutf('If your server use Mini SendMail, select this option to don\'t add the name of the user in the header of the e-mail'));

//Since 3.1.5
define('_ACA_READMORE',compa::encodeutf('Read more...'));
define('_ACA_VIEWARCHIVE',compa::encodeutf('Click here'));

//Acajoom GPL
define('_ACA_DESC_GPL',_ACA_DESC_NEWS);