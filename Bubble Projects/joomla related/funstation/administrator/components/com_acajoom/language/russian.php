<?php
defined('_JEXEC') OR defined('_VALID_MOS') OR die('...Direct Access to this location is not allowed...');


/**
* <p>������� �������� ����</p>
* @author Salikhov Ilyas <salikhoff@gmail.com>
* @version $Id: russian.php 491 2007-02-01 22:56:07Z divivo $
*/


### General ###
 // �������� acajoom
define('_ACA_DESC_NEWS', 'Acajoom - ��� ���������� �������� ��������, �������� �������� � ������������� ��� ����������� ������������ � ������ ������������ � ���������.  ' .
		'Acajoom, ��� ���������������� �������!');
define('_ACA_FEATURES', 'Acajoom, ��� ���������������� �������!');

// ��� �������
define('_ACA_NEWSLETTER', '�������������� ���������');
define('_ACA_AUTORESP', '������������');
define('_ACA_AUTORSS', 'RSS-��������');
define('_ACA_ECARD', 'eCard');
define('_ACA_POSTCARD', '�������� ��������');
define('_ACA_PERF', '������������������');
define('_ACA_COUPON', '�����');
define('_ACA_CRON', '������ �����');
define('_ACA_MAILING', '�������� ��������');
define('_ACA_LIST', '������');

// ���� acajoom
define('_ACA_MENU_LIST', '������');
define('_ACA_MENU_SUBSCRIBERS', '����������');
define('_ACA_MENU_NEWSLETTERS', '�������������� ���������');
define('_ACA_MENU_AUTOS', '�������������');
define('_ACA_MENU_COUPONS', '������');
define('_ACA_MENU_CRONS', '������ �����');
define('_ACA_MENU_AUTORSS', 'RSS-��������');
define('_ACA_MENU_ECARD', 'eCards');
define('_ACA_MENU_POSTCARDS', '�������� ��������');
define('_ACA_MENU_PERFS', '������������������');
define('_ACA_MENU_TAB_LIST', '������');
define('_ACA_MENU_MAILING_TITLE', '�������� ��������');
define('_ACA_MENU_MAILING' , '�������� ��� ');
define('_ACA_MENU_STATS', '����������');
define('_ACA_MENU_STATS_FOR', '���������� ���');
define('_ACA_MENU_CONF', '������������');
define('_ACA_MENU_UPDATE', 'Import');
define('_ACA_MENU_ABOUT', '�');
define('_ACA_MENU_LEARN', '����� �����������');
define('_ACA_MENU_MEDIA', '�����-��������'); // ��� - "�������� ��������"
define('_ACA_MENU_HELP', '������');
define('_ACA_MENU_CPANEL', 'CPanel');
define('_ACA_MENU_IMPORT', '������');
define('_ACA_MENU_EXPORT', '�������');
define('_ACA_MENU_SUB_ALL', '����������� �� ���');
define('_ACA_MENU_UNSUB_ALL', '���������� ��� ��������');
define('_ACA_MENU_VIEW_ARCHIVE', '�����');
define('_ACA_MENU_PREVIEW', '������������');
define('_ACA_MENU_SEND', '��������');
define('_ACA_MENU_SEND_TEST', '����������� ����� ��� ����� ��������');
define('_ACA_MENU_SEND_QUEUE', '������� ��������');
define('_ACA_MENU_VIEW', '���');
define('_ACA_MENU_COPY', '�����');
define('_ACA_MENU_VIEW_STATS' , '�������� ����������');
define('_ACA_MENU_CRTL_PANEL' , '������ ����������');
define('_ACA_MENU_LIST_NEW' , '������� ������');
define('_ACA_MENU_LIST_EDIT' , '������� ������');
define('_ACA_MENU_BACK', '�����');
define('_ACA_MENU_INSTALL', '�����������');
define('_ACA_MENU_TAB_SUM', '������');
define('_ACA_STATUS', '���������');

// ���������
define('_ACA_ERROR' , ' ��������� ������! ');
define('_ACA_SUB_ACCESS' , '����� �������');
define('_ACA_DESC_CREDITS', '� ������');
define('_ACA_DESC_INFO', '����������');
define('_ACA_DESC_HOME', '�������� ��������');
define('_ACA_DESC_MAILING', '������ ��������');
define('_ACA_DESC_SUBSCRIBERS', '����������');
define('_ACA_PUBLISHED','������������');
define('_ACA_UNPUBLISHED','�� ������������');
define('_ACA_DELETE','�������');
define('_ACA_FILTER','������');
define('_ACA_UPDATE','��������');
define('_ACA_SAVE','���������');
define('_ACA_CANCEL','��������');
define('_ACA_NAME','���');
define('_ACA_EMAIL','����������� �����');
define('_ACA_SELECT','�������');
define('_ACA_ALL','���');
define('_ACA_SEND_A', '������������... ');
define('_ACA_SUCCESS_DELETED', ' �������� ������ �������');
define('_ACA_LIST_ADDED', '������ ������� ������');
define('_ACA_LIST_COPY', '������ ������� ����������');
define('_ACA_LIST_UPDATED', '������ ������� ��������');
define('_ACA_MAILING_SAVED', '�������� ����������� ������� ���������.');
define('_ACA_UPDATED_SUCCESSFULLY', '������� ��������.');

### Subscribers information ###
// �������� � ������� ��������
define('_ACA_SUB_INFO', '������ ����������');
define('_ACA_VERIFY_INFO', '����������, ��������� ��������� ���� ������. ��������� ���������� �������� �����������.');
define('_ACA_INPUT_NAME', '���');
define('_ACA_INPUT_EMAIL', '����������� �����');
define('_ACA_RECEIVE_HTML', '�������� HTML?');
define('_ACA_TIME_ZONE', '������� ����');
define('_ACA_BLACK_LIST', '׸���� ������');
define('_ACA_REGISTRATION_DATE', '���� ����������� ������������');
define('_ACA_USER_ID', '������������� ������������');
define('_ACA_DESCRIPTION', '��������');
define('_ACA_ACCOUNT_CONFIRMED', '���� ������� ������ ������������.');
define('_ACA_SUB_SUBSCRIBER', '���������');
define('_ACA_SUB_PUBLISHER', '��������');
define('_ACA_SUB_ADMIN', '�������������');
define('_ACA_REGISTERED', '����������������');
define('_ACA_SUBSCRIPTIONS', '���� ��������');
define('_ACA_SEND_UNSUBCRIBE', '��������� �� ������������� ��������');
define('_ACA_SEND_UNSUBCRIBE_TIPS', '������� ��, ����� �������� ������ � �������������� ������������� ��������.');
define('_ACA_SUBSCRIBE_SUBJECT_MESS', '����������, ����������� ��������');
define('_ACA_UNSUBSCRIBE_SUBJECT_MESS', '������������� ������ �� ��������');
define('_ACA_DEFAULT_SUBSCRIBE_MESS', '������������, [NAME],<br />' .
		'��� ���� ���, � �� ������ ��������� �� ��������. ����������, ��������� �� ������ ����� ����������� ��������.' .
		'<br /><br />[CONFIRM]<br /><br />���� � ��� �������� �������, ����������, ���������� � ��������������.');
define('_ACA_DEFAULT_UNSUBSCRIBE_MESS', '��������� ������� ������� ���, ��� �� ���� ������� �� ����� ���� �����������. �� �������� � ���, ��� �� ������� ������� ���������� �� ��������. ���� �� �������� ������������ ��������, �� ������ ������ ������� ��� �� ����� �����. ���� � ��� ��������� �������, ����������� � ������ ��������������.');

// ���������� Acajoom
define('_ACA_SIGNUP_DATE', '���� ��������');
define('_ACA_CONFIRMED', '������������');
define('_ACA_SUBSCRIB', '�����������');
define('_ACA_HTML', 'HTML ��������');
define('_ACA_RESULTS', '����������');
define('_ACA_SEL_LIST', '�������� ������');
define('_ACA_SEL_LIST_TYPE', '- �������� ��� ������ -');
define('_ACA_SUSCRIB_LIST', '������ ���� �����������');
define('_ACA_SUSCRIB_LIST_UNIQUE', '���������� ��:  ');
define('_ACA_NO_SUSCRIBERS', '��� ����� ������ �� ������� �� ������ ����������.');
define('_ACA_COMFIRM_SUBSCRIPTION', '��� ���� ������� ������ ��� ������������� ��������.  ����������, ������� ����� � ��������� �� ��������� ������.<br />' .
		'����� �������� ���� �������������, �� ������ ����������� ���� e-mail.');
define('_ACA_SUCCESS_ADD_LIST', '�� ���� ������� ��������� � ������ �����������.');


 // Subcription info
define('_ACA_CONFIRM_LINK', '������� �����, ����� ����������� ��������');
define('_ACA_UNSUBSCRIBE_LINK', '������� �����, ����� ������� ���� �� ������ �����������');
define('_ACA_UNSUBSCRIBE_MESS', '����� ����� ����������� ����� ��� ������ �� ������');

define('_ACA_QUEUE_SENT_SUCCESS' , '��� ������������ �������� ���� ������� ���������.');
define('_ACA_MALING_VIEW', '�������� ��� ��������');
define('_ACA_UNSUBSCRIBE_MESSAGE', '�� �������, ��� ������ ���������� �� �������� �� ������� �����?');
define('_ACA_MOD_SUBSCRIBE', '�����������');
define('_ACA_SUBSCRIBE', '�����������');
define('_ACA_UNSUBSCRIBE', '���������� �� ��������');
define('_ACA_VIEW_ARCHIVE', '�������� �����');
define('_ACA_SUBSCRIPTION_OR', ' ��� ������� ����� ����� ������� ���������');
define('_ACA_EMAIL_ALREADY_REGISTERED', '���� ����� ��� ���� � ����.');
define('_ACA_SUBSCRIBER_DELETED', '��������� ������� ������.');


