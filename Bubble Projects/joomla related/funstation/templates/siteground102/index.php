<?php
defined( '_VALID_MOS' ) or die( 'Direct Access to this location is not allowed.' );
// needed to seperate the ISO number from the language file constant _ISO
$iso = split( '=', _ISO );
// xml prolog
echo '<?xml version="1.0" encoding="'. $iso[1] .'"?' .'>';
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<?php
if ( $my->id ) {
	initEditor();
}
?>
<?php mosShowHead(); ?>
<meta http-equiv="Content-Type" content="text/html; <?php echo _ISO; ?>" />
<?php echo "<link rel=\"stylesheet\" href=\"$GLOBALS[mosConfig_live_site]/templates/$GLOBALS[cur_template]/css/template_css.css\" type=\"text/css\"/>" ; ?>
<!--[if lte IE 6]>
<?php echo "<link rel=\"stylesheet\" href=\"$GLOBALS[mosConfig_live_site]/templates/$GLOBALS[cur_template]/css/ie6.css\" type=\"text/css\"/>" ; ?>
<![endif]-->

<link rel="alternate" type="application/rss+xml" title="<?php echo $mosConfig_sitename?>" href="<?php echo $mosConfig_live_site;?>/index.php?option=com_rss&feed=RSS2.0&no_html=1" />
</head>

<body class="body_bg">
<div class="bg">
<div id="wrapper">
	<div id="header_3">
		<div id="header_2">
			<div id="header_1">
				<div id="header">
					<div id="logo">
						<h1><?php echo $GLOBALS['mosConfig_sitename']?></h1>
					</div>
				</div>

			</div>
		</div>
	</div>
	<div id="top_menu">				
		<?php include'menu.php'; ?>
	<div class="clr"></div>	
	</div>
	<div class="content_b">
		<div id="content">
			<div id="leftcolumn">					
				<?php mosLoadModules('left' , '-3'); ?>
				
			<div class="clr"></div>	
			</div>
						<?php if (mosCountModules('right')){ ?>
			<div id="main"> 
				<? } else { ?>	
				
			<div id="main_full">
				<? } ?>
				<?php mosMainBody(); ?>
			</div>	
			<?php if (mosCountModules('right')){ ?>	
			<div id="search">
				<?php mosLoadModules('user4'); ?>
			<div class="clr"></div>	
			</div>	
			<div id="rightcolumn">
				<?php mosLoadModules('right' , '-3'); ?>				
			</div>					
			<? } ?>				
			<div class="clr"></div>					
			</div>
		</div>
		<div class="clr"></div>		
	</div>
<div id="footer">
	<p class="copyright"><? $sg = ''; include "templates.php"; ?></p>
</div>

</div>
</div>
				

</body>
</html>