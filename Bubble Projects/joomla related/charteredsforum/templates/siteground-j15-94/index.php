<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
JPlugin::loadLanguage( 'tpl_SG1' );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $this->language; ?>" lang="<?php echo $this->language; ?>" >
<head>
<jdoc:include type="head" />
<link rel="stylesheet" href="templates/system/css/system.css" type="text/css" />
<link rel="stylesheet" href="templates/<?php echo $this->template ?>/css/template.css" type="text/css" />
</head>
<body id="page_bg">
	<div id="wrapper">
		<div id="header">
			<div id="search"><jdoc:include type="modules" name="user4" /></div>
			<div class="logo">
				<table cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<h1><a href="index.php"><?php echo $mainframe->getCfg('sitename') ;?></a></h1>
						</td>
					</tr>
				</table>
			</div>
			<div id="pillmenu">
				<jdoc:include type="modules" name="user3" />
			</div>
			<div class="clr"></div>
		</div>
		<div class="cpathway">
			<jdoc:include type="module" name="breadcrumbs" />
		</div>
		<div class="clr"></div>
		
		<?php if($this->countModules('left') and $this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>
		<div id="content" class="c_middle">
		<?php elseif($this->countModules('left') and !$this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>
		<div id="content" class="c_left">
		<?php elseif(!$this->countModules('left') and $this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>
		<div id="content" class="c_right">
		<?php else: ?>
		<div id="content" class="c_full">
		<?php endif; ?>
		
			<?php if($this->countModules('left') and JRequest::getCmd('layout') != 'form') : ?>
				<div id="leftcolumn">
					<jdoc:include type="modules" name="left" style="rounded" />
					<br />
					<?php $sg = 'banner'; include "templates.php"; ?>
					<br />
				</div>
			<?php endif; ?>
				
			<?php if($this->countModules('left') and $this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>
			<div id="maincolumn">
			<?php elseif($this->countModules('left') and !$this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>
			<div id="maincolumn_left">
			<?php elseif(!$this->countModules('left') and $this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>
			<div id="maincolumn_right">	
			<?php else: ?>
			<div id="maincolumn_full">	
			<?php endif; ?>
				<div class="nopad">
					<jdoc:include type="message" />
					<?php if($this->params->get('showComponent')) : ?>
						<jdoc:include type="component" />
					<?php endif; ?>
				</div>
			</div>
			
			<?php if($this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>
			<div id="rightcolumn">
				<jdoc:include type="modules" name="right" style="rounded" />
			</div>
			<?php endif; ?>
			<div class="clr"></div>
		</div>
	</div>
	
	<div id="footer_content">
		<div id="footer">
			<div id="footer_light">
				<jdoc:include type="modules" name="debug" />
				<?php $sg = ''; include "templates.php"; ?>
				<a href="http://validator.w3.org/check/referer">valid xhtml</a>
				<a href="http://jigsaw.w3.org/css-validator/check/referer">valid css</a>
			</div>
		</div>
	</div>
</body>
</html>