### ������ ������������ ###
 // ���������������� ����
define('_UCP_USER_PANEL', '���������������� ������ ����������');
define('_UCP_USER_MENU', '���������������� ����');
define('_UCP_USER_CONTACT', '��� ��������');
 // ���� ����� Acajoom
define('_UCP_CRON_MENU', '���������� �������� �����');
define('_UCP_CRON_NEW_MENU', '����� ����');
define('_UCP_CRON_LIST_MENU', '������ ��� ����');
 // ���� ������ Acajoom
define('_UCP_COUPON_MENU', '���������� ��������');
define('_UCP_COUPON_LIST_MENU', '������ �������');
define('_UCP_COUPON_ADD_MENU', '�������� �����');

### ������ ###
// �������
define('_ACA_LIST_T_GENERAL', '��������');
define('_ACA_LIST_T_LAYOUT', '���������');
define('_ACA_LIST_T_SUBSCRIPTION', '��������');
define('_ACA_LIST_T_SENDER', '������ �����������');

define('_ACA_LIST_TYPE', '��� ������');
define('_ACA_LIST_NAME', '��� ������');
define('_ACA_LIST_ISSUE', '���������� #');
define('_ACA_LIST_DATE', '���� ��������');
define('_ACA_LIST_SUB', '���� ��������');
define('_ACA_ATTACHED_FILES', '������������� �����');
define('_ACA_SELECT_LIST', '����������, �������� ������ ��� ��������������!');

// ���� �������������
define('_ACA_AUTORESP_ON', '��� ������');
define('_ACA_AUTO_RESP_OPTION', '��������� �������������');
define('_ACA_AUTO_RESP_FREQ', '���������� ����� �������� ������������� ��������');
define('_ACA_AUTO_DELAY', '������� (� ����)');
define('_ACA_AUTO_DAY_MIN', '����������� �������');
define('_ACA_AUTO_DAY_MAX', '������������ �������');
define('_ACA_FOLLOW_UP', '���������� ������������� ������������');
define('_ACA_AUTO_RESP_TIME', '���������� ����� �������� �����');
define('_ACA_LIST_SENDER', '����������� ������');

define('_ACA_LIST_DESC', '�������� ������');
define('_ACA_LAYOUT', '�����');
define('_ACA_SENDER_NAME', '��� �����������');
define('_ACA_SENDER_EMAIL', '��. ����� �����������');
define('_ACA_SENDER_BOUNCE', '�������� ����� �����������');
define('_ACA_LIST_DELAY', '�������');
define('_ACA_HTML_MAILING', 'HTML ��������?');
define('_ACA_HTML_MAILING_DESC', '(���� �� ��������� ���, ��� ����� ���������� ����� � ����� ����� �� ��������, ����� ������� ���������.)');
define('_ACA_HIDE_FROM_FRONTEND', '�� ���������� �� ��������?');
define('_ACA_SELECT_IMPORT_FILE', '�������� ���� ��� �������');;
define('_ACA_IMPORT_FINISHED', '�������������� ���������');
define('_ACA_DELETION_OFFILE', '�������� �����');
define('_ACA_MANUALLY_DELETE', '�� ����������, �� ������ ������� ������� ����');
define('_ACA_CANNOT_WRITE_DIR', '�� ���� �������� � ����������');
define('_ACA_NOT_PUBLISHED', '�� ���� ��������� ��������.������ �� �����������.');

//  �������������� ���� �������
define('_ACA_INFO_LIST_PUB', '������� ��, ����� ������������ ������.');
define('_ACA_INFO_LIST_NAME', '������� ��� ������. � ������� ����� ����� �� ������� ���������������� ������.');
define('_ACA_INFO_LIST_DESC', '������� ������� �������� ������ ������. ��� ����� �������� ��� ����������� ������ �������.');
define('_ACA_INFO_LIST_SENDER_NAME', '������� ��� ����������� ���������. ��� ��� ����� ������ ���� ���������� � ����� "�� ����".');
define('_ACA_INFO_LIST_SENDER_EMAIL', '������� ����������� �����, � �������� ����� ������������ ���������.');
define('_ACA_INFO_LIST_SENDER_BOUNCED', '������� ����������� ����� ��� ������� �����������. ������������ ������������� ��������� ��� �� �����, ��� � � ������ ��������, ��� ��� ����� ������ ����� �������� ����� ����-������� �������� ������.');
define('_ACA_INFO_LIST_AUTORESP', '�������� ��� �������� ��� ������� ������. <br />' .
		'��������� ��������: ������� ��������� ��������<br />' .
		'������������: ������������ ��� ����, ������� ����������� ������������� ����� ���-���� ����� �������� ���������� �������.');
define('_ACA_INFO_LIST_FREQUENCY', '��������� ������������� ��������, ��������� ����� ��� ����� �������� ������. ��� �������� ����� ������ � ������� ��� �������������.');
define('_ACA_INFO_LIST_TIME', '��������� ������������� �������� ����� ���, ���������������� ��� ��������� ��������.');
define('_ACA_INFO_LIST_MIN_DAY', '���������� ����������� ������������� ��������� ��������, ������� ����� ������� ������������.');
define('_ACA_INFO_LIST_DELAY', '������� �������� ����� ������� ����� ������������� � �����������.');
define('_ACA_INFO_LIST_DATE', '���������� ���� �������� (����������) ��������� ��������, ���� �� ������ �������� ����������.<br /> FORMAT : YYYY-MM-DD HH:MM:SS');
define('_ACA_INFO_LIST_MAX_DAY', '���������� ������������ ������������� ��������� ��������, ������� ����� ������� ������������.');
define('_ACA_INFO_LIST_LAYOUT', '������� ����� ������ ������ ��������. ����� �� ������ ������ ����� ����� ��� ����� ��������.');
define('_ACA_INFO_LIST_SUB_MESS', '��� ��������� ����� ���������� ������������, ������� ������� �����������������. �� ������ ������ ����� ����� ���� �����.');
define('_ACA_INFO_LIST_UNSUB_MESS', '��� ��������� ����� ���������� ������������, ������� ���������� ��������. �� ������ ������ ����� ����� ���� �����.');
define('_ACA_INFO_LIST_HTML', '�������� ��� �����, ���� �� ������ ��������� ��������� � ������� HTML. ������������ ����� �������� ����� HTML ��������� �������� � ������� �������, ����� ������������� �� HTML ��������.');
define('_ACA_INFO_LIST_HIDDEN', '������� ��, ����� ������ �������� � ���������. ������������ �� ������ ����������� �� ��������, �� �� ��-�������� ������� ���������� ��������� ��� �������������.');
define('_ACA_INFO_LIST_ACA_AUTO_SUB', '�� ������, ����� ������������ ������������� ����������� � ���� ������?<br /><B>����� ������������:</B> ����� ���������������� ��� ����� ������������, ������������������ �� ����� .<br /><B>��� ������������:</B> ����� ���������������� ��� ������������, ������������ � ���� ������.<br />(����� �������� ��� ������������ Community Builder)');
define('_ACA_INFO_LIST_ACC_LEVEL', '�������� ������� ������� � ���������. ��� ��������� ���������� ��� �������� �������� �� �������������, ������� �� ������ ����� ������� � ���� ���������, �� ���� ��� �� ������ ����������� �� ��� ��������.');
define('_ACA_INFO_LIST_ACC_USER_ID', '�������� ������� ������� ��� ����� �������������, ������� ��������� ��������������. ��� ������ � ������ � ����� �������� �������� ������� ������ ������������� �������� � ������������ ��������, ��� � ���������, ��� � �� ������ ��������������.');
define('_ACA_INFO_LIST_FOLLOW_UP', '���� �� ������, ����� ������������ ������� �������� �������, ����� ���� ��� ������ �� ���������� ���������, ���������� ����� �����������.');
define('_ACA_INFO_LIST_ACA_OWNER', '��� ID ������������, ���������� ������.');
define('_ACA_INFO_LIST_WARNING', '   ��� ��������� ����� �������� ������ ��� �������� ������.');
define('_ACA_INFO_LIST_SUBJET', ' ���� ��������.  ��� ���� ������, ������� ����� ������ ���������.');
define('_ACA_INFO_MAILING_CONTENT', '��� ���������� ������, ������� �� ������ ���������.');
define('_ACA_INFO_MAILING_NOHTML', '������� ����� ���������� ������, ������� �� ������ ��������� ����������� �������� �������� ������ HTML ��������. <BR/> ���������: ���� �� �������� ��� ����� ������, �� Acajoom ������������� ����������� HTML ����� � ������� �����.');
define('_ACA_INFO_MAILING_VISIBLE', '������� ��, ����� ���������� �������� �� ���������.');
define('_ACA_INSERT_CONTENT', '�������� ������������ �������');

// ������
define('_ACA_SEND_COUPON_SUCCESS', '����� ������� ���������!');
define('_ACA_CHOOSE_COUPON', '�������� �����');
define('_ACA_TO_USER', ' ����� ������������');

### ����� ����� (����� �� Unix, ����������� ������������ ������� � ������ ����������� ��� � ����, ��������� � ����������� �����)
//������� ������� �������� �����
define('_ACA_FREQ_CH1', '������ ���');
define('_ACA_FREQ_CH2', '������ 6 �����');
define('_ACA_FREQ_CH3', '������ 12 �����');
define('_ACA_FREQ_CH4', '���������');
define('_ACA_FREQ_CH5', '�����������');
define('_ACA_FREQ_CH6', '����������');
define('_ACA_FREQ_NONE', '���');
define('_ACA_FREQ_NEW', '����� ������������');
define('_ACA_FREQ_ALL', '��� ������������');

