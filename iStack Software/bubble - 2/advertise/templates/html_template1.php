<HTML>
<HEAD>
    <TITLE> Bubble Classifieds </TITLE>
    <?php main_css(); ?>
</HEAD>

<BODY topmargin="0" bgcolor="#666666" LEFTMARGIN="0" >
<div align="center">
    <?php main_header(); ?>
    
    <?php top_nav(); ?>
    
    <TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0"
            WIDTH="800" HEIGHT="600"
            background ="<?php echo cnfg('deDir') ?>images/leftbk4.jpg">
    <TR>
        <TD valign="top" width="18%" >
    
            <?php display_cats_main(); ?>
        </TD>
        <TD valign="top" width="65%" BGCOLOR="#FFFFFF"
        background="<?php echo cnfg('deDir'); ?>images/bkgrnd2.jpg">
             <table cellpadding="10" cellspacing="0" border="0" width="100%"
              >
                <tr><td valign="top" width="100%">
                <!-- ********** MAIN TABLE ********** -->
                     <?php content($content); ?>
             </td></tr></table>
        </TD>
        <TD valign="top" width="18%" background="<?echo cnfg('deDir');?>images/bkgrnd2.jpg">
            <?php log_in_form_and_status(); ?>
        </TD>
    </TR>
    <tr>
    <table width = '800' cellspacing=0 border=0>
        <tr>
            <td width="100%" background="images/bkgrnd2.jpg" colspan="3" bgcolor="#000000" align='center'>
                |<a href="/galleries/Bubble%20Gallery/index.htm">Gallery</a> 
                |<a href="/cgi-bin/bubbleforum/YaBB.pl">Forum </a>|
                <a href="/ebook.php">E-Book</a> |
                <a href="/myspace.php">My Space</a> |
                <a href="/advertise/index.php">Advertise</a> <b>|</b>
                <a href="/contact.php">Contact us </a></font>
            </td>
        </tr>
        <tr>
            <td width="100%" background="images/bkgrnd2.jpg" align = 'center'>
            </td>
        </tr>
        <tr>
            <td width="100%" background="images/bkgrnd2.jpg" align = 'center'>
                <IMG SRC="http://www.bubble.co.in/cgi-bin/counter.cgi?3&w">
                <IMG SRC="http://www.bubble.co.in/cgi-bin/counter.cgi?2">
                <IMG SRC="http://www.bubble.co.in/cgi-bin/counter.cgi?1">
                <IMG SRC="http://www.bubble.co.in/cgi-bin/counter.cgi?0">
            </td>
        </tr>
        <tr>
                <td width="100%" background="images/bkgrnd2.jpg" align = 'center'>
                </td>
        </tr>
        <tr>
            <td width="800" colspan="2" height="10" bgcolor="#003300" align='center'>
                <font size="1" color='white'> © 2007, Bubble Inc.,</font>
            </td>
        </tr>
        </table>
        </tr>
</TABLE>
</CENTER>
</div>
</BODY>
</HTML>
