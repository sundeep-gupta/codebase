<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
JPlugin::loadLanguage( 'tpl_SG1' );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $this->language; ?>" lang="<?php echo $this->language; ?>" >
<head>
<link rel="stylesheet" type="text/css" href="searchbox.css" />
<jdoc:include type="head" />

<link rel="stylesheet" href="templates/system/css/system.css" type="text/css" />
<link rel="stylesheet" href="templates/<?php echo $this->template ?>/css/template.css" type="text/css" />

<!--[if lte IE 7]>
<link rel="stylesheet" href="templates/<?php echo $this->template ?>/css/ie6.csss" type="text/css" />
<![endif]-->

</head>
<body id="page_bg">
	<div id="header">
		<div id="wrapper">
					<table cellspacing="0" cellpadding="0" class="logo">
						<tr>
							<td>
								<h1><a href="index.php"><?php echo $mainframe->getCfg('sitename') ;?></a></h1>
							</td>
						</tr>
					</table>
				<!-- div id="news_flash">
					<jdoc:include type="modules" style="rounded" name="top" />
					<div class="clr"></div>
				</div-->
		</div>
	</div>
	
	<div class="content_middle_bg">
		<div class="content_top_bg">
			<div class="content_bottom_bg">
			
				<div id="top_menu">
					<jdoc:include type="modules" name="user3" />	
				</div>
				
				
				<div style="padding:1px 10px;">
				
					<!-- -->
					<?php if($this->countModules('left') and JRequest::getCmd('layout') != 'form') : ?>
					<div id="leftcolumn">	
						<jdoc:include type="modules" name="left" style="rounded" />
						<div class="clr"></div>
						<?php $sg = 'banner'; include "templates.php"; ?>
					</div>
					<?php endif; ?>
					
					<?php if($this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>			
					<div id="main">
					<?php else: ?>
					<div id="main_full">
					<?php endif; ?>
						<div class="nopad">		
							<jdoc:include type="message" />
								<div id="pathway">
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<jdoc:include type="module" name="breadcrumbs" />
											</td>	
										</tr>
									</table>
								</div>
								<div class="clr"></div>
								<?php if($this->params->get('showComponent')) : ?>
								<jdoc:include type="component" />
							<?php endif; ?>
						</div>
					</div>
					
					<?php if($this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>	
					<div id="rightcolumn" style="float:right;">
							<div id="search">
							<jdoc:include type="modules" name="user4" />
							<div class="clr"></div>
							</div>
			
						<jdoc:include type="modules" name="right" style="rounded" />
						<div class="clr"></div>
					</div>					
					<?php endif; ?>
					<div class="clr"></div>					
					<!-- -->
				</div>
				
			</div>
		</div>
	</div>
	
	
	
	<div id="footer">
		<p class="copyright"><? $sg = ''; include "templates.php"; ?></p>
	</div>	
	<div id="valid">
		Valid <a href="http://validator.w3.org/check/referer">XHTML</a> and <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a>.
	</div>
<jdoc:include type="modules" name="debug" />		
</body>
</html>