//������� ��� ����� �����
define('_ACA_LABEL_FREQ', 'Acajoom ����?');
define('_ACA_LABEL_FREQ_TIPS', '������� ��, ���� �� ������ ������������ ��� ��� ����� Acajoom, ��� ��� ������ ������� ���� �������.<br />' .
		'���� �������� ��, ��� �� ����� ����� �������� ����� �����, �� ����� ������������� ��������.');
define('_ACA_SITE_URL' , 'URL ������ �����');
define('_ACA_CRON_FREQUENCY' , '������� ������� �����');
define('_ACA_STARTDATE_FREQ' , '���� ������');
define('_ACA_LABELDATE_FREQ' , '�������� ����');
define('_ACA_LABELTIME_FREQ' , '�������� �����');
define('_ACA_CRON_URL', '���� URL');
define('_ACA_CRON_FREQ', '�������');
define('_ACA_TITLE_CRONLIST', '������ ����� �����');
define('_NEW_LIST', '������� ����� ������');

//��������� ����� �����
define('_ACA_TITLE_FREQ', '�������� �����');
define('_ACA_CRON_SITE_URL', '����������, ������� ���������� ������, ������������ � http://');

### �������� ###
define('_ACA_MAILING_ALL', '��� ��������');
define('_ACA_EDIT_A', '�������������... ');
define('_ACA_SELCT_MAILING', '����������, �������� ������ � ���������� ����, ����� �������� ����� ��������.');
define('_ACA_VISIBLE_FRONT', '����� �� ���������');

// ����������
define('_ACA_SUBJECT', '����');
define('_ACA_CONTENT', '����������');
define('_ACA_NAMEREP', '[NAME] = ��� ����� �������� �� ��� ��������� �����������, ��� ������������� �����, �� ������ ��������� ������, ���������� ��������������� �� ��� ����������.<br />');
define('_ACA_FIRST_NAME_REP', '[FIRSTNAME] = ��� ����� �������� �� ��� (���, ��������� ������) ����������.<br />');
define('_ACA_NONHTML', '�� html ������');
define('_ACA_ATTACHMENTS', '������������� ������');
define('_ACA_SELECT_MULTIPLE', '����������� ctrl, ����� ������� ����� ��������� ���������.<br />' .
		'�����, ���������� � ������ ������������� ������ ����������� � ����� ������������� ������, �� ������ �������� �� ��������������� � ������ ������������.');
define('_ACA_CONTENT_ITEM', '����� ��������');
define('_ACA_SENDING_EMAIL', '���� ��������');
define('_ACA_MESSAGE_NOT', '��������� �� ����� ���� ��������');
define('_ACA_MAILER_ERROR', '������ ��������');
define('_ACA_MESSAGE_SENT_SUCCESSFULLY', '��������� ���� ������� ����������');
define('_ACA_SENDING_TOOK', '�������� ������ �������� ������');
define('_ACA_SECONDS', '���.');
define('_ACA_NO_ADDRESS_ENTERED', '�� �������� �� ������ ������ ���������� ��� �������');
define('_ACA_CHANGE_SUBSCRIPTIONS', '��������');
define('_ACA_CHANGE_EMAIL_SUBSCRIPTION', '��������� ����� ��������');
define('_ACA_WHICH_EMAIL_TEST', '�������� e-mail, ����� ��������� �� ���� �������� ���������, ��� ������� ������������');
define('_ACA_SEND_IN_HTML', '��������� � HTML  ������� (��� html ��������)?');
define('_ACA_VISIBLE', '�������');
define('_ACA_INTRO_ONLY', '������ ����������');

// ����������
define('_ACA_GLOBALSTATS', '���������� ����������');
define('_ACA_DETAILED_STATS', '���������������� ����������');
define('_ACA_MAILING_LIST_DETAILS', '������ ������ ��������');
define('_ACA_SEND_IN_HTML_FORMAT', '���������� � HTML �������');
define('_ACA_VIEWS_FROM_HTML', '��������� (�� ���������, ������������ � ������� html)');
define('_ACA_SEND_IN_TEXT_FORMAT', '��������� � ��������� �������');
define('_ACA_HTML_READ', 'HTML ���������');
define('_ACA_HTML_UNREAD', 'HTML �� ���������');
define('_ACA_TEXT_ONLY_SENT', '������ �����');

// ������ ����������������
// ��������
define('_ACA_MAIL_CONFIG', '�����');
define('_ACA_LOGGING_CONFIG', '���� � ����������');
define('_ACA_SUBSCRIBER_CONFIG', '����������');
define('_ACA_MISC_CONFIG', '������');
define('_ACA_MAIL_SETTINGS', '��������� �����');
define('_ACA_MAILINGS_SETTINGS', '��������� ��������');
define('_ACA_SUBCRIBERS_SETTINGS', '��������� �����������');
define('_ACA_CRON_SETTINGS', '��������� �����');
define('_ACA_SENDING_SETTINGS', '��������� ��������');
define('_ACA_STATS_SETTINGS', '��������� ����������');
define('_ACA_LOGS_SETTINGS', '��������� �����');
define('_ACA_MISC_SETTINGS', '������ ���������');
// mail settings
define('_ACA_SEND_MAIL_FROM', '����� �����������');
define('_ACA_SEND_MAIL_NAME', '��� �����������');
define('_ACA_MAILSENDMETHOD', '����� ��������');
define('_ACA_SENDMAILPATH', '���� � ����� "����������"');
define('_ACA_SMTPHOST', 'SMTP ������');
define('_ACA_SMTPAUTHREQUIRED', '��������� �������������� ��� SMTP');
define('_ACA_SMTPAUTHREQUIRED_TIPS', '�������� ��, ���� ��� SMTP ������� ��������������');
define('_ACA_SMTPUSERNAME', 'SMTP �����');
define('_ACA_SMTPUSERNAME_TIPS', '������� SMTP �����, ���� ��� SMTP ������� ��������������');
define('_ACA_SMTPPASSWORD', 'SMTP ������');
define('_ACA_SMTPPASSWORD_TIPS', '������� SMTP ������, ���� ��� SMTP ������� ��������������');
define('_ACA_USE_EMBEDDED', '������������ ����������� �����������');
define('_ACA_USE_EMBEDDED_TIPS', '�������� "��", ���� �������� � ������������� ��������� ������ ���� ������� � ������ ��� html ���������, ��� "���", ����� ������������ ������� ���� ��������, ����������� �� �������� �� ���-�������.');
define('_ACA_UPLOAD_PATH', '���� � ����� ��������/��������');
define('_ACA_UPLOAD_PATH_TIPS', '�� ������ ������ ���������� ��� �������� ������ �� ������<br />' .
		'���������, ��� ����������, ������� �� ������� ����������, ���� � ���, �� �������� ��.');

// ��������� �����������
define('_ACA_ALLOW_UNREG', '��������� ��������������������');
define('_ACA_ALLOW_UNREG_TIPS', '�������� "��", ���� �� ������ ��������� ������������� ������������� �� �������� ��� ����������� �� �����.');
define('_ACA_REQ_CONFIRM', '��������� ������-�������������');
define('_ACA_REQ_CONFIRM_TIPS', '�������� "��", ���� �������� �� ���������������������� ������������� ������������� �� ����������� �����.');
define('_ACA_SUB_SETTINGS', '��������� ����������');
define('_ACA_SUBMESSAGE', '����� ��� ��������');
define('_ACA_SUBSCRIBE_LIST', '����������� �� ��������');

define('_ACA_USABLE_TAGS', '�������� ����');
define('_ACA_NAME_AND_CONFIRM', '<b>[CONFIRM]</b> = ������� ������������ ������, ������ �� ������� ������������ ����� ����������� ��������. ��� ����� <strong>����������</strong>, ����� Acajoom ������� ���������.<br />'
.'<br />[NAME] = ��� ����� �������� �� ��� ��������� �����������, ��� ������������� �����, �� ������ ��������� ������, ���������� ��������������� �� ��� ����������.<br />'
.'<br />[FIRSTNAME] = ��� ����� �������� ������ ����������, �� ��� ���������� ����������� ������ �� ��������� ����.<br />');
define('_ACA_CONFIRMFROMNAME', '�������������, ��:');
define('_ACA_CONFIRMFROMNAME_TIPS', '������� ��� ����������� ��� ������ � ���������� ������������� ��������.');
define('_ACA_CONFIRMFROMEMAIL', '�������������, � ������:');
define('_ACA_CONFIRMFROMEMAIL_TIPS', '������� ����� ��� ������ � ���������� ������������� ��������.');
define('_ACA_CONFIRMBOUNCE', 'E-mail ����� ��� ����������� � �������������� �������');
define('_ACA_CONFIRMBOUNCE_TIPS', '������� �����, ������� ����� ������������ � ���������� ������������� ��������, � �� ������� �� ������ ��, ����� ��������� ��������� � �������������� e-mail ������� �����������.');
define('_ACA_HTML_CONFIRM', 'HTML �������������');
define('_ACA_HTML_CONFIRM_TIPS', '�������� "��", ���� �� ������ ���������� ��������� ������������� � ������� HTML (���� ������������ �������� ��������� ��� ����� ������).');
define('_ACA_TIME_ZONE_ASK', '���������� ������� ����');
define('_ACA_TIME_ZONE_TIPS', '�������� "��", ���� ������ ����������� ���� �������� �����. ��������, ����������� � ������� ����� ����������� ��������� ��� ��������.');

 // ��������� �����
 define('_ACA_AUTO_CONFIG', '����');
