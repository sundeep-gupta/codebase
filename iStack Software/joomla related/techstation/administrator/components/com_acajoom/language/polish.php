<?php
defined('_JEXEC') OR defined('_VALID_MOS') OR die('...Direct Access to this location is not allowed...');

/**
* <p>Polish language file</p>
* @author Andrzej Herzberg <http://design-joomla.pl>
* @version $Id: polish.php 491 2007-02-01 22:56:07Z divivo $
* @link http://www.ijoobi.com
*/

### General ###
 //acajoom Description
define('_ACA_DESC_NEWS', compa::encodeutf('Acajoom to narz�dzie zaiweraj�ce list� mailingow�, newsletter, auto-responder s�u��ce do bardziej efektywnej komunikacji mi�dzy u�ytkownikiem i jego klientami.  ' .
		'Acajoom, Tw�j partner w komunikacji!'));
define('_ACA_FEATURES', compa::encodeutf('Acajoom, Tw�j partner w komunikacji!'));

// Type of lists
define('_ACA_NEWSLETTER', compa::encodeutf('Newsletter'));
define('_ACA_AUTORESP', compa::encodeutf('Auto-responder'));
define('_ACA_AUTORSS', compa::encodeutf('Auto-RSS'));
define('_ACA_ECARD', compa::encodeutf('e-Kartki'));
define('_ACA_POSTCARD', compa::encodeutf('Kartka pocztowa'));
define('_ACA_PERF', compa::encodeutf('Wyniki'));
define('_ACA_COUPON', compa::encodeutf('Kupon'));
define('_ACA_CRON', compa::encodeutf('Zadanie Crona'));
define('_ACA_MAILING', compa::encodeutf('Wysy�ka'));
define('_ACA_LIST', compa::encodeutf('Lista'));

 //acajoom Menu
define('_ACA_MENU_LIST', compa::encodeutf('Listy'));
define('_ACA_MENU_SUBSCRIBERS', compa::encodeutf('Subskrybenci'));
define('_ACA_MENU_NEWSLETTERS', compa::encodeutf('Newslettery'));
define('_ACA_MENU_AUTOS', compa::encodeutf('Autorespondery'));
define('_ACA_MENU_COUPONS', compa::encodeutf('Kupony'));
define('_ACA_MENU_CRONS', compa::encodeutf('Zadania krona'));
define('_ACA_MENU_AUTORSS', compa::encodeutf('Auto-RSS'));
define('_ACA_MENU_ECARD', compa::encodeutf('e-Kartki'));
define('_ACA_MENU_POSTCARDS', compa::encodeutf('Kartki pocztowe'));
define('_ACA_MENU_PERFS', compa::encodeutf('Wyniki'));
define('_ACA_MENU_TAB_LIST', compa::encodeutf('Listy'));
define('_ACA_MENU_MAILING_TITLE', compa::encodeutf('Wysy�ki'));
define('_ACA_MENU_MAILING', compa::encodeutf('Wysy�ki od '));
define('_ACA_MENU_STATS', compa::encodeutf('Statystyki'));
define('_ACA_MENU_STATS_FOR', compa::encodeutf('Statystyki dla '));
define('_ACA_MENU_CONF', compa::encodeutf('Konfiguracja'));
define('_ACA_MENU_UPDATE', compa::encodeutf('Import'));
define('_ACA_MENU_ABOUT', compa::encodeutf('O'));
define('_ACA_MENU_LEARN', compa::encodeutf('Centrum edukacji'));
define('_ACA_MENU_MEDIA', compa::encodeutf('Menad�er medi�w'));
define('_ACA_MENU_HELP', compa::encodeutf('Pomoc'));
define('_ACA_MENU_CPANEL', compa::encodeutf('Panel zarz�dzania'));
define('_ACA_MENU_IMPORT', compa::encodeutf('Import'));
define('_ACA_MENU_EXPORT', compa::encodeutf('Export'));
define('_ACA_MENU_SUB_ALL', compa::encodeutf('Subskrybuj wszystkie listy'));
define('_ACA_MENU_UNSUB_ALL', compa::encodeutf('Wypisz si� ze wszystkich list'));
define('_ACA_MENU_VIEW_ARCHIVE', compa::encodeutf('Archiwum'));
define('_ACA_MENU_PREVIEW', compa::encodeutf('Podgl�d'));
define('_ACA_MENU_SEND', compa::encodeutf('Wy�lij'));
define('_ACA_MENU_SEND_TEST', compa::encodeutf('Wy�lij email testowy'));
define('_ACA_MENU_SEND_QUEUE', compa::encodeutf('Kolejka procesu'));
define('_ACA_MENU_VIEW', compa::encodeutf('Widok'));
define('_ACA_MENU_COPY', compa::encodeutf('Kopia'));
define('_ACA_MENU_VIEW_STATS', compa::encodeutf('Widok statystyk'));
define('_ACA_MENU_CRTL_PANEL', compa::encodeutf(' Panel kontrolny'));
define('_ACA_MENU_LIST_NEW', compa::encodeutf(' Dodaj list�'));
define('_ACA_MENU_LIST_EDIT', compa::encodeutf(' Edytuj list�'));
define('_ACA_MENU_BACK', compa::encodeutf('Powr�t'));
define('_ACA_MENU_INSTALL', compa::encodeutf('Instalacja'));
define('_ACA_MENU_TAB_SUM', compa::encodeutf('Podsumowanie'));
define('_ACA_STATUS', compa::encodeutf('Status'));

// messages
define('_ACA_ERROR', compa::encodeutf(' Wyst�pi� b��d! '));
define('_ACA_SUB_ACCESS', compa::encodeutf('Prawa dost�pu'));
define('_ACA_DESC_CREDITS', compa::encodeutf('Przypisy'));
define('_ACA_DESC_INFO', compa::encodeutf('Informacje'));
define('_ACA_DESC_HOME', compa::encodeutf('Strona domowa'));
define('_ACA_DESC_MAILING', compa::encodeutf('Lista mailingowa'));
define('_ACA_DESC_SUBSCRIBERS', compa::encodeutf('Subskrybenci'));
define('_ACA_PUBLISHED', compa::encodeutf('Opublikowane'));
define('_ACA_UNPUBLISHED', compa::encodeutf('Nie opublikowane'));
define('_ACA_DELETE', compa::encodeutf('Skasuj'));
define('_ACA_FILTER', compa::encodeutf('Filtr'));
define('_ACA_UPDATE', compa::encodeutf('Aktualizacja'));
define('_ACA_SAVE', compa::encodeutf('Zapisz'));
define('_ACA_CANCEL', compa::encodeutf('Pomi�'));
define('_ACA_NAME', compa::encodeutf('Imi�'));
define('_ACA_EMAIL', compa::encodeutf('E-mail'));
define('_ACA_SELECT', compa::encodeutf('Wybierz'));
define('_ACA_ALL', compa::encodeutf('Wszystkie'));
define('_ACA_SEND_A', compa::encodeutf('Wy�lij '));
define('_ACA_SUCCESS_DELETED', compa::encodeutf(' skasowano'));
define('_ACA_LIST_ADDED', compa::encodeutf('Lista zosta�a utworzona'));
define('_ACA_LIST_COPY', compa::encodeutf('Lista zosta�a skopiowana'));
define('_ACA_LIST_UPDATED', compa::encodeutf('Lista zosta�a zaktualizowana'));
define('_ACA_MAILING_SAVED', compa::encodeutf('Mailing zapisano.'));
define('_ACA_UPDATED_SUCCESSFULLY', compa::encodeutf('zaktualizowano.'));

### Subscribers information ###
//subscribe and unsubscribe info
define('_ACA_SUB_INFO', compa::encodeutf('Informacja o subskrybentach'));
define('_ACA_VERIFY_INFO', compa::encodeutf('Prosz� sparawdzi� podany odno�nik, informacja mo�e by� niekompletna.'));
define('_ACA_INPUT_NAME', compa::encodeutf('Imi�'));
define('_ACA_INPUT_EMAIL', compa::encodeutf('Email'));
define('_ACA_RECEIVE_HTML', compa::encodeutf('Wiadomo�� HTML?'));
define('_ACA_TIME_ZONE', compa::encodeutf('Strefa czasowa'));
define('_ACA_BLACK_LIST', compa::encodeutf('Czarna lista'));
define('_ACA_REGISTRATION_DATE', compa::encodeutf('Data rejestracji u�ytkownika'));
define('_ACA_USER_ID', compa::encodeutf('Id u�ytkownika'));
define('_ACA_DESCRIPTION', compa::encodeutf('Opis'));
define('_ACA_ACCOUNT_CONFIRMED', compa::encodeutf('Twoje konto zosta�o aktywowane.'));
define('_ACA_SUB_SUBSCRIBER', compa::encodeutf('Subskrybent'));
define('_ACA_SUB_PUBLISHER', compa::encodeutf('Wydawca'));
define('_ACA_SUB_ADMIN', compa::encodeutf('Administrator'));
define('_ACA_REGISTERED', compa::encodeutf('Zarejestrowany'));
define('_ACA_SUBSCRIPTIONS', compa::encodeutf('Twoja subskrypcja'));
define('_ACA_SEND_UNSUBCRIBE', compa::encodeutf('Wy�lij wiadomo�� o rezygnacji z subskrypcji'));
define('_ACA_SEND_UNSUBCRIBE_TIPS', compa::encodeutf('Kliknij Tak aby wys�a� email z informacj� o rezygnacji z subskrypcji.'));
define('_ACA_SUBSCRIBE_SUBJECT_MESS', compa::encodeutf('Prosz� potwierdzi� swoj� subskrypcj�'));
define('_ACA_UNSUBSCRIBE_SUBJECT_MESS', compa::encodeutf('Potwierdzenie rezygnacji z subskrypcji'));
define('_ACA_DEFAULT_SUBSCRIBE_MESS', compa::encodeutf('Witaj [NAME],<br>' .
		'Zosta� jescze tylko jeden krok i zostaniesz dopisany do naszej listy wysy�kowej.  Prosz� klikn�� na poni�szy link aby potwierdzi� subskrupcj�.' .
		'<br><br>[CONFIRM]<br><br>W razie jakichkolwiek pyta� prosz� o kontakt z webmasterem.'));
define('_ACA_DEFAULT_UNSUBSCRIBE_MESS', compa::encodeutf('To jest e-mail potwierdazj�cy wypisanie si� z naszej listy wysy�kowej.  Bardzo nam przykro, �e si� wypisa�e�. Pami�taj jednak, �e zawsze mo�esz odnowi� subskrupcj�.  Je�li mmasz jakiekolwiek pytania, prosz� o kontakt.'));

