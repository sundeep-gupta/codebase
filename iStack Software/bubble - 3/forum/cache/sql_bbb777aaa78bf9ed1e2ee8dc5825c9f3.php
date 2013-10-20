<?php

/* SELECT m.*, u.user_colour, g.group_colour, g.group_type FROM (bubb_moderator_cache m) LEFT JOIN bubb_users u ON (m.user_id = u.user_id) LEFT JOIN bubb_groups g ON (m.group_id = g.group_id) WHERE m.display_on_index = 1 AND m.forum_id = 2 */

$expired = (time() > 1234236820) ? true : false;
if ($expired) { return; }

$this->sql_rowset[$query_id] = array();

?>