define('_ACA_TIME_OFFSET_URL', '������� �����, ����� ���������� ����������� � ������ ���������� ������������ - ������');
define('_ACA_TIME_OFFSET_TIPS', '���������� ��������� �������� �������, ������� ����� ������� � ������ ���� � �����');
define('_ACA_TIME_OFFSET', '����� �������');
define('_ACA_CRON_DESC','<br />��������� ������� ����, �� ������ ���������� �������������� ������, ������� ����� ����������� �� ����������, ��� ������ �����!<br />' .
		'����� ��������� ���, ��� ����� �������� �� ������ ���������� � ������ �� ���������� ��������� �������:<br />' .
		'<b>' . ACA_JPATH_LIVE . '/index2.php?option=com_acajoom&act=cron</b> ' .
		'<br /><br />���� ��� ����������� ������, �� �������� � ����� �� ������ ������������� <a href="http://www.ijoobi.com" target="_blank">http://www.ijoobi.com</a>');

// ��������� ��������
define('_ACA_PAUSEX', '����� x ������ ����� ������� ������������������� � ��������� ���������� �����');
define('_ACA_PAUSEX_TIPS', '������� ����� � ��������, ������� Acajoom ����� ������ ������ SMTP ������� � �������� ����� ����� ���������� ��������� ������������������� ���������� �����.');
define('_ACA_EMAIL_BET_PAUSE', '������ ����� �������');
define('_ACA_EMAIL_BET_PAUSE_TIPS', '���������� ����� ��� �������� �� �����.');
define('_ACA_WAIT_USER_PAUSE', '����� ����� ������������� ������� ��� �����');
define('_ACA_WAIT_USER_PAUSE_TIPS', '������ �� ������ ��� ����� ������� ����� ������������� ������� ��� �������� ���������� ������ �����.');
define('_ACA_SCRIPT_TIMEOUT', '����� �������');
define('_ACA_SCRIPT_TIMEOUT_TIPS', '���������� �����, ������� ������ ����� ������� (0 ��� ������ �����������).');
// ��������� ����������
define('_ACA_ENABLE_READ_STATS', '��������� ����� ����������');
define('_ACA_ENABLE_READ_STATS_TIPS', '�������� ��, ���� �� ������ ��������� ���������� ����������. ������ ���������� ����� ������� ������ ��� ����� � ������� HTML');
define('_ACA_LOG_VIEWSPERSUB', '���������� ��������� ������������');
define('_ACA_LOG_VIEWSPERSUB_TIPS', '�������� ��, ���� �� ������ ��������� ���������� ���������� �������� �������� ��������� �����������. ������ ���������� ����� ������� ������ ��� ����� � ������� HTML');
// ��������� �����
define('_ACA_DETAILED', '��������� ����');
define('_ACA_SIMPLE', '���������� ����');
define('_ACA_DIAPLAY_LOG', '���������� ����');
define('_ACA_DISPLAY_LOG_TIPS', '�������� "��", ���� ������ ���������� ���� � ������ �������� �����.');
define('_ACA_SEND_PERF_DATA', '�������� ����������');
define('_ACA_SEND_PERF_DATA_TIPS', '�������� "��", ���� �� ������ ���������, ����� Acajoom ������� ��������� �������� � ������������, ���������� ����������� � �������, ������� �������� �������� ���������. ��� ���� ������������� ���� �� ��������� ������ ���������� � ������� �������������� ��� � ������� �������.');
define('_ACA_SEND_AUTO_LOG', '���������� ���� ��� ��������������');
define('_ACA_SEND_AUTO_LOG_TIPS', '�������� ��, ���� �� ������, ����� ��������� ���������� ��� ��������� ������ ���, ����� ��������� ������. ��������������: ��� ����� �������� � �������� ���������� ��������� � ����� �������� �����.');
define('_ACA_SEND_LOG', '���������� ���');
define('_ACA_SEND_LOG_TIPS', '������ �� ���� ��� �������� �������� ���� ��������� �� �������� ����� ������������, ������� �������� ��������.');
define('_ACA_SEND_LOGDETAIL', '���������� ��������� ����');
define('_ACA_SEND_LOGDETAIL_TIPS', '��������� ���� �������� � ���� ���������� �� �������� ��� ��������� �������� ��������� ������� ���������� � ����� ���������� (����������). ���������� �������� ������ �����.');
define('_ACA_SEND_LOGCLOSED', '���������� ���, ���� ���������� �������');
define('_ACA_SEND_LOGCLOSED_TIPS', '� ���� ���������� ������ ������������, ������������ ��������, ������� ����� � �������� �� ����������� �����.');
define('_ACA_SAVE_LOG', '��������� ���');
define('_ACA_SAVE_LOG_TIPS', '������ �� ��� �������� �������� ���� �������� � ����� ����');
define('_ACA_SAVE_LOGDETAIL', '��������� ��������� ���');
define('_ACA_SAVE_LOGDETAIL_TIPS', '��������� ���� �������� � ���� ���������� �� �������� ��� ��������� �������� ��������� ������� ���������� � ����� ���������� (����������). ���������� �������� ������ �����.');
define('_ACA_SAVE_LOGFILE', '��������� ���� ����');
define('_ACA_SAVE_LOGFILE_TIPS', '����, � ������� ������������ ���������� ����. ������� ���� ���� ����� ����� ����������� ������.');
define('_ACA_CLEAR_LOG', '�������� ���');
define('_ACA_CLEAR_LOG_TIPS', '�������� ���� ����.');

### ������ ����������
define('_ACA_CP_LAST_QUEUE', '��������� ������������ ������');
define('_ACA_CP_TOTAL', '�����');
define('_ACA_MAILING_COPY', '�������� ������� �����������!');

// ������������� ���������
define('_ACA_SHOW_GUIDE', '�������� �����������');
define('_ACA_SHOW_GUIDE_TIPS', '���������� ����������� ��� ������ ���������, ����� ������ ����� ������������� ������� ��������� ��������, ��������� ������������� � ��������� ��������� Acajoom.');
define('_ACA_AUTOS_ON', '������������ ��������������');
define('_ACA_AUTOS_ON_TIPS', '�������� ���, ���� �� �� ������ ������������ ��������������, � ����� ��������������� ����� ��������������.');
define('_ACA_NEWS_ON', '������������ ��������� ��������');
define('_ACA_NEWS_ON_TIPS', '�������� ���, ���� �� �� ������ ������������ ��������� ��������, � ��� �� ����� ����� ��������������.');
define('_ACA_SHOW_TIPS', '���������� ������');
define('_ACA_SHOW_TIPS_TIPS', '�������� ������, ����� ������ ������������� ������������ Acajoom ����� ����������.');
define('_ACA_SHOW_FOOTER', '���������� ����� (footer)');
define('_ACA_SHOW_FOOTER_TIPS', '������ �� ���� �������� ��������� �� ��������� ������.');
define('_ACA_SHOW_LISTS', '���������� ������ �� ���������');
define('_ACA_SHOW_LISTS_TIPS', '���������� �������������������� ������������� ������ ��������, �� ������� ��� ����� ����������� � ������� �������� � ����� ��������, ��� �� ������ ����� �����������, ����� ��� ����� ������������������.');
define('_ACA_CONFIG_UPDATED', '������������ ���� ������� ���������!');
define('_ACA_UPDATE_URL', 'URL ��� ����������');
define('_ACA_UPDATE_URL_WARNING', '��������! �� ��������� ���� URL, ����� �������, ����� ��� �� ���� ������ ����������� ������� Acajoom.<br />');
define('_ACA_UPDATE_URL_TIPS', '������: http://www.ijoobi.com/update/ (������� ����������� ����)');

// ������
define('_ACA_EMAIL_INVALID', '��������� e-mail �����������.');
define('_ACA_REGISTER_REQUIRED', '����������, ����������������� �� ����� ����� ���, ��� �� ����������� �� ��������.');

// ���� ������� �������
define('_ACA_OWNER', '��������� ��������:');
define('_ACA_ACCESS_LEVEL', '���������� ������� ������� � ��������');
define('_ACA_ACCESS_LEVEL_OPTION', '����� �������');
define('_ACA_USER_LEVEL_EDIT', '��������, ����� ������ ������������� ������ ������������� �������� �� ����� ������ (��� � ���������, ��� � � �������)');

//  ���������� �����
define('_ACA_AUTO_DAY_CH1', '���������');
define('_ACA_AUTO_DAY_CH2', '���������, ����� ��������');
define('_ACA_AUTO_DAY_CH3', '�� ���� ������');
define('_ACA_AUTO_DAY_CH4', '�� ���� ������, ����� ����������');
define('_ACA_AUTO_DAY_CH5', '�����������');
define('_ACA_AUTO_DAY_CH6', '��� � ��� ������');
define('_ACA_AUTO_DAY_CH7', '����������');
define('_ACA_AUTO_DAY_CH9', '��������');
define('_ACA_AUTO_OPTION_NONE', '���');
define('_ACA_AUTO_OPTION_NEW', '����� ����������');
define('_ACA_AUTO_OPTION_ALL', '��� ����������');

//
define('_ACA_UNSUB_MESSAGE', '������ �� ������������� ��������');
define('_ACA_UNSUB_SETTINGS', '��������� ������������� ��������');
define('_ACA_AUTO_ADD_NEW_USERS', '������������ �������������?');