// Acajoom subscribers
define('_ACA_SIGNUP_DATE', compa::encodeutf('Data zapisu'));
define('_ACA_CONFIRMED', compa::encodeutf('Zatwierdzony'));
define('_ACA_SUBSCRIB', compa::encodeutf('Subskrupcja'));
define('_ACA_HTML', compa::encodeutf('Mailing w formacie HTML'));
define('_ACA_RESULTS', compa::encodeutf('Wyniki'));
define('_ACA_SEL_LIST', compa::encodeutf('Wybierz list�'));
define('_ACA_SEL_LIST_TYPE', compa::encodeutf('- Wybierz rodzaj listy -'));
define('_ACA_SUSCRIB_LIST', compa::encodeutf('Lista wszystkich subskrybent�w'));
define('_ACA_SUSCRIB_LIST_UNIQUE', compa::encodeutf('Subskrybenci dla : '));
define('_ACA_NO_SUSCRIBERS', compa::encodeutf('Nie znaleziono subskrybent�w dla tej listy.'));
define('_ACA_COMFIRM_SUBSCRIPTION', compa::encodeutf('E-mail z pro�b� o potwierdzenie subskrypcji zosta� wys�any.  Prosz� odbierz korespondencj� i kliknij w link weryfikacyjny.<br>' .
		'Musisz potwierdzi� autentyczno�� swojej subskrypcji zanim dopiszemy ci� do listy naszych prenumeartor�w.'));
define('_ACA_SUCCESS_ADD_LIST', compa::encodeutf('Twoje dane zosta�y dopisane do naszej listy wysy�kowej.'));


 // Subcription info
define('_ACA_CONFIRM_LINK', compa::encodeutf('Klilkij tu aby potwierdzi� subskrypcj�'));
define('_ACA_UNSUBSCRIBE_LINK', compa::encodeutf('Kliknij tu aby wypisa� si� z naszej listy wysy�kowej'));
define('_ACA_UNSUBSCRIBE_MESS', compa::encodeutf('Tw�j adres e-mail zosta� usuni�ty z naszej listy wysy�kowej'));

define('_ACA_QUEUE_SENT_SUCCESS', compa::encodeutf('Wszystkie zaplanowane wysy�ki zosta�y pomy�lnie zrealizowane.'));
define('_ACA_MALING_VIEW', compa::encodeutf('Zobacz wszystkie wysy�ki'));
define('_ACA_UNSUBSCRIBE_MESSAGE', compa::encodeutf('Czy jeste� pewien, �e chcesz wypisa� si� z naszej listy wysy�kowej?'));
define('_ACA_MOD_SUBSCRIBE', compa::encodeutf('Subskrybuj'));
define('_ACA_SUBSCRIBE', compa::encodeutf('Subskrybuj'));
define('_ACA_UNSUBSCRIBE', compa::encodeutf('Wypisz si�'));
define('_ACA_VIEW_ARCHIVE', compa::encodeutf('Zobacz archiwum'));
define('_ACA_SUBSCRIPTION_OR', compa::encodeutf(' lub kliknij tu aby uaktualni� informacje'));
define('_ACA_EMAIL_ALREADY_REGISTERED', compa::encodeutf('Ten adres e-mail jest ju� zarejestrowany w naszej bazie.'));
define('_ACA_SUBSCRIBER_DELETED', compa::encodeutf('Subskrybent skasowany.'));


### UserPanel ###
 //User Menu
define('_UCP_USER_PANEL', compa::encodeutf('Panel kontrolny u�ytkownika'));
define('_UCP_USER_MENU', compa::encodeutf('Menu u�ytkownika'));
define('_UCP_USER_CONTACT', compa::encodeutf('Moje subskrypcje'));
 //Acajoom Cron Menu
define('_UCP_CRON_MENU', compa::encodeutf('Zarz�dzanie zadaniami crona'));
define('_UCP_CRON_NEW_MENU', compa::encodeutf('Nowy cron'));
define('_UCP_CRON_LIST_MENU', compa::encodeutf('Lista zada� crona'));
 //Acajoom Coupon Menu
define('_UCP_COUPON_MENU', compa::encodeutf('Zarz�dzanie kuponami'));
define('_UCP_COUPON_LIST_MENU', compa::encodeutf('Lista kupon�w'));
define('_UCP_COUPON_ADD_MENU', compa::encodeutf('Dodaj kupon'));

### lists ###
// Tabs
define('_ACA_LIST_T_GENERAL', compa::encodeutf('Opis'));
define('_ACA_LIST_T_LAYOUT', compa::encodeutf('Uk�ad'));
define('_ACA_LIST_T_SUBSCRIPTION', compa::encodeutf('Subskrypcja'));
define('_ACA_LIST_T_SENDER', compa::encodeutf('Informacja o nadawcy'));

define('_ACA_LIST_TYPE', compa::encodeutf('Typ listy'));
define('_ACA_LIST_NAME', compa::encodeutf('Nazwa listy'));
define('_ACA_LIST_ISSUE', compa::encodeutf('Emisja #'));
define('_ACA_LIST_DATE', compa::encodeutf('Data wysy�ki'));
define('_ACA_LIST_SUB', compa::encodeutf('Temat mailingu'));
define('_ACA_ATTACHED_FILES', compa::encodeutf('Za��czone pliki'));
define('_ACA_SELECT_LIST', compa::encodeutf('Prosz� wybra� list� do edycji!'));

// Auto Responder box
define('_ACA_AUTORESP_ON', compa::encodeutf('Typ listy'));
define('_ACA_AUTO_RESP_OPTION', compa::encodeutf('Opcje Autorespondera'));
define('_ACA_AUTO_RESP_FREQ', compa::encodeutf('Subskrybenci mog� wybra� cz�stotliwo��'));
define('_ACA_AUTO_DELAY', compa::encodeutf('Op�nienie (w dniach)'));
define('_ACA_AUTO_DAY_MIN', compa::encodeutf('Minimalna cz�stotliwo��'));
define('_ACA_AUTO_DAY_MAX', compa::encodeutf('Maksymalna cz�stotliwo��'));
define('_ACA_FOLLOW_UP', compa::encodeutf('Okre�l follow up autoresponder'));
define('_ACA_AUTO_RESP_TIME', compa::encodeutf('Subskrybenci mog� wybra� czas'));
define('_ACA_LIST_SENDER', compa::encodeutf('Lista wysy�kowa'));

define('_ACA_LIST_DESC', compa::encodeutf('Opis listy'));
define('_ACA_LAYOUT', compa::encodeutf('Uk�ad'));
define('_ACA_SENDER_NAME', compa::encodeutf('Nazwa nadawcy'));
define('_ACA_SENDER_EMAIL', compa::encodeutf('E-mail nadawcy'));
define('_ACA_SENDER_BOUNCE', compa::encodeutf('Nadawca odbitych wiadomo�ci'));
define('_ACA_LIST_DELAY', compa::encodeutf('Op�nienie'));
define('_ACA_HTML_MAILING', compa::encodeutf('Format HTML?'));
define('_ACA_HTML_MAILING_DESC', compa::encodeutf('(je�li dokonasz zmian powiniene� je zapisa� i powr�ci� do tego ekranu aby sprawdzi� efekt.)'));
define('_ACA_HIDE_FROM_FRONTEND', compa::encodeutf('Ukry� na stronie frontowej?'));
define('_ACA_SELECT_IMPORT_FILE', compa::encodeutf('Wybierz plik do zaimportowania'));;
define('_ACA_IMPORT_FINISHED', compa::encodeutf('Import zako�czony'));
define('_ACA_DELETION_OFFILE', compa::encodeutf('Usuni�cie pliku'));
define('_ACA_MANUALLY_DELETE', compa::encodeutf('nie powiod�o si�, musisz r�cznie usun�� plik'));
define('_ACA_CANNOT_WRITE_DIR', compa::encodeutf('Niemog� zapisa� katalogu'));
define('_ACA_NOT_PUBLISHED', compa::encodeutf('Nie mo�na wys�a� mailingu, lista jest nieopublikowana.'));

//  List info box
define('_ACA_INFO_LIST_PUB', compa::encodeutf('Kliknij Tak aby opublikowa� list�'));
define('_ACA_INFO_LIST_NAME', compa::encodeutf('Tutaj wpisz nazw� twojej listy. B�dziesz m�g� identyfikowa� list� u�ywaj�c tej nazwy.'));
define('_ACA_INFO_LIST_DESC', compa::encodeutf('Tutaj wpisz kr�tki opis twojej listy. Ten opis b�dzie widoczny dla odwiedzaj�cych tw�j serwis.'));
define('_ACA_INFO_LIST_SENDER_NAME', compa::encodeutf('Wpisz imi� wysy�aj�cego mailing. B�dzie ono widoczne dla subskrybent�w tej listy.'));
define('_ACA_INFO_LIST_SENDER_EMAIL', compa::encodeutf('Wpisz adres e-mail z kt�rego mailing jest wysy�any.'));
define('_ACA_INFO_LIST_SENDER_BOUNCED', compa::encodeutf('Wpisz adres email na kt�ry u�ytkownicy mog� odpowiada�. Zalecamy aby by� to tan sam adres co adres nadawcy. Niekt�re filtry antyspamowe mog� wiadmo�� w kt�rej adres nadawcy r�ni si� od adresu zwrotnego uzna� za spam'));
define('_ACA_INFO_LIST_AUTORESP', compa::encodeutf('Wybierz typ mailingu dla tej listy. <br>' .
		'Newsletter: Normalny newsletter<br>' .
		'Autoresponder: jest to specjalny rodzaj listyz kt�rej wiadomo�ci wysy�ane s� automatycznie w zadanych odst�pach czasu.'));
