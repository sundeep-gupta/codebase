<?php

/* SELECT ban_ip, ban_userid, ban_email, ban_exclude, ban_give_reason, ban_end FROM bubb_banlist WHERE ban_email = '' AND (ban_userid = 1 OR ban_ip <> '') */

$expired = (time() > 1234236819) ? true : false;
if ($expired) { return; }

$this->sql_rowset[$query_id] = array();

?>