// Update and upgrade messages
define('_ACA_NO_UPDATES', '��� ��������� ����������.');
define('_ACA_VERSION', '������ Acajoom');
define('_ACA_NEED_UPDATED', '�����, ������� ���������� �������� �� �����:');
define('_ACA_NEED_ADDED', '�����, ������� ���������� ��������:');
define('_ACA_NEED_REMOVED', '�����, ������� ���������� �������:');
define('_ACA_FILENAME', '��� �����:');
define('_ACA_CURRENT_VERSION', '������� ������:');
define('_ACA_NEWEST_VERSION', '��������� ������:');
define('_ACA_UPDATING', '���� ����������');
define('_ACA_UPDATE_UPDATED_SUCCESSFULLY', '����� ���� ������� ���������.');
define('_ACA_UPDATE_FAILED', '�� ������� ��������!');
define('_ACA_ADDING', '���� ����������');
define('_ACA_ADDED_SUCCESSFULLY', '���������� ������ �������.');
define('_ACA_ADDING_FAILED', '�� ������� ��������!');
define('_ACA_REMOVING', '���� ��������');
define('_ACA_REMOVED_SUCCESSFULLY', '�������� ������ �������.');
define('_ACA_REMOVING_FAILED', '�� ������� �������!');
define('_ACA_INSTALL_DIFFERENT_VERSION', '���������������� ������ ������');
define('_ACA_CONTENT_ADD', '�������� ����������');
define('_ACA_UPGRADE_FROM', '������ ���������� (�������� �������� � �����������) ��: ');
define('_ACA_UPGRADE_MESS', '��� �������� ����� �������� ���� ������������ ������. <br /> ���� ������� ������ ����������� ���������� � ���� ������ Acajoom.');
define('_ACA_CONTINUE_SENDING', '���������� ��������');

// ��������� Acajoom
define('_ACA_UPGRADE1', '�� ������ ����� ������������� ����� ����������� � ��������� �� ');
define('_ACA_UPGRADE2', ' � Acajoom ����� ������ ����������.');
define('_ACA_UPDATE_MESSAGE', '�������� ����� ������ Acajoom! ');
define('_ACA_UPDATE_MESSAGE_LINK', '������� ����� ��� ����������!');
define('_ACA_THANKYOU', '������� ��� �� ������������� Acajoom, ������ ����������������� ��������!');
define('_ACA_NO_SERVER', '������ ���������� ����������, ����������, ���������� �������.');
define('_ACA_MOD_PUB', '������ Acajoom �� �����������.');
define('_ACA_MOD_PUB_LINK', '������� ����� ��� ��� ����������!');
define('_ACA_IMPORT_SUCCESS', '������� �������������');
define('_ACA_IMPORT_EXIST', '��������� ��� ���������� � ����');