define('_ACA_INFO_LIST_FREQUENCY', compa::encodeutf('Zaznacz czy u�ytkownicy mog� wybra� jak cz�sto maj� otrzymywa� wiadomo�ci.  Pozwoli to na wi�ksz� elastyczno�� dla u�ytkownik�w.'));
define('_ACA_INFO_LIST_TIME', compa::encodeutf('Pozw�l u�ytkownikom wybra� preferowan� por� dnia, o kt�rej chc� otrzymywa� wiadomo�ci.'));
define('_ACA_INFO_LIST_MIN_DAY', compa::encodeutf('Zdefiniuj minimaln� cz�stotliwo�� z jak� u�ytkownicy maj� otrzymywa� wiadomo�ci'));
define('_ACA_INFO_LIST_DELAY', compa::encodeutf('Sprecyzuj odst�p pomi�dzy t� wiadomo�i� autorespondera a nast�pn�.'));
define('_ACA_INFO_LIST_DATE', compa::encodeutf('Sprecyzuj dat� publikacji listy je�li zamierzasz przerwac wysy�k�. <br> FORMAT : YYYY-MM-DD HH:MM:SS'));
define('_ACA_INFO_LIST_MAX_DAY', compa::encodeutf('Sprecyzuj jak� maksymaln� cz�stotliow�� otrzymywania wiadomo�ci u�ytkownicy mog� wybra�'));
define('_ACA_INFO_LIST_LAYOUT', compa::encodeutf('Tutaj wprowad� uk�ad twojej listy mailingowej. Mo�esz zdefiniowa� dowolny uk�ad.'));
define('_ACA_INFO_LIST_SUB_MESS', compa::encodeutf('Ta wiadomo�� zostanie wys�ana do subskrybenta, kt�ry w�a�nie si� zarejestrowa�. Mo�esz tutaj zdefiniowa� dowolny tekst.'));
define('_ACA_INFO_LIST_UNSUB_MESS', compa::encodeutf('Ta wiadomo�� zostanie wys�ana do subskrybenta kiedy wypisze si� z listy. Mo�e to by� dowolna wiadomo��.'));
define('_ACA_INFO_LIST_HTML', compa::encodeutf('Wybierz opcj� je�li chcesz wysy�a� wiadomo�ci w formacie HTML. U�ytkownicy s� zobowi�zani sprecyzowa� czy chc� otrzymywa� wiadomo�ci w formacie HTML, czy tylko wiadomo�ci tekstowe, w chili gdy zapisuj� si� do tej listy.'));
define('_ACA_INFO_LIST_HIDDEN', compa::encodeutf('Kliknij tak aby ukry� list� na stronie frontowej, u�ytkownicy nie b�d� zobowi�zani do zapisu ale wci�� b�dzie mo�liwa wysy�ka.'));
define('_ACA_INFO_LIST_ACA_AUTO_SUB', compa::encodeutf('Czy chcesz automatycznie zapisa� nowych u�ytkownik�w do tej listy?<br><B>Nowi u�ytkownicy:</B> zostan� zarejestrowani wszyscy nowi u�ytkownicy.<br><B>Wszyscy u�ytkowicy:</B> zostan� zarejestrowani wszyscy u�ytkownicy zapisani do tej pory w bazie.<br>(wszystkie opcje wspierane s� w Community Builder)'));
define('_ACA_INFO_LIST_ACC_LEVEL', compa::encodeutf('Wybierz poziom dost�pu ze strony frontowej. Ta opcja pokazuje lub ukrywa list� mailingow� dla grup u�ytkownik�w kt�rzy nie chc� lub nie powinni si� do niej zapisywa�.'));
define('_ACA_INFO_LIST_ACC_USER_ID', compa::encodeutf('Wybierz poziom dost�pu dla u�ytkownik�w, kt�rym chcesz pozwoli� a edycj�. Ci u�ytkownicy b�d� w stanie edytowa� i wysy�ac mailing z pozomu frontu oraz z panela administracynjego.'));
define('_ACA_INFO_LIST_FOLLOW_UP', compa::encodeutf('If you want the auto-responder to move to another one once it reaches the last message you can specify here the following up auto-responder.'));
define('_ACA_INFO_LIST_ACA_OWNER', compa::encodeutf('To jest ID osoby, kt�ra utowrzy�a list�.'));
define('_ACA_INFO_LIST_WARNING', compa::encodeutf('   Ta ostatnia opcja jest dost�pna tylko raz, podczas tworzenia listy.'));
define('_ACA_INFO_LIST_SUBJET', compa::encodeutf(' Temat wysy�ki.  To jest temat e-maila, kt�ry otrzyma subskrybent.'));
define('_ACA_INFO_MAILING_CONTENT', compa::encodeutf('To jest zawarto�� e-maila do wysy�ki.'));
define('_ACA_INFO_MAILING_NOHTML', compa::encodeutf('Wpisz tytaj tre�� wiadomo�ci, kt�r� chcesz wys�a� do tych subskrybent�w, kt�rzy wyrazili woj� otrzymywania wiadomo�ci w formacie tekstowym podczas zapisu. <BR/> UWAGA: Je�li zostawisz to pole puste Acajoom automatycznie przekonweruje wiadomo�� HTML do wiadomo�ci tekstowej.'));
define('_ACA_INFO_MAILING_VISIBLE', compa::encodeutf('Kliknij TAK aby pokaza� mailing na strnonie.'));
define('_ACA_INSERT_CONTENT', compa::encodeutf('Za��cz istniej�cy artyku�'));

// Coupons
define('_ACA_SEND_COUPON_SUCCESS', compa::encodeutf('Kupon wys�any!'));
define('_ACA_CHOOSE_COUPON', compa::encodeutf('Wybierz kupon'));
define('_ACA_TO_USER', compa::encodeutf(' do tego u�ytkownika'));

### Cron options
//drop down frequency(CRON)
define('_ACA_FREQ_CH1', compa::encodeutf('co godzin�'));
define('_ACA_FREQ_CH2', compa::encodeutf('co 6 godzin'));
define('_ACA_FREQ_CH3', compa::encodeutf('co 12 godzin'));
define('_ACA_FREQ_CH4', compa::encodeutf('codiennie'));
define('_ACA_FREQ_CH5', compa::encodeutf('co tydzie�'));
define('_ACA_FREQ_CH6', compa::encodeutf('co miesi�c'));
define('_ACA_FREQ_NONE', compa::encodeutf('Nie'));
define('_ACA_FREQ_NEW', compa::encodeutf('Nowy u�ytkownik'));
define('_ACA_FREQ_ALL', compa::encodeutf('Wszystcy u�ytkownicy'));

//Label CRON form
define('_ACA_LABEL_FREQ', compa::encodeutf('Acajoom Cron?'));
define('_ACA_LABEL_FREQ_TIPS', compa::encodeutf('Kliknij TAK je�li zamierzasz u�y� z Acajoom Cron, NIE dla innych zada� crona.<br>' .
		'Je�li wybierzesz TAK nie musisz wybiera� adresu Cron-a, b�dzie on automatycznie dodany.'));
define('_ACA_SITE_URL', compa::encodeutf('Adres URL twojej witryny'));
define('_ACA_CRON_FREQUENCY', compa::encodeutf('Cz�stotliwo�� Cron-a'));
define('_ACA_STARTDATE_FREQ', compa::encodeutf('Data pocz�tkowa'));
define('_ACA_LABELDATE_FREQ', compa::encodeutf('Okre�l dat�'));
define('_ACA_LABELTIME_FREQ', compa::encodeutf('Okre�l czas'));
define('_ACA_CRON_URL', compa::encodeutf('Cron URL'));
define('_ACA_CRON_FREQ', compa::encodeutf('Cz�stotliwo��'));
define('_ACA_TITLE_CRONLIST', compa::encodeutf('Lista Cron-�w'));
define('_NEW_LIST', compa::encodeutf('Utw�rz nowa list�'));

//title CRON form
define('_ACA_TITLE_FREQ', compa::encodeutf('Edycja Cron-a'));
define('_ACA_CRON_SITE_URL', compa::encodeutf('Prosz� wpisa� poprawny adres url witryny zaczynaj�cy si� od http://'));

### Mailings ###
define('_ACA_MAILING_ALL', compa::encodeutf('Wszystkie mailingi'));
define('_ACA_EDIT_A', compa::encodeutf('Edytuj '));
define('_ACA_SELCT_MAILING', compa::encodeutf('Prosz� wybra� list� z rozwijalnego menu.'));
define('_ACA_VISIBLE_FRONT', compa::encodeutf('Widoczne na stronie'));

// mailer
define('_ACA_SUBJECT', compa::encodeutf('Temat'));
define('_ACA_CONTENT', compa::encodeutf('Zawarto��'));
define('_ACA_NAMEREP', compa::encodeutf('[NAME] = To pole zostanie zamienione na dane wprowadzone przez u�ytkownika, mo�esz wi�c wysy�a� spersonalizowane wiadomo�ci.<br>'));
define('_ACA_FIRST_NAME_REP', compa::encodeutf('[FIRSTNAME] = To pole zostanie zamienione na imi�, kt�re wprowadzi� u�ytkownik przy rejestracji.<br>'));
define('_ACA_NONHTML', compa::encodeutf('wersja bez HTML'));
define('_ACA_ATTACHMENTS', compa::encodeutf('Za��czniki'));
define('_ACA_SELECT_MULTIPLE', compa::encodeutf('Wci�nik klawisz control (albo command - Macintosh) aby wybra� kilka za��cznik�w.<br>' .
		'Pliki b�da widoczne na li�cie za��cznik�w zlokalizowanych w katalogu z za��cznikami. Mo�esz zmieni� lokalizacj� tego katalogu w panelu kontrolnym.'));
define('_ACA_CONTENT_ITEM', compa::encodeutf('Element zawarto�ci'));
define('_ACA_SENDING_EMAIL', compa::encodeutf('Wysy�ka maili'));
define('_ACA_MESSAGE_NOT', compa::encodeutf('Komunikat - nie mo�e zosta� wys�ane'));
define('_ACA_MAILER_ERROR', compa::encodeutf('B��d mailera'));
define('_ACA_MESSAGE_SENT_SUCCESSFULLY', compa::encodeutf('Komunikat - wys�ano pomy�lnie'));
define('_ACA_SENDING_TOOK', compa::encodeutf('Wys�anie maili zabra�o '));
define('_ACA_SECONDS', compa::encodeutf(' sekund'));
define('_ACA_NO_ADDRESS_ENTERED', compa::encodeutf('Nie podano adresu e-mail lub u�ytkownika '));
define('_ACA_CHANGE_SUBSCRIPTIONS', compa::encodeutf('Zmie�'));
define('_ACA_CHANGE_EMAIL_SUBSCRIPTION', compa::encodeutf('Zmie� swoj� subskrypcj�'));
define('_ACA_WHICH_EMAIL_TEST', compa::encodeutf('Podaj edres e-mail do wys�ania wiadomo�ci testowej lub wybierz podgl�d'));
define('_ACA_SEND_IN_HTML', compa::encodeutf('Wysy�ka w HTML (dla mailingu html)?'));
define('_ACA_VISIBLE', compa::encodeutf('Widoczny'));
define('_ACA_INTRO_ONLY', compa::encodeutf('Tylko intro'));

// stats
define('_ACA_GLOBALSTATS', compa::encodeutf('Statystyki globalne'));
define('_ACA_DETAILED_STATS', compa::encodeutf('Statystyki szczeg��we'));
define('_ACA_MAILING_LIST_DETAILS', compa::encodeutf('Szczeg�y listy'));
define('_ACA_SEND_IN_HTML_FORMAT', compa::encodeutf('Wys�ane w formacie HTML'));
define('_ACA_VIEWS_FROM_HTML', compa::encodeutf('Obejrzane (e-maile HTML)'));
define('_ACA_SEND_IN_TEXT_FORMAT', compa::encodeutf('Wys�ane w formacie tekstowym'));
define('_ACA_HTML_READ', compa::encodeutf('HTML przeczytane'));
define('_ACA_HTML_UNREAD', compa::encodeutf('HTML nieprzeczytane'));
define('_ACA_TEXT_ONLY_SENT', compa::encodeutf('Tylko tekst'));

