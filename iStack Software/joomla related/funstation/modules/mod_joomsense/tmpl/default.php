<?php
/**
 * Display html for JoomSense
 * @version 1.0.0
 * @copyright (C) 2009 PHP Architecture. All rights reserved
 * @license   GNU/GPL, see http://www.gnu.org/licenses/gpl-2.0.html 
 * @link http://www.phparch.cn
 **/

// No direct access
defined('_JEXEC') or die('Restricted access');
?>
<div style="text-align: <?php echo $adAlign; ?>">
<script type="text/javascript">
<!--
    google_ad_client = "<?php echo $adClient; ?>";
    google_ad_slot = "<?php echo $adSlot; ?>";
    google_ad_width = <?php echo $adWidth; ?>;
    google_ad_height = <?php echo $adHeight; ?>;
//-->
</script>
<script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
</div>