// ������ Acajoom
define('_ACA_GUIDE', ' ������');
define('_ACA_GUIDE_FIRST_ACA_STEP', '<p>Acajoom ����� ����� �����, � ���� ������ �������� ��� � ������ ������� ���� � ����, ����� �� ������ ������ ���������� ���� �������� �������� � ������������ ����������������!<p />');
define('_ACA_GUIDE_FIRST_ACA_STEP_DESC', '��-������, ��� ����� ������� ������ ��������. ������ ����� ���� ���� �����, ��������� �������� ��� �������������.' .
		'  � ���������� ������ �� ������ ���������� ��������� ��������� ��� ����� ��������� �������� ��� ���������������: ��� �����������, �����, �������������� ��������� ����������� � ��� �����...
<br /><br />�� ������ ��������� ���� ������ ������ �������� �����: <a href="index2.php?option=com_acajoom&act=list">������� ����</a> � ������� ������ ����� (New).');
define('_ACA_GUIDE_FIRST_ACA_STEP_UPGRADE', 'Acajoom ������������� ��� ������ ������ ������������� ��� ���������� �� ����� ���������� ������� �������� ��������.<br />' .
		' �������� ������ ���������� � �������� ���� ���������� ������� �������� ��������, ����� ������������� �� ��� ��� ������� �������� � �����������.<br /><br />' .
		'<span style="color:#FF5E00;" >�����: ������ ��������� � �� ����� ��������� ��� ������� ���������� �� ����� ���������� �������</span><br />' .
		'����� �������������� �� ������� ��������� ������ ������������ � ���������� ��������������� � Acajoom.<br /><br />');
define('_ACA_GUIDE_SECOND_ACA_STEP', '�����������! ��� ������ ������ ������! ������ �� ������ ������� ���� ������ %s. ����� ������� ��, ��������: ');
define('_ACA_GUIDE_SECOND_ACA_STEP_AUTO', '���������� ����������������');
define('_ACA_GUIDE_SECOND_ACA_STEP_NEWS', '���������� ����������');
define('_ACA_GUIDE_SECOND_ACA_STEP_FINAL', ' � �������� ���� %s. <br /> ����� �������� ���� %s �� ����������� ����. �������� ���� ������ ������, ������� �� ����� (New) ');
define('_ACA_GUIDE_THRID_ACA_STEP_NEWS', '�� �������� ����� ������ ��������, ��������, ��� ������� ��������� �������� ���������  ' .
		'�������� �� ������ <a href="index2.php?option=com_acajoom&act=configuration" >������������</a>, ����� ��������� �������� ���������. <br />');
define('_ACA_GUIDE_THRID2_ACA_STEP_NEWS', '<br />����� �� ������ ������, ��������� � ���� �������� ��������, �������� ���� ������ � ������� ���������');
define('_ACA_GUIDE_THRID_ACA_STEP_AUTOS', '��� ����� ���������������, ��-������, ��� ����� ���������� ������ �� ���������� (����) �� ����� �������. ' .
		' ����������, �������� ������� ����� �� ���������� (�����) � ������ ������������.' .
		' <a href="index2.php?option=com_acajoom&act=configuration">������� �����</a> ����� ������ ������ �� ��������� ������ �� ���������� (������). <br />');
define('_ACA_GUIDE_MODULE', ' <br />����� �������������� � ���, ��� �� ������������ ������ Acajoom � ���������� ����� ����������� �� ��������.');
define('_ACA_GUIDE_FOUR_ACA_STEP_NEWS', ' ����� �� ������ ��������� �������������.');
define('_ACA_GUIDE_FOUR_ACA_STEP_AUTOS', ' ����� �� ������ ��������� �������� ��������.');
define('_ACA_GUIDE_FOUR_ACA_STEP', '<p><br />���-��! ������ �� ������ ���������� ����������������� � ������ ������������ � ��������������. ������ ����� ������� ����� ���������, ��� ������ �� ��������� ���� ������ ��������, ��� �� ������ ��������� ��� � <a href="index2.php?option=com_acajoom&act=configuration" >������ ������������</a>.' .
		'<br /><br />  ���� � ��� ��������� ������� ��� ������������� Acajoom, ����������, ����������� �� ' .
		'<a target="_blank" href="http://www.ijoobi.com/index.php?option=com_agora&Itemid=60" >�����</a>. ' .
		' ����� �� ������� ����� ���������� � ���, ��� ���������� ����������������� � ������ ������������, ����� <a href="http://www.ijoobi.com/" target="_blank" >www.ijoobi.com</a>.' .
		'<p /><br /><b>������� ��� �� ������������� Acajoom. ��� ���������������� �������!</b> ');
define('_ACA_GUIDE_TURNOFF', '������ ������ ��������!');
define('_ACA_STEP', '��� ');

// ��������� Acajoom
define('_ACA_INSTALL_CONFIG', '������������ Acajoom');
define('_ACA_INSTALL_SUCCESS', '��������� �������');
define('_ACA_INSTALL_ERROR', '������ ���������');
define('_ACA_INSTALL_BOT', '������ (���) Acajoom ');
define('_ACA_INSTALL_MODULE', '������ Acajoom');
//������
define('_ACA_JAVASCRIPT','!��������! Javascript ������ ���� ������� ��� ���������� ������.');
define('_ACA_EXPORT_TEXT','���������� �������������� �� ������ ���������� ���� ������.<br />������� ����������� �� ������');
define('_ACA_IMPORT_TIPS','������ �����������. ���������� � ������������� ����� ������ ���� � ��������� �������: <br />' .
		'���,email,��������HTML(1/0),<span style="color: rgb(255, 0, 0);">�����������(1/0)</span>');
define('_ACA_SUBCRIBER_EXIT', '��� �������� �����������');
define('_ACA_GET_STARTED', '������� �����, ����� ������!');

//�����, ������� � 1.0.1
define('_ACA_WARNING_1011','��������������: 1011: ���������� �� ����� �������� ��-�� ����������� �� ����� �������.');
define('_ACA_SEND_MAIL_FROM_TIPS', '��������, ����� email ����� ����� ������������ ��� ����� �����������.');
define('_ACA_SEND_MAIL_NAME_TIPS', '��������, ����� ��� ����� ������������ ��� ��� �����������.');
define('_ACA_MAILSENDMETHOD_TIPS', '�������� ����� �������� �����: �������� ������� PHP<span>Sendmail</span> ��� SMTP ������.');
define('_ACA_SENDMAILPATH_TIPS', '��� ���������� ��������� �������');
define('_ACA_LIST_T_TEMPLATE', '������');
define('_ACA_NO_MAILING_ENTERED', '�� ������� ��������');
define('_ACA_NO_LIST_ENTERED', '�� ������ ������');
define('_ACA_SENT_MAILING' , '������������ ��������');
define('_ACA_SELECT_FILE', '�������� ���� ��� ');
define('_ACA_LIST_IMPORT', '�������� ������, � �������� �� ������ �� ���������������� ����� �����������');
define('_ACA_PB_QUEUE', '��������� ��������, �� �������� �������� ��� ��������� ��� � ������(-��). ����������, ��������� �������.');
define('_ACA_UPDATE_MESS' , '');
define('_ACA_UPDATE_MESS1' , '������������ ������������� ��������!');
define('_ACA_UPDATE_MESS2' , '����� � ��������� �������.');
define('_ACA_UPDATE_MESS3' , '����� �����.');
define('_ACA_UPDATE_MESS5' , 'Joomla 1.5 ���������� ��� ����������.');
define('_ACA_UPDATE_IS_AVAIL' , ' ��������!');
define('_ACA_NO_MAILING_SENT', '��� ������������ ��������!');
define('_ACA_SHOW_LOGIN', '���������� ����� ������');
define('_ACA_SHOW_LOGIN_TIPS', '�������� ��, ����� ���������� ����� ����������� �� ��������� ������ ���������� Acajoom, ����� ������������ ��� ������������������ �� �����.');
define('_ACA_LISTS_EDITOR', '�������� �������� ������');
define('_ACA_LISTS_EDITOR_TIPS', '�������� ��, ����� ������������ HTML-�������� ��� �������������� ���� �������� ������.');
define('_ACA_SUBCRIBERS_VIEW', '�������� �����������');

//�����, ������� � 1.0.2
define('_ACA_FRONTEND_SETTINGS' , '��������� ���������' );
define('_ACA_SHOW_LOGOUT', '���������� ������ ������');
define('_ACA_SHOW_LOGOUT_TIPS', '�������� ��, ����� ���������� ������ ������ �� ��������� ������ ���������� Acajoom.');

//�����, ������� � 1.0.3, CB ����������

define('_ACA_CONFIG_INTEGRATION', '����������');
define('_ACA_CB_INTEGRATION', '���������� � Community Builder');
define('_ACA_INSTALL_PLUGIN', '������ ��� Community Builder (���������� � Acajoom) ');
define('_ACA_CB_PLUGIN_NOT_INSTALLED', '������ Acajoom ��� Community Builder ��� �� ����������!');
define('_ACA_CB_PLUGIN', '������ ��� �����������');
define('_ACA_CB_PLUGIN_TIPS', '�������� ��, ����� ���������� �������� ������� � ����� ����������� Community Builder');
define('_ACA_CB_LISTS', '�������������� �������');
define('_ACA_CB_LISTS_TIPS', '��� ���� ����������� ��� ����������. ������� ����� ������� ������ id �������, ������� ������ ������ ������������ ��� ����������� ��� �������� �� ���,  (��� ��������� ���� � 0 ����� �������� ��� ������)');
define('_ACA_CB_INTRO', '����� �����������');
define('_ACA_CB_INTRO_TIPS', '�����, ������� �������� �� ������� ��������� ��������. �������� ������, ���� ������ �� ������ ����������. �� ������ ������������ ���� HTML ��� ��������� �������� ���� ������.');
define('_ACA_CB_SHOW_NAME', '���������� �������� ������');
define('_ACA_CB_SHOW_NAME_TIPS', '��������, ���������� ��� ��� �������� ������(��) ����� �����������.');
define('_ACA_CB_LIST_DEFAULT', '������ ������ �� ���������?');
define('_ACA_CB_LIST_DEFAULT_TIPS', '��������, ������ �� ������� ��� ���� ������� ��� ������� ������ �� ���������.');
define('_ACA_CB_HTML_SHOW', '���������� "�������� HTML"');
define('_ACA_CB_HTML_SHOW_TIPS', '���������� "��", ����� ��������� ������������� ��������, ����� �� ��� �������� �������� � ������� HTML. ���������� ���, ����� ���������� �������� HTML �� ���������.');
define('_ACA_CB_HTML_DEFAULT', '�������� HTML �� ���������');
define('_ACA_CB_HTML_DEFAULT_TIPS', '�������� ��� �����, ����� ���������� "��������� HTML" �������������� �� ���������. ���� ���������� "�������� HTML" ����������� � ���, ����� ��� ����� ����� �������� �� ���������.');

// �����, ������� � 1.0.4
define('_ACA_BACKUP_FAILED', '�� ������� ������� ����� �����! ���� �� �������.');
define('_ACA_BACKUP_YOUR_FILES', '������ ������ ������ ���� ��������� � �����:');
define('_ACA_SERVER_LOCAL_TIME', '��������� ����� �������');
define('_ACA_SHOW_ARCHIVE', '���������� ������ �����');
define('_ACA_SHOW_ARCHIVE_TIPS', '�������� ��, ����� ���������� ������ ����� �� ��������� ������� ��������');
define('_ACA_LIST_OPT_TAG', '����');
define('_ACA_LIST_OPT_IMG', '�����������');
define('_ACA_LIST_OPT_CTT', '�������');
define('_ACA_INPUT_NAME_TIPS', '������� ��� � ������� (��� ������, ����������)');
define('_ACA_INPUT_EMAIL_TIPS', '������� ��� email ����� (�������, ����������, ������������ � ���������� �����)');
define('_ACA_RECEIVE_HTML_TIPS', '�������� ��, ���� �� ������ �� �������� �������� � ������� HTML (��� ����� ������������ ���� ������ �������, �� ���� ������ ����� ������� ���������) ��� ���, ����� �������� �������� ������ � ��������� �������');
define('_ACA_TIME_ZONE_ASK_TIPS', '�������� ��� ������� ����.');

// �����, ������� � 1.0.5
define('_ACA_FILES' , '�����');
define('_ACA_FILES_UPLOAD' , '��������');
define('_ACA_MENU_UPLOAD_IMG' , '�������� ��������');
define('_ACA_TOO_LARGE' , '������ ����� ��������� ����������. ������������ ����������� ������ �����');
define('_ACA_MISSING_DIR' , '���������� ���������� �� ����������');
define('_ACA_IS_NOT_DIR' , '���������� ���������� �� ���������� ��� �������� ������.');
define('_ACA_NO_WRITE_PERMS' , '���������� ���������� �� ����� ���� ������.');
define('_ACA_NO_USER_FILE' , '�� �� ������� �� ������ ����� ��� ��������.');
define('_ACA_E_FAIL_MOVE' , '���������� ����������� ����.');
define('_ACA_FILE_EXISTS' , '����� ���� ��� ���������� �� �������.');
define('_ACA_CANNOT_OVERWRITE' , '����� ���� ��� ���������� � �� ����� ���� �����������.');
define('_ACA_NOT_ALLOWED_EXTENSION' , '���������� ����� �� ������ � ������ �����������');
define('_ACA_PARTIAL' , '���� �������� ���� ��������.');
define('_ACA_UPLOAD_ERROR' , '������ ��������:');
define('DEV_NO_DEF_FILE' , '���� ��� �������� ���� ��������.');

// ��� ����������, �� �������: �������� <br/> � ������ ������ � ������ ��� [SUBSCRIPTIONS]
define('_ACA_CONTENTREP', '[SUBSCRIPTIONS] = ��� ����� �������� ������� �� ��������.' .
		' ��� <strong>���������</strong> , ����� Acajoom ������� ���������.<br />' .
		'���� �� ����������� ����� ������ ������� � ���� ����, ��� ����� ������������ �� ���� �������, ������������ ����� ������.' .
		' <br />�������� ��� ����� ��� ��������������� ������ ��� �������� � �����. Acajoom ������������� ������� ����� ��� ����������� �� ��������� �� ���������� � ������������� ��������.');

// �����, ������� � 1.0.6
define('_ACA_NOTIFICATION', '�����������');  // ������ �� Email �����������
define('_ACA_NOTIFICATIONS', '�����������');
define('_ACA_USE_SEF', 'SEF � ���������');
define('_ACA_USE_SEF_TIPS', '������������� �������� ���. ���� �� ���-���� ������, ����� URL-�, ���������� � ���� ��������, ������������ SEF, ����� ��������� ��.' .
		' <br /><b>������ ����� �������� ��������� ��� ������ ��������. ��� �� ������ ���� �������, ��� ������������, ������� �� ����� � ������ ����� ��������, ������� � ��� �� ����, ���� ���� �� �������� ���� SEF ���������.</b> ');
define('_ACA_ERR_NB' , '������ #: ERR');
define('_ACA_ERR_SETTINGS', '��������� ������� �� �������');
define('_ACA_ERR_SEND' ,'���������� ����� �� �������');
define('_ACA_ERR_SEND_TIPS' ,'���� �� ������ ������ Acajoom ����� �����, ����������, �������� ��. ��� �������� ������� "��������� ����� �� ������� ������������", �� ���� ��� ���� �� �������� ���������� �� ������ � ������� ���������� ���� ;-) <br /> <b>������ ���������� �� ������������</b>.  �� ���� �� �����, � ����� ������ ��������� ����� ������. ������������ ������ ���������� �� Acajoom , ���������� PHP � �������� SQL . ');
define('_ACA_ERR_SHOW_TIPS' ,'�������� ��, ����� ���������� ����� ������ �� ������. ������������ ��� ����� ������� �������. ');
define('_ACA_ERR_SHOW' ,'���������� ������');
define('_ACA_LIST_SHOW_UNSUBCRIBE', '���������� ����� ������������� ��������');
define('_ACA_LIST_SHOW_UNSUBCRIBE_TIPS', '�������� �� ��� ������ ������ ������������� �������� ����� �����, ����� ���������� ������ �������� ������ �� ��������. <br /> ���  ��������� ����� � ������.');
define('_ACA_UPDATE_INSTALL', '<span style="color: rgb(255, 0, 0);">������ ���������!</span> <br />���� �� ������������ � ���������� ������ Acajoom, ��� ������� �������� ��������� ���� ������, ������� �� ���� ������ (���� ���������� ��������� � �������)');
define('_ACA_UPDATE_INSTALL_BTN' , '�������� ������� � ������������');
define('_ACA_MAILING_MAX_TIME', '������������ ����� �������' );
define('_ACA_MAILING_MAX_TIME_TIPS', '���������� ������������ ����� ��� ������� ��������� �����, ����������� �� �������. ������������� ������������� ����� 30 ��������� � 2 ��������.');

// virtuemart ���������� beta
define('_ACA_VM_INTEGRATION', '���������� � VirtueMart ');
define('_ACA_VM_COUPON_NOTIF', 'ID ��������� � ������');
define('_ACA_VM_COUPON_NOTIF_TIPS', '���������� ID ������, ������� �� ������ ������������, ����� ��������� ������ ����� ��������.');
define('_ACA_VM_NEW_PRODUCT', 'ID ��������� � ����� ���������');
define('_ACA_VM_NEW_PRODUCT_TIPS', '���������� ID ������, ������� �� ������ ������������, ����� ��������� ��������� � ����� ��������� ����� ��������.');

// �����, ������� � 1.0.8
// ������� ����� ��� ��������
define('_ACA_FORM_BUTTON', '������� �����');
define('_ACA_FORM_COPY', 'HTML ���');
define('_ACA_FORM_COPY_TIPS', '���������� ��������������� HTML ��� �� ���� HTML ��������.');
define('_ACA_FORM_LIST_TIPS', '�������� ������, ������� �� ������ �������� � �����');
// �������� ���������
define('_ACA_UPDATE_MESS4' , '�� ����� ���� ��������� �������������');
define('_ACA_WARNG_REMOTE_FILE' , '��������� ���� ����������.');
define('_ACA_ERROR_FETCH' , '������ fetching �����.');

define('_ACA_CHECK' , '���������');
define('_ACA_MORE_INFO' , '���������');
define('_ACA_UPDATE_NEW' , '�������� �� ��������� ������');
define('_ACA_UPGRADE' , '�������� �� ����� ����� ������');
define('_ACA_DOWNDATE' , '������������ ������� ������');
define('_ACA_DOWNGRADE' , '������� � ������ ������');
define('_ACA_REQUIRE_JOOM' , '��������� Joomla');
define('_ACA_TRY_IT' , '������ ���!');
define('_ACA_NEWER', '����� �����');
define('_ACA_OLDER', '����� ������');
define('_ACA_CURRENT', '�������');

// �����, ������� � 1.0.9
define('_ACA_CHECK_COMP', '����������� ���� �� ������ �����������');
define('_ACA_MENU_VIDEO' , '����� �������');
define('_ACA_SCHEDULE_TITLE', '��������� �������������� ������� ������������');
define('_ACA_ISSUE_NB_TIPS' , '�������� �����, ������������� ��������������� ��������' );
define('_ACA_SEL_ALL' , '��� ��������');
define('_ACA_SEL_ALL_SUB' , '��� ������');
define('_ACA_INTRO_ONLY_TIPS' , '���� �� ������� ������ ���������� ������, � ������ ����� ��������� ������ "���������...", ������� �� ������ �������� ������ �� ����� �����.' );
define('_ACA_TAGS_TITLE' , '��� ������');
define('_ACA_TAGS_TITLE_TIPS' , '���������� � �������� ���� ��� � ������ � �� �����, � ������� ������.');
define('_ACA_PREVIEW_EMAIL_TEST', '������� email, �� ������� ����� �������� ������');
define('_ACA_PREVIEW_TITLE' , '��������');
define('_ACA_AUTO_UPDATE' , '����������� � ����� �������');
define('_ACA_AUTO_UPDATE_TIPS' , '�������� "��", ���� �� ������ ����� � ����� ������� ����������. <br />�����!! ��������� "���������� ������" ���������� ��� ������ ���� �������.');

// �����, ������� � 1.1.0
define('_ACA_LICENSE' , '������������ ����������');

// �����, ������� � 1.1.1
define('_ACA_NEW' , '�����');
define('_ACA_SCHEDULE_SETUP', '��� �������� � ������� ���������������, � ������������� ������ ���� ���������� �����������.');
define('_ACA_SCHEDULER', '�����������');
define('_ACA_ACAJOOM_CRON_DESC' , '���� � ��� ��� ������� � ������ ���������� ������� ������ �����, �� ������ ���������������� ���������� ������� ������ ����� Acajoom:' );
define('_ACA_CRON_DOCUMENTATION' , '�� ������ ����� �������������� ���������� �� ���������� ������������ Acajoom �� ���������� ������:');
define('_ACA_CRON_DOC_URL' , '<a href="http://www.ijoobi.com/index.php?option=com_content&Itemid=72&view=category&layout=blog&id=29&limit=60"
 target="_blank">http://www.ijoobi.com/index.php?option=com_content&Itemid=72&view=category&layout=blog&id=29&limit=60</a>' );
define( '_ACA_QUEUE_PROCESSED' , '������� ������� ���������...' );
define( '_ACA_ERROR_MOVING_UPLOAD' , '������ ����������� �������������� �����' );

//�����, ������� � 1.1.4
define( '_ACA_SCHEDULE_FREQUENCY' , '������� ������ ������������' );
define( '_ACA_CRON_MAX_FREQ' , '������������ ������� ������ ������������' );
define( '_ACA_CRON_MAX_FREQ_TIPS' , '���������� ������������ �������, � ������� ����������� ����� ����������� (� �������). �������� ������������ ������������, ���� ���� ������� ����� ����������� ����.' );
define( '_ACA_CRON_MAX_EMAIL' , '������������ ����� ����� �� ���' );
define( '_ACA_CRON_MAX_EMAIL_TIPS' , '���������� ������������ ���������� �����, ����������� �� ��� (0 - �������������).' );
define( '_ACA_CRON_MINUTES' , ' �����(-�)' );
define( '_ACA_SHOW_SIGNATURE' , '���������� ��� (footer) ������' );
define( '_ACA_SHOW_SIGNATURE_TIPS' , '������ �� �� ���������� ����� ������ ������ �� Acajoom.' );
define( '_ACA_QUEUE_AUTO_PROCESSED' , '������ �������������� ������ �������...' );
define( '_ACA_QUEUE_NEWS_PROCESSED' , '�������� �������� ������ �������...' );
define( '_ACA_MENU_SYNC_USERS' , '���������������� ������ ������������� � ���� ������' );
define( '_ACA_SYNC_USERS_SUCCESS' , '������������� ������ ������������� ������ �������!' );

// ������������� � Joomla 15
if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', '�����' );
if (!defined('_CMN_YES')) define( '_CMN_YES', '��' );
if (!defined('_CMN_NO')) define( '_CMN_NO', '���' );
if (!defined('_HI')) define( '_HI', '������' );
if (!defined('_CMN_TOP')) define( '_CMN_TOP', '�����' );
if (!defined('_CMN_BOTTOM')) define( '_CMN_BOTTOM', '����' );
//if (!defined('_BUTTON_LOGOUT')) define( '_BUTTON_LOGOUT', 'Logout' );

// For include title only or full article in content item tab in newsletter edit - p0stman911
define('_ACA_TITLE_ONLY_TIPS' , '���� �� ��������, �� � ������ ��������� ������ ��������� ������ � ���� ������ �� ������ �������� ������ �� ����� �����.');
define('_ACA_TITLE_ONLY' , '������ ���������');
define('_ACA_FULL_ARTICLE_TIPS' , '���� �� ��������, �� ������ ��������� ���������� � ������');
define('_ACA_FULL_ARTICLE' , '��� ������');
define('_ACA_CONTENT_ITEM_SELECT_T', '�������� ������, ������� �� ������ �������� � ������. <br />���������� � �������� <b>��� ������</b> � ���� ������.  �� ������ �������, � ����� ���� �� ���������: ���� �����, ������ ���������� ��� ������ ���������-������ (0, 1 ��� 2 ��������������). ');
define('_ACA_SUBSCRIBE_LIST2', '������(��) ��������');

// ������� ����� ��������
define('_ACA_AUTONEWS', '����� ��������');
define('_ACA_MENU_AUTONEWS', '����� ��������');
define('_ACA_AUTO_NEWS_OPTION', '��������� ����� ��������');
define('_ACA_AUTONEWS_FREQ', '������� ��������');
define('_ACA_AUTONEWS_FREQ_TIPS', '���������� �������, � ������� �� ������ ����������� ����� ��������.');
define('_ACA_AUTONEWS_SECTION', '������ ������');
define('_ACA_AUTONEWS_SECTION_TIPS', '���������� ������, �� �������� ����� ������� ������ ��� ��������.');
define('_ACA_AUTONEWS_CAT', '��������� ������');
define('_ACA_AUTONEWS_CAT_TIPS', '���������� ���������, �� ������� ����� ������� ������ ��� ��������. (��� �� ���� ��� ������ � ��������� �������).');
define('_ACA_SELECT_SECTION', '�������� ������');
define('_ACA_SELECT_CAT', '��� ���������');
define('_ACA_AUTO_DAY_CH8', 'Quaterly');
define('_ACA_AUTONEWS_STARTDATE', '���� ������');
define('_ACA_AUTONEWS_STARTDATE_TIPS', '���������� ����, � ������� �������� ������������� ����� ��������.');
define('_ACA_AUTONEWS_TYPE', '������������� ������');// ����� �� ������ ������, ����������� � ������
define('_ACA_AUTONEWS_TYPE_TIPS', '������ ������: ����� ��������� ��� ������ � ��������.<br />' .
		'������ ����������: ����� ��������� ������ ���������� ������ � ��������.<br/>' .
		'������ ���������: ����� ��������� ������ ��������� � ��������.');
define('_ACA_TAGS_AUTONEWS', '[SMARTNEWSLETTER] = ���� ��� ����� ������� ������� ���������.' );

//�����, ������� � 1.1.3
define('_ACA_MALING_EDIT_VIEW', '�������� / �������� �����');
define('_ACA_LICENSE_CONFIG' , '��������' );
define('_ACA_ENTER_LICENSE' , '������ ��������');
define('_ACA_ENTER_LICENSE_TIPS' , '������� ��� ����� �������� � ��������� ���.');
define('_ACA_LICENSE_SETTING' , '��������� ��������' );
define('_ACA_GOOD_LIC' , '���� �������� ���������!' );
define('_ACA_NOTSO_GOOD_LIC' , '���� �������� ���������: ' );
define('_ACA_PLEASE_LIC' , '����������, ��������� � Acajoom, ����� �������� ���� ��������� ( license@ijoobi.com ).' );
define('_ACA_DESC_PLUS', 'Acajoom Plus - ������ ��������� �������������� �������� ���  Joomla CMS.  ' . _ACA_FEATURES );
define('_ACA_DESC_PRO', 'Acajoom PRO - ����� ������ ��������� - ������� �������� ��� Joomla CMS.  ' . _ACA_FEATURES );

//�����, ������� � 1.1.4
define('_ACA_ENTER_TOKEN' , '������� ����� ������');
define('_ACA_ENTER_TOKEN_TIPS' , '������� ����� ������, ������� �� �������� ��� ������� Acajoom. ');
define('_ACA_ACAJOOM_SITE', '���� Acajoom:');
define('_ACA_MY_SITE', '��� ����:');
define( '_ACA_LICENSE_FORM' , ' ' .
 		'��������.</a>' );
define('_ACA_PLEASE_CLEAR_LICENSE' , '����������, �������� ���� ��������.<br />  ���� �������� ���������� ��������, ' );
define( '_ACA_LICENSE_SUPPORT' , '���� �� �� ��� ��� ����� �������, ' . _ACA_PLEASE_LIC );
define( '_ACA_LICENSE_TWO' , '�� ������ �������� ���� ������������ �����������, ����� ����� ������ � ����� ����� URL (������� ��������� ������� ������ ��������) � ������������ �����. '
			. _ACA_LICENSE_FORM . '<br /><br/>' . _ACA_LICENSE_SUPPORT );
define('_ACA_ENTER_TOKEN_PATIENCE', '����� ���������� ������ ������ �������� ������������� �������������. ' .
		' ������ ����� ������������ � ������� 2-� �����.  ������, � ��������� ������� �� ����� ���� ������� �� 15 �����.<br />' .
		'<br />��������� ������� � ������ ���������� ����� ��������� �����.  <br /><br />' .
		'���� �� �� �������� ������ ������������ ���� � ������� 15 �����, '. _ACA_LICENSE_TWO);
define( '_ACA_ENTER_NOT_YET' , '��� ����� ��� �� ������������.');
define( '_ACA_UPDATE_CLICK_HERE' , '����������, �������� <a href="http://www.ijoobi.com" target="_blank">www.ijoobi.com</a>, ����� ������� ��������� ������.');
define( '_ACA_NOTIF_UPDATE' , '����� �������� � ��������� �����������, ������� ���� ����������� ���� � ������� ����������� ');

define('_ACA_THINK_PLUS', '���� �� ������ �������� �� ����� ������� ��������, ��������� � Plus!');
define('_ACA_THINK_PLUS_1', '����������������');
define('_ACA_THINK_PLUS_2', '���������� �������� ����� �������� ��������������� �����');
define('_ACA_THINK_PLUS_3', '��� ����������� �� ������� �������');
define('_ACA_THINK_PLUS_4', '� ������ ������...');


//since 1.2.2
define( '_ACA_LIST_ACCESS', 'List Access' );
define( '_ACA_INFO_LIST_ACCESS', 'Specify what group of users can view and subscribe to this list' );
define( 'ACA_NO_LIST_PERM', 'You don\'t have enough permission to subscribe to this list' );

//Archive Configuration
 define('_ACA_MENU_TAB_ARCHIVE', 'Archive');
 define('_ACA_MENU_ARCHIVE_ALL', 'Archive All');

//Archive Lists
 define('_FREQ_OPT_0', 'None');
 define('_FREQ_OPT_1', 'Every Week');
 define('_FREQ_OPT_2', 'Every 2 Weeks');
 define('_FREQ_OPT_3', 'Every Month');
 define('_FREQ_OPT_4', 'Every Quarter');
 define('_FREQ_OPT_5', 'Every Year');
 define('_FREQ_OPT_6', 'Other');

define('_DATE_OPT_1', 'Created date');
define('_DATE_OPT_2', 'Modified date');

define('_ACA_ARCHIVE_TITLE', 'Setting up auto-archive frequency');
define('_ACA_FREQ_TITLE', 'Archive frequency');
define('_ACA_FREQ_TOOL', 'Define how often you want the Archive Manager to arhive your website content.');
define('_ACA_NB_DAYS', 'Number of days');
define('_ACA_NB_DAYS_TOOL', 'This is only for the Other option! Please specify the number of days between each Archive.');
define('_ACA_DATE_TITLE', 'Date type');
define('_ACA_DATE_TOOL', 'Define if the archived should be done on the created date or modified date.');

define('_ACA_MAINTENANCE_TAB', 'Maintenance settings');
define('_ACA_MAINTENANCE_FREQ', 'Maintenance frequency');
define( '_ACA_MAINTENANCE_FREQ_TIPS', 'Specify the frequency at which you want the maintenance routine to run.' );
define( '_ACA_CRON_DAYS' , 'hour(s)' );

define( '_ACA_LIST_NOT_AVAIL', 'There is no list available.');
define( '_ACA_LIST_ADD_TAB', 'Add/Edit' );

define( '_ACA_LIST_ACCESS_EDIT', 'Mailing Add/Edit Access' );
define( '_ACA_INFO_LIST_ACCESS_EDIT', 'Specify what group of users can add or edit a new mailing for this list' );
define( '_ACA_MAILING_NEW_FRONT', 'Createa New Mailing' );

define('_ACA_AUTO_ARCHIVE', 'Auto-Archive');
define('_ACA_MENU_ARCHIVE', 'Auto-Archive');

//Extra tags:
define('_ACA_TAGS_ISSUE_NB', '[ISSUENB] = This will be replaced by the issue number of  the newsletter.');
define('_ACA_TAGS_DATE', '[DATE] = This will be replaced by the sent date.');
define('_ACA_TAGS_CB', '[CBTAG:{field_name}] = This will be replaced by the value taken from the Community Builder field: eg. [CBTAG:firstname] ');
define( '_ACA_MAINTENANCE', 'Maintenance' );


define('_ACA_THINK_PRO', 'When you have professional needs, you use professional components!');
define('_ACA_THINK_PRO_1', 'Smart-Newsletters');
define('_ACA_THINK_PRO_2', 'Define access level for your list');
define('_ACA_THINK_PRO_3', 'Define who can edit/add mailings');
define('_ACA_THINK_PRO_4', 'More tags: add your CB fields');
define('_ACA_THINK_PRO_5', 'Joomla contents Auto-archive');
define('_ACA_THINK_PRO_6', 'Database optimization');

define('_ACA_LIC_NOT_YET', 'Your license is not yet valid.  Please check the license Tab in the configuration panel.');
define('_ACA_PLEASE_LIC_GREEN' , 'Make sure to provide the green information at the top of the tab to our support team.' );

define('_ACA_FOLLOW_LINK' , 'Get Your License');
define( '_ACA_FOLLOW_LINK_TWO' , 'You can get your license by entering the token number and site URL (which is highlighted in green at the top of this page) in the License form. ');
define( '_ACA_ENTER_TOKEN_TIPS2', ' Then click on Apply button in the top right menu.' );
define( '_ACA_ENTER_LIC_NB', 'Enter your License' );
define( '_ACA_UPGRADE_LICENSE', 'Upgrade Your License');
define( '_ACA_UPGRADE_LICENSE_TIPS' , 'If you received a token to upgrade your license please enter it here, click Apply and proceed to number <b>2</b> to get your new license number.' );

define( '_ACA_MAIL_FORMAT', 'Encoding format' );
define( '_ACA_MAIL_FORMAT_TIPS', 'What format do you want to use for encoding your mailings, Text only or MIME' );
define( '_ACA_ACAJOOM_CRON_DESC_ALT', 'If you do not have access to a cron task manager on your website, you can use the Free jCron component to create a cron task from your website.' );

//since 1.3.1
define('_ACA_SHOW_AUTHOR', 'Show Author\'s Name');
define('_ACA_SHOW_AUTHOR_TIPS', 'Select Yes if you want to add the name of the author when you add an article in the Mailing');

//since 1.3.5
define('_ACA_REGWARN_NAME','����������, ������� ���� ��������� ���.');
define('_ACA_REGWARN_MAIL','����������, ������� ��������� ����� e-mail.');

//since 1.5.6
define('_ACA_ADDEMAILREDLINK_TIPS','If you select Yes, the e-mail of the user will be added as a parameter at the end of your redirect URL (the redirect link for your module or for an external Acajoom form).<br/>That can be usefull if you want to execute a special script in your redirect page.');
define('_ACA_ADDEMAILREDLINK','Add e-mail to the redirect link');

//since 1.6.3
define('_ACA_ITEMID','ItemId');
define('_ACA_ITEMID_TIPS','This ItemId will be added to your Acajoom links.');

//since 1.6.5
define('_ACA_SHOW_JCALPRO','jCalPRO');
define('_ACA_SHOW_JCALPRO_TIPS','Show the integration tab for jCalPRO <br/>(only if jCalPRO is installed on your website!)');
define('_ACA_JCALTAGS_TITLE','jCalPRO Tag:');
define('_ACA_JCALTAGS_TITLE_TIPS','Copy and paste this tag into the mailing where you want to have the event to be placed.');
define('_ACA_JCALTAGS_DESC','Description:');
define('_ACA_JCALTAGS_DESC_TIPS','Select Yes if you want to insert the description of the event');
define('_ACA_JCALTAGS_START','Start date:');
define('_ACA_JCALTAGS_START_TIPS','Select Yes if you want to insert the start date of the event');
define('_ACA_JCALTAGS_READMORE','Read more:');
define('_ACA_JCALTAGS_READMORE_TIPS','Select Yes if you want to insert a <b>read more link</b> for this event');
define('_ACA_REDIRECTCONFIRMATION','Redirect URL');
define('_ACA_REDIRECTCONFIRMATION_TIPS','If you require a confirmation e-mail, the user will be confirmed and redirected to this URL if he clicks on the confirmation link.');

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