// Configuration panel
// main tabs
define('_ACA_MAIL_CONFIG', compa::encodeutf('Mail'));
define('_ACA_LOGGING_CONFIG', compa::encodeutf('Logi i statystyki'));
define('_ACA_SUBSCRIBER_CONFIG', compa::encodeutf('Subskrybenci'));
define('_ACA_MISC_CONFIG', compa::encodeutf('R�no�ci'));
define('_ACA_MAIL_SETTINGS', compa::encodeutf('Mail - ustawienia'));
define('_ACA_MAILINGS_SETTINGS', compa::encodeutf('Ustawienia mailingu'));
define('_ACA_SUBCRIBERS_SETTINGS', compa::encodeutf('Ustawienia subskrybent�w'));
define('_ACA_CRON_SETTINGS', compa::encodeutf('Ustawienia Cron-a'));
define('_ACA_SENDING_SETTINGS', compa::encodeutf('Ustawienia wysy�ki'));
define('_ACA_STATS_SETTINGS', compa::encodeutf('Ustawienia statystyk'));
define('_ACA_LOGS_SETTINGS', compa::encodeutf('Ustawienia log�w'));
define('_ACA_MISC_SETTINGS', compa::encodeutf('Ustawienia r�no�ci'));
// mail settings
define('_ACA_SEND_MAIL_FROM', compa::encodeutf('Bounce Back Address<br/>(used as Bounced back for all your messages)'));
define('_ACA_SEND_MAIL_NAME', compa::encodeutf('Nazwa nadawcy'));
define('_ACA_MAILSENDMETHOD', compa::encodeutf('Metoda wysy�ki'));
define('_ACA_SENDMAILPATH', compa::encodeutf('�cie�ka do sendmail'));
define('_ACA_SMTPHOST', compa::encodeutf('SMTP host'));
define('_ACA_SMTPAUTHREQUIRED', compa::encodeutf('SMTP wymagana autoryzacja'));
define('_ACA_SMTPAUTHREQUIRED_TIPS', compa::encodeutf('Wybierz je�li tw�j serwer SMTP wymaga autoryzacji'));
define('_ACA_SMTPUSERNAME', compa::encodeutf('SMTP nazwa u�ytkownika'));
define('_ACA_SMTPUSERNAME_TIPS', compa::encodeutf('Wprowad� nazw� u�ytkownika SMTP je�li tw�j serwer SMTP wymaga autoryzacji'));
define('_ACA_SMTPPASSWORD', compa::encodeutf('SMTP has�o'));
define('_ACA_SMTPPASSWORD_TIPS', compa::encodeutf('Wprowad� has�o SMTP je�li tw�j serwer SMTP wymaga autoryzacji'));
define('_ACA_USE_EMBEDDED', compa::encodeutf('U�yj za��czonych obraz�w'));
define('_ACA_USE_EMBEDDED_TIPS', compa::encodeutf('Wybierz je�li obrazki z za��czonej zawarto�ci maj� byc wys�ane w wiadomo�ci HTML. W innym przypadku zostan� u�yte standardowe tagi.'));
define('_ACA_UPLOAD_PATH', compa::encodeutf('Wgrywanie/�cie�ka do za��cznik�w'));
define('_ACA_UPLOAD_PATH_TIPS', compa::encodeutf('Mo�esz wybra� �cie�k� do za��cznik�w.<br>' .
		'Sprawd� czy wybrany katalog istnieje, w przeciwnym wypadku utw�rz go.'));

// subscribers settings
define('_ACA_ALLOW_UNREG', compa::encodeutf('Zezwalaj niezarejestrowanym'));
define('_ACA_ALLOW_UNREG_TIPS', compa::encodeutf('Wybierz TAK je�li chcesz pozwoli� na zapis do subskypcji u�ytkownikom niezarejestrowanym w serwisie.'));
define('_ACA_REQ_CONFIRM', compa::encodeutf('Wymagane potwierdzenie'));
define('_ACA_REQ_CONFIRM_TIPS', compa::encodeutf('Wybierz je�li wymagasz potwierdzenia subskrypcji od niezarejestrowanych u�ytkownik�w.'));
define('_ACA_SUB_SETTINGS', compa::encodeutf('Ustawienia subskrybenta'));
define('_ACA_SUBMESSAGE', compa::encodeutf('Ustawienia email'));
define('_ACA_SUBSCRIBE_LIST', compa::encodeutf('Subskrybenci do listy'));

define('_ACA_USABLE_TAGS', compa::encodeutf('U�yteczne zak�adki'));
define('_ACA_NAME_AND_CONFIRM', compa::encodeutf('<b>[CONFIRM]</b> = Zostanie utworzony odno�nik, za pomoc� kt�rego u�ytkownik b�dzie m�g� potwierdzi� subskrypcj�. Pole <strong>wymagane</strong> dla prawid�owej pracy Acajoom.<br>'
.'<br>[NAME] = To pole zostanie zast�pione nazw� (imi� i nazwisko), kt�r� u�ytkownik poda� przy rejestracji. Mo�esz wi�c wysy�a� spersonalizowane wiadomo�ci.<br>'
.'<br>[FIRSTNAME] = To pole zostanie zast�pione nazw� (imieniem), kt�r� u�ytkownik poda� przy rejestracji. FIRSTNAME to pierwsze s�owo wpisane przez u�ytkownika w polu z nazw�.<br>'));
define('_ACA_CONFIRMFROMNAME', compa::encodeutf('Potwierd� nazw�'));
define('_ACA_CONFIRMFROMNAME_TIPS', compa::encodeutf('Wpisz nazw� wy�wietlan� w wiadomo�ci z potwierdzeniem.'));
define('_ACA_CONFIRMFROMEMAIL', compa::encodeutf('Potwierd� e-mail'));
define('_ACA_CONFIRMFROMEMAIL_TIPS', compa::encodeutf('Wpisz email wy�wietlany w wiadomo�ci z potwierdzeniem.'));
define('_ACA_CONFIRMBOUNCE', compa::encodeutf('Adres dla odbitych wiadomo�ci'));
define('_ACA_CONFIRMBOUNCE_TIPS', compa::encodeutf('Wpisz adres e-mail dla odbitych wiadomo�ci.'));
define('_ACA_HTML_CONFIRM', compa::encodeutf('potwierdzenie HTML'));
define('_ACA_HTML_CONFIRM_TIPS', compa::encodeutf('Wybierz tak je�li wiadomo�� potwierdzaj�ca ma by� wys�ana w formacie HTML dla u�ytkownik�w, kt�rzy wybrali tak� opcj� przy rejestracji.'));
define('_ACA_TIME_ZONE_ASK', compa::encodeutf('Sprawd� stref� czasow�'));
define('_ACA_TIME_ZONE_TIPS', compa::encodeutf('Wybierz tak, je�li chcesz sprawdza� stref� czasow� u�ytkownika. Skojekowane maile b�d� wysy�ane w�a�ciwie dla danej strefy'));

 // Cron Set up
 define('_ACA_AUTO_CONFIG', compa::encodeutf('Cron'));
define('_ACA_TIME_OFFSET_URL', compa::encodeutf('kliknij tu aby ustawi� offset w g�wnym panelu konfiguracyjnym -> Zak�adka lokalna'));
define('_ACA_TIME_OFFSET_TIPS', compa::encodeutf('Ustaw odst�p czasu serwera'));
define('_ACA_TIME_OFFSET', compa::encodeutf('Odst�p czasu'));
define('_ACA_CRON_DESC', compa::encodeutf('<br>U�ywaj�c funkcji cron-a mo�esz ustawi� automatyczne zadania dla twojego serwisu w Joomla!<br>' .
		'Aby u�y� tej funkcjonalno�ci powiniene� ustawi� w panelu administracyjnym nast�puj�ce komendy:<br>' .
		'/usr/bin/php  /home/joomla/public_dev/index2.php?option=com_acajoom&act=cron' .
		'<br><br>Uwaga:<br>' .
		' - je�li scie�ka na Twoim serwerze jest inna ni� /usr/bin/php prosz� wpisa� w�a�ciw� w postaci /$php_path/php' .
 		'<br><br>Wi�cej informacji na temat ustawie� crona<br>' .
		' - Cpanel kliknij tu ' .
 		'<a href="http://www.visn.co.uk/cpanel-docs/cron-jobs.html"  target="_blank">http://www.visn.co.uk/cpanel-docs/cron-jobs.html</a><br>' .
 		' - Plesk kliknij tu ' .
 		'<a href="http://www.swsoft.com/doc/tutorials/Plesk/Plesk7/plesk_plesk7_eu/plesk7_eu_crontab.htm" target="_blank">' .
 		'http://www.swsoft.com/doc/tutorials/Plesk/Plesk7/plesk_plesk7_eu/plesk7_eu_crontab.htm</a><br>' .
 		' - Interworx kliknij tu ' .
 		'<a href="http://www.sagonet.com/interworx/tutorials/siteworx/cron.php" target="_blank">' .
 		'http://www.sagonet.com/interworx/tutorials/siteworx/cron.php</a><br>' .
 		' - Og�lne informacje na temat crona pod Linuxem ' .
 		'<a href="http://www.computerhope.com/unix/ucrontab.htm#01" target="_blank">http://www.computerhope.com/unix/ucrontab.htm#01</a><br>' .
 		'<br>Je�li potrzebujesz pomocy w ustawieniach crona lub masz inne problemy zapraszamy na nasze forum <a href="http://www.ijoobi.com" target="_blank">http://www.ijoobi.com</a>'));
// sending settings
define('_ACA_PAUSEX', compa::encodeutf('Przerwa x mi�dzy ka�d� ustawion� paczk� e-maili'));
define('_ACA_PAUSEX_TIPS', compa::encodeutf('Wprowad� ilo�� sekund, r�wnowa�n� przerwie pomi�dzy wysy�akmi kolejnyhc zdefiniowanych paczek maili.'));
define('_ACA_EMAIL_BET_PAUSE', compa::encodeutf('E-maili pomi�dzy przerwami'));
define('_ACA_EMAIL_BET_PAUSE_TIPS', compa::encodeutf('Ilo�� e-maili do wys�ania przed przerw�.'));
define('_ACA_WAIT_USER_PAUSE', compa::encodeutf('Czekaj na wprowadzenie u�ytkownika przy przerwie'));
define('_ACA_WAIT_USER_PAUSE_TIPS', compa::encodeutf('CZy skrypt ma czeka� na wprowadzenie u�ytkownika w czasie przerwy pomi�dzy wysy�kami.'));
define('_ACA_SCRIPT_TIMEOUT', compa::encodeutf('Czas oblicze� dla skryptu'));
define('_ACA_SCRIPT_TIMEOUT_TIPS', compa::encodeutf('Liczba minut dzia�ania skryptu (0 = bez limitu).'));
// Stats settings
define('_ACA_ENABLE_READ_STATS', compa::encodeutf('W��czone czytanie statystyk'));
define('_ACA_ENABLE_READ_STATS_TIPS', compa::encodeutf('Wybierz tak je�li chcesz rejestrowa� ilo�� wy�wietle�. Ta techika mo�e by� u�yta tylko dla mailingu w formacie HTML'));
define('_ACA_LOG_VIEWSPERSUB', compa::encodeutf('Rejestruj wy�wietlenia dla subskrybenta'));
define('_ACA_LOG_VIEWSPERSUB_TIPS', compa::encodeutf('Wybierz tak je�li chcesz rejestrowa� ilo�� wy�wietle� dla ka�dego u�ytkownika. Ta techika mo�e by� u�yta tylko dla mailingu w formacie HTML'));
// Logs settings
define('_ACA_DETAILED', compa::encodeutf('Szczeg�owe raporty'));
define('_ACA_SIMPLE', compa::encodeutf('Uproszczone raporty'));
define('_ACA_DIAPLAY_LOG', compa::encodeutf('Wy�wietl raporty'));
define('_ACA_DISPLAY_LOG_TIPS', compa::encodeutf('Zaznacz tak je�li chcesz wy�wietla� rejestry w czasie wysy�ki.'));
define('_ACA_SEND_PERF_DATA', compa::encodeutf('Wydajno�� wysy�ki'));
define('_ACA_SEND_PERF_DATA_TIPS', compa::encodeutf('Zaznacz je�li chcesz aby Ajacom generowa� anonimowe sprawozdania o konfiguracji, ilo�ci subskrybent�w listy i rzeczywistego czasu wysy�ki. To pozwoli nam oceni� wydajno�� systemu Acajoom i pozwoli na dokonanie poprawek w przysz�ych wersjach.'));
define('_ACA_SEND_AUTO_LOG', compa::encodeutf('Wy�lij raporty dla auto-respondera'));
define('_ACA_SEND_AUTO_LOG_TIPS', compa::encodeutf('Zaznacz tak jes�i chcesz otrzymywa� e-mail z raportem za ka�dym razem kiedy zadanie zostanie wykonane.  UWAGA: mo�e to spowodowa� ogromny wzrost ilo�ci otrzymywanych maili.'));
define('_ACA_SEND_LOG', compa::encodeutf('Wy�lij raport'));
define('_ACA_SEND_LOG_TIPS', compa::encodeutf('Czy raport z mailingu ma by� wysy�any na adres u�ytkownika zlecaj�cego wysy�k�.'));
define('_ACA_SEND_LOGDETAIL', compa::encodeutf('Wy�lij sczeg�owy raport'));
define('_ACA_SEND_LOGDETAIL_TIPS', compa::encodeutf('Szczeg�owy raport zawiera informacje o powodzeniu lub niepowodzeniu wysy�ki dla ka�dego subskrybenta oraz przegl�d informacji. Kr�tki raport zawiera wy��cznie przegl�d.'));
define('_ACA_SEND_LOGCLOSED', compa::encodeutf('Wy�lij raport je�li ��czno�� zostanie zerwana'));
define('_ACA_SEND_LOGCLOSED_TIPS', compa::encodeutf('Przy w��czonej opcji u�ytkownik wysy�aj�cy mailing wci�� mo�e otrzymywac raporty na e-mail.'));
define('_ACA_SAVE_LOG', compa::encodeutf('Zapisz raport'));
define('_ACA_SAVE_LOG_TIPS', compa::encodeutf('Czy raport z mailingu ma by� zapisany (za��czony) do pliku.'));
define('_ACA_SAVE_LOGDETAIL', compa::encodeutf('Zapisz szczeg�lowy raport'));
define('_ACA_SAVE_LOGDETAIL_TIPS', compa::encodeutf('Szczeg�owy raport zawiera informacje o powodzeniu lub niepowodzeniu wysy�ki dla ka�dego subskrybenta oraz przegl�d informacji. Kr�tki raport zawiera wy��cznie przegl�d.'));
define('_ACA_SAVE_LOGFILE', compa::encodeutf('Zapisz plik raportu'));
define('_ACA_SAVE_LOGFILE_TIPS', compa::encodeutf('Plik do kt�rego jest do��czany raport. Plik mo�e by� do�� spory.'));
define('_ACA_CLEAR_LOG', compa::encodeutf('Wyczy�� raport'));
define('_ACA_CLEAR_LOG_TIPS', compa::encodeutf('Kasuje dane z pliku raportu.'));

### control panel
define('_ACA_CP_LAST_QUEUE', compa::encodeutf('Ostatnio wykonana kolejka'));
define('_ACA_CP_TOTAL', compa::encodeutf('Suma'));
define('_ACA_MAILING_COPY', compa::encodeutf('Mailing skopiowany!'));

// Miscellaneous settings
define('_ACA_SHOW_GUIDE', compa::encodeutf('Poka� przewodnik'));
define('_ACA_SHOW_GUIDE_TIPS', compa::encodeutf('Pokazuje przewodnik pomagaj�cy nowym u�ytkownikom utworzy� newsletter, auto-responder i ustawi� poprawnie system Acajoom.'));
define('_ACA_AUTOS_ON', compa::encodeutf('U�yj Auto-responder�w'));
define('_ACA_AUTOS_ON_TIPS', compa::encodeutf('Ustaw nie je�li nie chcesz u�ywa�  Auto-responder�w. Wszystkie autorespndery b�d� nieaktywne.'));
define('_ACA_NEWS_ON', compa::encodeutf('U�yj newslettera'));
define('_ACA_NEWS_ON_TIPS', compa::encodeutf('Wybierz nie jes�i nie chcesz u�ywa� newslettera. Wszystkie newslettery b�d� nieaktywne.'));
define('_ACA_SHOW_TIPS', compa::encodeutf('Poka� porady'));
define('_ACA_SHOW_TIPS_TIPS', compa::encodeutf('Poka� porady pomagaj�ce u�ytkownikom korzysta� z systemu Acajoom bardziej efektywnie.'));
define('_ACA_SHOW_FOOTER', compa::encodeutf('Poka� stopk�'));
define('_ACA_SHOW_FOOTER_TIPS', compa::encodeutf('Czy ma by� pokazywana stopka Acajoom.'));
define('_ACA_SHOW_LISTS', compa::encodeutf('Poka� list� na stronie'));
define('_ACA_SHOW_LISTS_TIPS', compa::encodeutf('Pokazuje niezerejestrowanym u�ytkownikom listy mailingowe, kt�re b�d� mogli zaprenumerowa� po zarejestrowaniu.'));
define('_ACA_CONFIG_UPDATED', compa::encodeutf('Szczczeg�y konfiguracji zosta�y zapisane!'));
define('_ACA_UPDATE_URL', compa::encodeutf('Uaktualnij URL'));
define('_ACA_UPDATE_URL_WARNING', compa::encodeutf('UWAGA! Nie zmieniaj tego adresu p�ki nie zostaniesz o to poproszony przez zesp� techniczny Acajoom.<br>'));
define('_ACA_UPDATE_URL_TIPS', compa::encodeutf('Na przyk�ad: http://www.ijoobi.com/update/ (razem z ko�cowym slash-em)'));

// module
define('_ACA_EMAIL_INVALID', compa::encodeutf('Wprowadzony e-mail jest b��dny.'));
define('_ACA_REGISTER_REQUIRED', compa::encodeutf('Prosz� zarejestrowa� si� w serwisie przed zapiseaniem si� na list� wysy�kow�.'));

// Access level box
define('_ACA_OWNER', compa::encodeutf('Tw�rca listy:'));
define('_ACA_ACCESS_LEVEL', compa::encodeutf('Ustaw poziom dost�pu do listy'));
define('_ACA_ACCESS_LEVEL_OPTION', compa::encodeutf('Opcje poziomu dost�pu'));
define('_ACA_USER_LEVEL_EDIT', compa::encodeutf('Wybierz, kt�ry poziom u�ytkownika jest dopuszczony do redagowania listy (zar�wno z poziomu panela jak i frontu strony) '));

//  drop down options
define('_ACA_AUTO_DAY_CH1', compa::encodeutf('Codziennie'));
define('_ACA_AUTO_DAY_CH2', compa::encodeutf('Codziennie bez weekend�w'));
define('_ACA_AUTO_DAY_CH3', compa::encodeutf('Co dwa dni'));
define('_ACA_AUTO_DAY_CH4', compa::encodeutf('Co dwa dni bez weekend�w'));
define('_ACA_AUTO_DAY_CH5', compa::encodeutf('Tygodniowo'));
define('_ACA_AUTO_DAY_CH6', compa::encodeutf('Co dwa tygodnie'));
define('_ACA_AUTO_DAY_CH7', compa::encodeutf('Miesi�cznie'));
define('_ACA_AUTO_DAY_CH9', compa::encodeutf('Rocznie'));
define('_ACA_AUTO_OPTION_NONE', compa::encodeutf('Nie'));
define('_ACA_AUTO_OPTION_NEW', compa::encodeutf('Nowy u�ytkownik'));
define('_ACA_AUTO_OPTION_ALL', compa::encodeutf('Wszyscy u�ytkownicy'));

//
define('_ACA_UNSUB_MESSAGE', compa::encodeutf('Email z resygnacj�'));
define('_ACA_UNSUB_SETTINGS', compa::encodeutf('Ustawienia rezygnacji'));
define('_ACA_AUTO_ADD_NEW_USERS', compa::encodeutf('Auto zapis?'));

// Update and upgrade messages
define('_ACA_NO_UPDATES', compa::encodeutf('Obecnie nie jest dost�pna �adna aktualizacja.'));
define('_ACA_VERSION', compa::encodeutf('Wersja Acajoom'));
define('_ACA_NEED_UPDATED', compa::encodeutf('Pliki, kt�re powinny zosta� uaktualnione:'));
define('_ACA_NEED_ADDED', compa::encodeutf('Pliki, kt�re powinny zosta� dodane:'));
define('_ACA_NEED_REMOVED', compa::encodeutf('Pliki konieczne do usuni�cia:'));
define('_ACA_FILENAME', compa::encodeutf('Nazwa pliku:'));
define('_ACA_CURRENT_VERSION', compa::encodeutf('Aktualna wersja:'));
define('_ACA_NEWEST_VERSION', compa::encodeutf('Nowsza wersja:'));
define('_ACA_UPDATING', compa::encodeutf('Uaktualnienie'));
define('_ACA_UPDATE_UPDATED_SUCCESSFULLY', compa::encodeutf('Pliki zosta�y pomy�lnie zaktualizowane.'));
define('_ACA_UPDATE_FAILED', compa::encodeutf('Aktualizacja nieudana!'));
define('_ACA_ADDING', compa::encodeutf('Dodawanie'));
define('_ACA_ADDED_SUCCESSFULLY', compa::encodeutf('Pomy�lnie dodano.'));
define('_ACA_ADDING_FAILED', compa::encodeutf('Dodanie nie udane!'));
define('_ACA_REMOVING', compa::encodeutf('Usuwanie'));
define('_ACA_REMOVED_SUCCESSFULLY', compa::encodeutf('Usuni�to pomy�lnie.'));
define('_ACA_REMOVING_FAILED', compa::encodeutf('Usuwanie nieudane!'));
define('_ACA_INSTALL_DIFFERENT_VERSION', compa::encodeutf('Zainstaluj inn� wersj�'));
define('_ACA_CONTENT_ADD', compa::encodeutf('Dodaj zawarto��'));
define('_ACA_UPGRADE_FROM', compa::encodeutf('Import danych (newsletery i informacje o u�ytkownikach) z'));
define('_ACA_UPGRADE_MESS', compa::encodeutf('Nie ma �adnego ryzyka dla Twoich danych. <br> TTen proces po prostu importuje dane do bazy danych systemu Acajoom.'));
define('_ACA_CONTINUE_SENDING', compa::encodeutf('Kontynuacja wysy�ki'));

// Acajoom message
define('_ACA_UPGRADE1', compa::encodeutf('Mo�esz w prosty spos�b zaimportowa� u�ytkownik�w i newslettery z '));
define('_ACA_UPGRADE2', compa::encodeutf(' do Acajoom w panelu aktualizacji.'));
define('_ACA_UPDATE_MESSAGE', compa::encodeutf('Nowa wersja Acajoom jest dost�pna! '));
define('_ACA_UPDATE_MESSAGE_LINK', compa::encodeutf('Kliknij aby zaktualizowa�!'));
define('_ACA_CRON_SETUP', compa::encodeutf('Aby autoresponder by� wysy�any nale�y skonfigurowa� zadania crona.'));
define('_ACA_THANKYOU', compa::encodeutf('Dzi�kujemy za wybranie Acajoom, Twojego partnera w komunikacji!'));
define('_ACA_NO_SERVER', compa::encodeutf('Aktualizacja niedost�pna, prosimy wr�ci� p�niej.'));
define('_ACA_MOD_PUB', compa::encodeutf('Acajoom modu� nie zosta� opublikowany.'));
define('_ACA_MOD_PUB_LINK', compa::encodeutf('Kliknij aby go opublikowa�!'));
define('_ACA_IMPORT_SUCCESS', compa::encodeutf('zaimportowano pomy�lnie'));
define('_ACA_IMPORT_EXIST', compa::encodeutf('subskrybent jest ju� w bazie danych'));

// Acajoom\'s Guide
define('_ACA_GUIDE', compa::encodeutf(' Czarodziej'));
define('_ACA_GUIDE_FIRST_ACA_STEP', compa::encodeutf('<p>Acajoom ma wiele ciekawych cech i ten Czarodziej b�dzie Ci� prowadzi� przez cztery proste kroki umo�liwiaj�ce przesy�anie newsletter�w i autoresponder�w!<p />'));
define('_ACA_GUIDE_FIRST_ACA_STEP_DESC', compa::encodeutf('Po pierwsze, musisz doda� list�.  Mamy tu dwa rodzaje list: newsletter lub autoresponder.' .
		'  W li�cie okre�la si� wszystkie parametry umo�liwiaj�ce wysy�anie newslettera lub autorespondera: nazw� nadawcy, uk�ad, komunikat powitalny dla subskrybenta itp...
<br><br>Tutaj mo�esz ustawi� swoj� pierwsz� list�: <a href="index2.php?option=com_acajoom&act=list" >utw�rz list�</a> i klkinij przycisk Nowy.'));
define('_ACA_GUIDE_FIRST_ACA_STEP_UPGRADE', compa::encodeutf('Acajoom dostarcza bardzo przyst�pne rozwi�zania umozliwiaj�ce import danych z innych system�w.<br>' .
		' Przejd� do panela uaktualnie� i wybierz sw�j poprzedni system aby zaimportowa� newslettery i u�ytkownik�w.<br><br>' .
		'<span style="color:#FF5E00;" >WA�NE: proces importu nie jest obarczony ryzykiem i nie wp�ynie w �aden spos�b na dane w Twoim starszym systemie newslettera</span><br>' .
		'Po zaimportowaniu danych b�dzie mo�liwe administrowanie subskrybentami i mailingami wprost z Acajoom.<br><br>'));
define('_ACA_GUIDE_SECOND_ACA_STEP', compa::encodeutf('Wspaniele, pierwsza lista jest ustawiona!  Teraz mo�esz napisa� sw�j pierwszy %s.  Aby go utworzy� id� do: '));
define('_ACA_GUIDE_SECOND_ACA_STEP_AUTO', compa::encodeutf('Administracja auto-responderem'));
define('_ACA_GUIDE_SECOND_ACA_STEP_NEWS', compa::encodeutf('Administracja newsletterem'));
define('_ACA_GUIDE_SECOND_ACA_STEP_FINAL', compa::encodeutf(' i wybierz %s. <br> Nast�pnie wybierz %s z listy rozwijalnej.  Utw�rz pierwszy mailing klikaj�c Nowy '));

define('_ACA_GUIDE_THRID_ACA_STEP_NEWS', compa::encodeutf('Zanim wy�lesz sw�j pierwszy newsletter musisz sprawdzi� konfiguracj� poczty.  ' .
		'Przejd� do <a href="index2.php?option=com_acajoom&act=configuration" >strony konfiguracyjnej</a> aby zweryfikowa� ustawienia e-mail. <br>'));
define('_ACA_GUIDE_THRID2_ACA_STEP_NEWS', compa::encodeutf('<br>Kiedy b�dziesz gotowy wr�� do menu newslettera, wybiezr mailing i kliknij Wy�lij'));

define('_ACA_GUIDE_THRID_ACA_STEP_AUTOS', compa::encodeutf('W celu wys�ania autrespondera najpierw musisz skonfigurowa� zadania crona na serwerze. ' .
		' Prosz� przej�� do swojego panela aby skonfigurowa� zadania crona.' .
		' <a href="index2.php?option=com_acajoom&act=configuration" >kliknij tu</a> aby dowiedzie� si� wi�cej o konfiguracji crona. <br>'));

define('_ACA_GUIDE_MODULE', compa::encodeutf(' <br>Upewnij si� czy modu� Acajoom jest opublikowany aby odwiedzaj�cy mogli zapisa� si� na list�.'));

define('_ACA_GUIDE_FOUR_ACA_STEP_NEWS', compa::encodeutf(' Teraz mo�esz r�wnie� ustawi� autoresponder.'));
define('_ACA_GUIDE_FOUR_ACA_STEP_AUTOS', compa::encodeutf(' Teraz mo�esz r�wnie� ustawi� a newsletter.'));

define('_ACA_GUIDE_FOUR_ACA_STEP', compa::encodeutf('<p><br>Gratulacje! Jeste� got�w do efektywnego komunikowania si� z u�ytkownikami i go��mi. Ten CZarodziej zako�czy prac� po wys�aniu drugiego mailingu. Mo�na go przywr�ci� w <a href="index2.php?option=com_acajoom&act=configuration" >panelu konfiguracyjnym</a>.' .
		'<br><br>  Je�li b�dziesz mie� jakie� pytania w czasie u�ywania Acajoom, prosz� zada� je na  ' .
		'<a target="_blank" href="http://www.ijoobi.com/index.php?option=com_agora&Itemid=60" >forum</a>. ' .
		' Mo�esz tam te� znale�� wiele informacji jak efektywnie komunikowa� si� ze swoimi subskrybentami <a href="http://www.ijoobi.com/" target="_blank" >www.ijoobi.com</a>.' .
		'<p /><br><b>Dzi�kujemy, �e u�ywasz Acajoom. Twojego partnera w komunikacji!</b> '));
define('_ACA_GUIDE_TURNOFF', compa::encodeutf('Czarodziej zosta� wy��czony!'));
define('_ACA_STEP', compa::encodeutf('STEP '));

// Acajoom Install
define('_ACA_INSTALL_CONFIG', compa::encodeutf('Konfiguracja Acajoom'));
define('_ACA_INSTALL_SUCCESS', compa::encodeutf('Pomy�lnie zainstalowane'));
define('_ACA_INSTALL_ERROR', compa::encodeutf('B��d instalacji'));
define('_ACA_INSTALL_BOT', compa::encodeutf('Acajoom Plugin (Bot)'));
define('_ACA_INSTALL_MODULE', compa::encodeutf('Modu� Acajoom'));
//Others
define('_ACA_JAVASCRIPT', compa::encodeutf('!UWAGA! obs�uga javascript musi by� w��czona w czasie tej operacji.'));
define('_ACA_EXPORT_TEXT', compa::encodeutf('Eksportowani subskrybenci s� widoczni na liscie wyboru. <br>Eksportuj subskrybent�w z listy'));
define('_ACA_IMPORT_TIPS', compa::encodeutf('Import subskrybent�w. Informacja w pliku powinna mie� nast�puj�c� struktur�: <br>' .
		'Name,email,receiveHTML(1/0),<span style="color: rgb(255, 0, 0);">confirmed(1/0)</span>'));
define('_ACA_SUBCRIBER_EXIT', compa::encodeutf('jest ju� subskrybentem'));
define('_ACA_GET_STARTED', compa::encodeutf('Klknij tu by rozpocz��!'));

//News since 1.0.1
define('_ACA_WARNING_1011', compa::encodeutf('Uwaga: 1011: Aktualizacja nie b�dzie mo�liwa z powodu ogranicze� serwera.'));
define('_ACA_SEND_MAIL_FROM_TIPS', compa::encodeutf('used as Bounced back for all your messages'));
define('_ACA_SEND_MAIL_NAME_TIPS', compa::encodeutf('Wybierz imi�, kt�re b�dzie widoczne jako nadawca.'));
define('_ACA_MAILSENDMETHOD_TIPS', compa::encodeutf('Wybierz spos�b wysy�ki e-maili: PHP mail , <span>Sendmail</span> lub SMTP Server.'));
define('_ACA_SENDMAILPATH_TIPS', compa::encodeutf('To jest katalog Mail serwera'));
define('_ACA_LIST_T_TEMPLATE', compa::encodeutf('Szablon'));
define('_ACA_NO_MAILING_ENTERED', compa::encodeutf('Mailing nie ustawiony'));
define('_ACA_NO_LIST_ENTERED', compa::encodeutf('Lista nie ustawiona'));
define('_ACA_SENT_MAILING', compa::encodeutf('Wys�any mailing'));
define('_ACA_SELECT_FILE', compa::encodeutf('Prosze wybra� plik do '));
define('_ACA_LIST_IMPORT', compa::encodeutf('Zazanacz listy, kt�re chcesz dowi�za� do subskrybent�w.'));
define('_ACA_PB_QUEUE', compa::encodeutf('Subskrybent sopisany, ale wyst�pi� problem z po��czeniem go z list�. Dokonaj r�cznego wyboru.'));
define('_ACA_UPDATE_MESS1', compa::encodeutf('Zalecana aktualizacja!'));
define('_ACA_UPDATE_MESS2', compa::encodeutf('�atki i drobne poprawki.'));
define('_ACA_UPDATE_MESS3', compa::encodeutf('Nowa wersja.'));
define('_ACA_UPDATE_MESS5', compa::encodeutf('Joomla 1.5 - potrzebna aktualizacja.'));
define('_ACA_UPDATE_IS_AVAIL', compa::encodeutf(' jest dost�pna!'));
define('_ACA_NO_MAILING_SENT', compa::encodeutf('Mailing niewys�any!'));
define('_ACA_SHOW_LOGIN', compa::encodeutf('Poka� formularz logowania'));
define('_ACA_SHOW_LOGIN_TIPS', compa::encodeutf('Wybierz aby pokaza� formularz logowania do panela Acajoom na stronie.'));
define('_ACA_LISTS_EDITOR', compa::encodeutf('Edytor w opisie listy'));
define('_ACA_LISTS_EDITOR_TIPS', compa::encodeutf('Wybierz aby u�y� edytor HTML w opisie listy.'));
define('_ACA_SUBCRIBERS_VIEW', compa::encodeutf('Przegl�daj subskrybent�w'));

//News since 1.0.2
define('_ACA_FRONTEND_SETTINGS', compa::encodeutf('Ustawienia strony frontowej'));
define('_ACA_SHOW_LOGOUT', compa::encodeutf('Poka� przycisk wylogowania'));
define('_ACA_SHOW_LOGOUT_TIPS', compa::encodeutf('Wybierza tak aby pokaza� przycisk wylogowania w panelu Acajoom na stronie.'));

//News since 1.0.3 CB integration
define('_ACA_CONFIG_INTEGRATION', compa::encodeutf('Integracja'));
define('_ACA_CB_INTEGRATION', compa::encodeutf('Integracja z Community Builder'));
define('_ACA_INSTALL_PLUGIN', compa::encodeutf('Wtyczka do Community Builder (Integracja z Acajoom) '));
define('_ACA_CB_PLUGIN_NOT_INSTALLED', compa::encodeutf('Wtyczka Acajoom do Community Builder nie jest jeszcze zainstalowana!'));
define('_ACA_CB_PLUGIN', compa::encodeutf('Listy przy rejestracji'));
define('_ACA_CB_PLUGIN_TIPS', compa::encodeutf('Wybierz aby pokaza� listy wysy�kowe w formularzu rejestracji z komponentu CB'));
define('_ACA_CB_LISTS', compa::encodeutf('Listy IDs'));
define('_ACA_CB_LISTS_TIPS', compa::encodeutf('TO POLE JEST WYMAGANE. Wpisz numer identyfikacyjny listy, kt�r� maj� subskrybowa� u�ytkownicy. Kolejne identyfikatory oddziel przecinkiem (,) (0 pokazuje wszystkie listy)'));
define('_ACA_CB_INTRO', compa::encodeutf('Tekst wprowadzaj�cy'));
define('_ACA_CB_INTRO_TIPS', compa::encodeutf('Tekst, kt�ry b�dzie si� pojawia� przed wykazem. JE�LI ZOSTAWISZ PUSTE NIC NIE B�DZIE SI� WY�WIETLA�.  Mo�esz u�y� tag�w HTML.'));
define('_ACA_CB_SHOW_NAME', compa::encodeutf('Poka� nazw� listy'));
define('_ACA_CB_SHOW_NAME_TIPS', compa::encodeutf('Wybierz je�li chcesz wy�wietla� nazwy list subskrypcyjnych po tekscie wprowadzaj�cym.'));
define('_ACA_CB_LIST_DEFAULT', compa::encodeutf('Ustaw list� jako domy�ln�'));
define('_ACA_CB_LIST_DEFAULT_TIPS', compa::encodeutf('Wybierz je�li chcesz ustawi� list� jako domy�ln�.'));
define('_ACA_CB_HTML_SHOW', compa::encodeutf('Poka� - "Wysy�ka HTML"'));
define('_ACA_CB_HTML_SHOW_TIPS', compa::encodeutf('Wybierz je�li chcesz aby subskrybenci mogli zadecydowa� czy chc� otrzymywa� wiadomo�ci w formacie HTML.'));
define('_ACA_CB_HTML_DEFAULT', compa::encodeutf('Domy�lnie wysy�ka HTML'));
define('_ACA_CB_HTML_DEFAULT_TIPS', compa::encodeutf('Opcja ustawia domy�lny format mailingu.'));

// Since 1.0.4
define('_ACA_BACKUP_FAILED', compa::encodeutf('Nie mo�na zarchiwizowa� pliku! Plik nie b�dzie zast�piony.'));
define('_ACA_BACKUP_YOUR_FILES', compa::encodeutf('Starsza wersja plik�w zostan� zariwizowane w nast�puj�cym katalogu:'));
define('_ACA_SERVER_LOCAL_TIME', compa::encodeutf('SLokalny czas serwera'));
define('_ACA_SHOW_ARCHIVE', compa::encodeutf('Poka� przycisk archiwum'));
define('_ACA_SHOW_ARCHIVE_TIPS', compa::encodeutf('Wybierz aby pokaza� przycisk archiwum w wykazie newsteller�w na stronie frontowej'));
define('_ACA_LIST_OPT_TAG', compa::encodeutf('Zak�adki'));
define('_ACA_LIST_OPT_IMG', compa::encodeutf('Ilustracje'));
define('_ACA_LIST_OPT_CTT', compa::encodeutf('Zawarto��'));
define('_ACA_INPUT_NAME_TIPS', compa::encodeutf('Wpisz swoje imi� i nazwisko (koniecznie imi� pierwsze)'));
define('_ACA_INPUT_EMAIL_TIPS', compa::encodeutf('Wpisz sw�j adres e-mail (Upewnij si� czy jest to prawid�owy i aktualny adres.)'));
define('_ACA_RECEIVE_HTML_TIPS', compa::encodeutf('Wybierz TAK, je��i akceptujesz maile w formacie HTML - NIE aby otrzymywa� tylko wiadomo�ci w formacie tekstowym'));
define('_ACA_TIME_ZONE_ASK_TIPS', compa::encodeutf('Wybierz swoj� stref� czasow�.'));

// Since 1.0.5
define('_ACA_FILES', compa::encodeutf('Pliki'));
define('_ACA_FILES_UPLOAD', compa::encodeutf('Wy�lij'));
define('_ACA_MENU_UPLOAD_IMG', compa::encodeutf('Wy�lij obrazki'));
define('_ACA_TOO_LARGE', compa::encodeutf('Za du�y plik. Makszmalnz doyowlonz roymiar to'));
define('_ACA_MISSING_DIR', compa::encodeutf('Katalog nie istnieje'));
define('_ACA_IS_NOT_DIR', compa::encodeutf('Katalog nie istnieje lub plik nieprawidlowy.'));
define('_ACA_NO_WRITE_PERMS', compa::encodeutf('Katalog nie istnieje lub nie masz uprawnie� do zapisu.'));
define('_ACA_NO_USER_FILE', compa::encodeutf('Nie wybra�e� �adnych plik�w do wys�ania.'));
define('_ACA_E_FAIL_MOVE', compa::encodeutf('Przesuni�cie pliku niemo�liwe.'));
define('_ACA_FILE_EXISTS', compa::encodeutf('Plik ju� istnieje.'));
define('_ACA_CANNOT_OVERWRITE', compa::encodeutf('Plik ju� istnieje i nie mo�e zosta� nadpisany.'));
define('_ACA_NOT_ALLOWED_EXTENSION', compa::encodeutf('Niedupuszczalne rozszerzenie pliku.'));
define('_ACA_PARTIAL', compa::encodeutf('Ten plik by� cz�ciowo wys�any.'));
define('_ACA_UPLOAD_ERROR', compa::encodeutf('B��d wysy�ki:'));
define('DEV_NO_DEF_FILE', compa::encodeutf('Ten plik by� cz�ciowo wys�any.'));

// already exist but modified  added a <br/ on first line and added [SUBSCRIPTIONS] line>
define('_ACA_CONTENTREP', compa::encodeutf('[SUBSCRIPTIONS] = Ten element b�dzie zast�piony linkiem do subskrypcji.' .
		' Pole <strong>wymagane</strong> aby Acajoom pracowa� poprawnie.<br>' .
		'Je�li umie�cisz w tym polu inn� zawarto��, b�dzie ona wy�wietlana we wszystkich listach wysy�kowych.' .
		' <br> Dodaj na ko�cu wiadomo�� o subskrypcji.  Acajoom automatycznie doda link dla subskrybenta umo�liwiaj�cy zmian� ustawie� subskrybcji lub wypisanie si� z listy.'));

// since 1.0.6
define('_ACA_NOTIFICATION', compa::encodeutf('Powiadomienie'));  // shortcut for Email notification
define('_ACA_NOTIFICATIONS', compa::encodeutf('Powiadomienia'));
define('_ACA_USE_SEF', compa::encodeutf('SEF w mailingach'));
define('_ACA_USE_SEF_TIPS', compa::encodeutf('Zalecamy ustawienie tej opcji na NIE.  Jednak�e, je�li chcesz aby adresy URL za��czone w mailingach u�ywa�y opcji SEF, wybierz TAK.' .
		' <br><b> Linki b�da dzia�a�y tak samo dla obu opcji. </b> '));
define('_ACA_ERR_NB', compa::encodeutf('B��d #: ERR'));
define('_ACA_ERR_SETTINGS', compa::encodeutf('B��d ustawie�'));
define('_ACA_ERR_SEND', compa::encodeutf('Wy�lij raport o b��dach'));
define('_ACA_ERR_SEND_TIPS', compa::encodeutf(' Je�li chcesz pom�c w ulepszeniu naszego produktu wybierz TAK.  Spowoduje to przes�anie raportu do nas.  WI�cej powiadomie� nie b�dzie wi�c potrzeba ;-) <br> <b>PRYWATNE INFORMACJE NIE S� PRZESY�ANE</b>.  Nie wiemy sk�d pochodz� wiadomo�ci o b��dach. Wysy�ana jest tylko informacja o Acajoom , ustawieniach PHP i zapytaniach SQL. '));
define('_ACA_ERR_SHOW_TIPS', compa::encodeutf('Wybierz Tak aby wy�wietlac numer b��du na ekranie.  U�ywane g�ownie w celu wykrywania i usuwania usterek. '));
define('_ACA_ERR_SHOW', compa::encodeutf('Poka� b��dy'));
define('_ACA_LIST_SHOW_UNSUBCRIBE', compa::encodeutf('Poka� link do wypisania si�'));
define('_ACA_LIST_SHOW_UNSUBCRIBE_TIPS', compa::encodeutf('Wybierz aby pokaza� link do wypisania si� lub zmiany ustawie� subskrypcji list wysy�kowych w stopce ka�dej wiadomo�ci. <br> Ustawienie NIE wy��cza stopk� i linki.'));
define('_ACA_UPDATE_INSTALL', compa::encodeutf('<span style="color: rgb(255, 0, 0);">WA�NE POWIADMOMIENIE!</span> <br>Je�li dokona�e� aktualizacji z poprzedniej wersji Acajoom powiniene� zaktualizowa� struktur� bazy danych klikaj�c w nast�puj�cy przycisk (Twoje dane zostan� nienaruszone)'));
define('_ACA_UPDATE_INSTALL_BTN', compa::encodeutf('Aktualizacja tabel i konfiguracji'));
define('_ACA_MAILING_MAX_TIME', compa::encodeutf('Maksymalny czas kolejki'));
define('_ACA_MAILING_MAX_TIME_TIPS', compa::encodeutf('Zdefiniuj maksymalny czas dla wszystkich maili wysy�anych w kolejce. Zalecamy warto�� mi�dzy 30s a 2min.'));

// virtuemart integration beta
define('_ACA_VM_INTEGRATION', compa::encodeutf('Integracja z VirtueMart'));
define('_ACA_VM_COUPON_NOTIF', compa::encodeutf('Zawiadomienie o kupinie ID'));
define('_ACA_VM_COUPON_NOTIF_TIPS', compa::encodeutf('Wybierz numer ID mailingu w kt�rym zamierzasz wys�a� kupon rabatowy dla swoich klient�w.'));
define('_ACA_VM_NEW_PRODUCT', compa::encodeutf('Zawiadomienie o nowych produktach ID'));
define('_ACA_VM_NEW_PRODUCT_TIPS', compa::encodeutf('Wybiezr numer ID mailingu w kt�rym zamierzasz zawiadomi� o nowych produktach.'));

// since 1.0.8
// create forms for subscriptions
define('_ACA_FORM_BUTTON', compa::encodeutf('Utw�rz formularz'));
define('_ACA_FORM_COPY', compa::encodeutf('Kod HTML'));
define('_ACA_FORM_COPY_TIPS', compa::encodeutf('Skopiuj wygenerowany kod HTML na twoj� stron�.'));
define('_ACA_FORM_LIST_TIPS', compa::encodeutf('Wybierz list� w kt�rej chcesz za��czy� formularz'));
// update messages
define('_ACA_UPDATE_MESS4', compa::encodeutf('To nie mo�e by� zaktualiyowane automatycznie.'));
define('_ACA_WARNG_REMOTE_FILE', compa::encodeutf('Brak mo�liwo�ci otrzymania zdalnego pliku.'));
define('_ACA_ERROR_FETCH', compa::encodeutf('B��d przenoszonego pliku.'));

define('_ACA_CHECK', compa::encodeutf('Wybierz'));
define('_ACA_MORE_INFO', compa::encodeutf('Wi�cej informacji'));
define('_ACA_UPDATE_NEW', compa::encodeutf('Aktualizacja do nowszej wersji'));
define('_ACA_UPGRADE', compa::encodeutf('Aktualizacja do wy�szego produktu'));
define('_ACA_DOWNDATE', compa::encodeutf('Powr�t do poprzedniej wersji'));
define('_ACA_DOWNGRADE', compa::encodeutf('Powr�t do podstawowego produktu'));
define('_ACA_REQUIRE_JOOM', compa::encodeutf('Joomla wymagana'));
define('_ACA_TRY_IT', compa::encodeutf('Wypr�buj!'));
define('_ACA_NEWER', compa::encodeutf('Nowsza'));
define('_ACA_OLDER', compa::encodeutf('Starsza'));
define('_ACA_CURRENT', compa::encodeutf('Aktualna'));

// since 1.0.9
define('_ACA_CHECK_COMP', compa::encodeutf('Wypr�buj jeden z innych  komponent�w'));
define('_ACA_MENU_VIDEO', compa::encodeutf('Wideo tutorial'));
define('_ACA_AUTO_SCHEDULE', compa::encodeutf('Przypomnienie'));
define('_ACA_SCHEDULE_TITLE', compa::encodeutf('Ustawienia funkcji automatycznego przypomnienia'));
define('_ACA_ISSUE_NB_TIPS', compa::encodeutf('Publikowane numery generowane s� automatycznie przez system'));
define('_ACA_SEL_ALL', compa::encodeutf('Wszystkie mailingi'));
define('_ACA_SEL_ALL_SUB', compa::encodeutf('Wszystkie listy'));
define('_ACA_INTRO_ONLY_TIPS', compa::encodeutf('Je�li zaznaczysz tylko informacja wst�pna z artyku�u z linkiem czytaj wi�cej, b�dzie za��czona do mailingu.'));
define('_ACA_TAGS_TITLE', compa::encodeutf('Zak�adka zawarto�ci'));
define('_ACA_TAGS_TITLE_TIPS', compa::encodeutf('Skopijuj i wklej t� zak�adk� do mailingu, w miejscu w kt�rym chcesz wy�wietli� zawarto��.'));
define('_ACA_PREVIEW_EMAIL_TEST', compa::encodeutf('Podaj adres email, na kt�ry zostanie wys�any testowy mailing'));
define('_ACA_PREVIEW_TITLE', compa::encodeutf('Podgl�d'));
define('_ACA_AUTO_UPDATE', compa::encodeutf('Nowe powiadomienie o aktualizacji'));
define('_ACA_AUTO_UPDATE_TIPS', compa::encodeutf('Wybierz tak je�li chcesz zosta� powiadomiony o nowej aktualizacji towjego komponentu. <br />WA�NE!! Funkcja poka� tips-y musi by� w��czona aby powiadomienie dzia�a�o.'));

// since 1.1.0
define('_ACA_LICENSE', compa::encodeutf('Informacja o licencji'));


// since 1.1.1
define('_ACA_NEW', compa::encodeutf('New'));
define('_ACA_SCHEDULE_SETUP', compa::encodeutf('In order for the autoresponders to be sent you need to setup scheduler in the configuration.'));
define('_ACA_SCHEDULER', compa::encodeutf('Scheduler'));
define('_ACA_ACAJOOM_CRON_DESC', compa::encodeutf('if you do not have access to a cron task manager on your website, you can register for a Free Acajoom Cron account at:'));
define('_ACA_CRON_DOCUMENTATION', compa::encodeutf('You can find further information on setting up the Acajoom Scheduler at the following url:'));
define('_ACA_CRON_DOC_URL', compa::encodeutf('<a href="http://www.ijoobi.com/index.php?option=com_content&view=article&id=4249&catid=29&Itemid=72"
 target="_blank">http://www.ijoobi.com/index.php?option=com_content&Itemid=72&view=category&layout=blog&id=29&limit=60</a>'));
define( '_ACA_QUEUE_PROCESSED', compa::encodeutf('Queue processed succefully...'));
define( '_ACA_ERROR_MOVING_UPLOAD', compa::encodeutf('Error moving imported file'));

//since 1.1.4
define( '_ACA_SCHEDULE_FREQUENCY', compa::encodeutf('Scheduler frequency'));
define( '_ACA_CRON_MAX_FREQ', compa::encodeutf('Scheduler max frequency'));
define( '_ACA_CRON_MAX_FREQ_TIPS', compa::encodeutf('Specify the maximum frequency the scheduler can run ( in minutes ).  This will limit the scheduler even if the cron task is set up more frequently.'));
define( '_ACA_CRON_MAX_EMAIL', compa::encodeutf('Maximum emails per task'));
define( '_ACA_CRON_MAX_EMAIL_TIPS', compa::encodeutf('Specify the maximum number of emails sent per task (0 unlimited).'));
define( '_ACA_CRON_MINUTES', compa::encodeutf(' minutes'));
define( '_ACA_SHOW_SIGNATURE', compa::encodeutf('Show email footer'));
define( '_ACA_SHOW_SIGNATURE_TIPS', compa::encodeutf('Whether or not you want to promote Acajoom in the footer of the emails.'));
define( '_ACA_QUEUE_AUTO_PROCESSED', compa::encodeutf('Auto-responders processed successfully...'));
define( '_ACA_QUEUE_NEWS_PROCESSED', compa::encodeutf('Scheduled newsletters processed successfully...'));
define( '_ACA_MENU_SYNC_USERS', compa::encodeutf('Sync Users'));
define( '_ACA_SYNC_USERS_SUCCESS', compa::encodeutf('Users Synchronization Successful!'));

// compatibility with Joomla 15
if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', compa::encodeutf('Logout'));
if (!defined('_CMN_YES')) define( '_CMN_YES', compa::encodeutf('Yes'));
if (!defined('_CMN_NO')) define( '_CMN_NO', compa::encodeutf('No'));
if (!defined('_HI')) define( '_HI', compa::encodeutf('Hi'));
if (!defined('_CMN_TOP')) define( '_CMN_TOP', compa::encodeutf('Top'));
if (!defined('_CMN_BOTTOM')) define( '_CMN_BOTTOM', compa::encodeutf('Bottom'));
//if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', compa::encodeutf('Logout'));

// For include title only or full article in content item tab in newsletter edit - p0stman911
define('_ACA_TITLE_ONLY_TIPS', compa::encodeutf('If you select this only the title of the article will be inserted into the mailing as a link to the complete article on your site.'));
define('_ACA_TITLE_ONLY', compa::encodeutf('Title Only'));
define('_ACA_FULL_ARTICLE_TIPS', compa::encodeutf('If you select this the complete article will be inserted into the mailing'));
define('_ACA_FULL_ARTICLE', compa::encodeutf('Full Article'));
define('_ACA_CONTENT_ITEM_SELECT_T', compa::encodeutf('Select a content item to append to the message. <br />Copy and paste the <b>content tag</b> into the mailing.  You can choose to have the full text, intro only, or title only with (0, 1, or 2 respectively). '));
define('_ACA_SUBSCRIBE_LIST2', compa::encodeutf('Mailing list(s)'));

// smart-newsletter function
define('_ACA_AUTONEWS', compa::encodeutf('Smart-Newsletter'));
define('_ACA_MENU_AUTONEWS', compa::encodeutf('Smart-Newsletters'));
define('_ACA_AUTO_NEWS_OPTION', compa::encodeutf('Smart-Newsletter options'));
define('_ACA_AUTONEWS_FREQ', compa::encodeutf('Newsletter Frequency'));
define('_ACA_AUTONEWS_FREQ_TIPS', compa::encodeutf('Specify the frequency at which you want to send the smart-newsletter.'));
define('_ACA_AUTONEWS_SECTION', compa::encodeutf('Article Section'));
define('_ACA_AUTONEWS_SECTION_TIPS', compa::encodeutf('Specify the section you want to choose the articles from.'));
define('_ACA_AUTONEWS_CAT', compa::encodeutf('Article Category'));
define('_ACA_AUTONEWS_CAT_TIPS', compa::encodeutf('Specify the category you want to choose the articles from (All for all article in that section).'));
define('_ACA_SELECT_SECTION', compa::encodeutf('All Sections'));
define('_ACA_SELECT_CAT', compa::encodeutf('All Categories'));
define('_ACA_AUTO_DAY_CH8', compa::encodeutf('Quaterly'));
define('_ACA_AUTONEWS_STARTDATE', compa::encodeutf('Start date'));
define('_ACA_AUTONEWS_STARTDATE_TIPS', compa::encodeutf('Specify the date you want to start sending the Smart Newsletter.'));
define('_ACA_AUTONEWS_TYPE', compa::encodeutf('Content rendering'));// how we see the content which is included in the newsletter
define('_ACA_AUTONEWS_TYPE_TIPS', compa::encodeutf('Full Article: will include the entire article in the newsletter.<br />' .
		'Intro only: will include only the introduction of the article in the newsletter.<br/>' .
		'Title only: will include only the title of the article in the newsletter.'));
define('_ACA_TAGS_AUTONEWS', compa::encodeutf('[SMARTNEWSLETTER] = This will be replaced by the Smart-newsletter.'));

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
define( '_ACA_LICENSE_FORM', compa::encodeutf(' ' .
 		'Click here to go to the license form.</a>'));
define('_ACA_PLEASE_CLEAR_LICENSE', compa::encodeutf('Please clear the license field so it is empty and try again.<br />  If the problem persists, '));
define( '_ACA_LICENSE_SUPPORT', compa::encodeutf('If you still have questions, ' . _ACA_PLEASE_LIC));
define( '_ACA_LICENSE_TWO', compa::encodeutf('you can get your license manual by entering the token number and site URL (which is highlighted in green at the top of this page) in the License form. '
					     . _ACA_LICENSE_FORM . '<br /><br/>' . _ACA_LICENSE_SUPPORT));
define('_ACA_ENTER_TOKEN_PATIENCE', compa::encodeutf('After saving your token a license will be generated automatically. ' .
		' Usually the token is validated in 2 minutes.  However, in some cases it can take up to 15 minutes.<br />' .
		'<br />Check back this control panel in few minutes.  <br /><br />' .
		'If you didn\'t receive a valid license key in 15 minutes, '. _ACA_LICENSE_TW));
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
define('_ACA_REGWARN_NAME', compa::encodeutf('Podaj swoje nazwisko i imie.'));
define('_ACA_REGWARN_MAIL', compa::encodeutf('Podaj poprawny adres e-mail.'));

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
if(!defined('_CMN_SAVE')) define('_CMN_SAVE', 'Save');
if(!defined('_NO_ACCOUNT')) define('_NO_ACCOUNT', 'No account yet?');
if(!defined('_CREATE_ACCOUNT')) define('_CREATE_ACCOUNT', 'Register');
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