# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1967 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/xOa.al)"
sub xOa{
	my ($xSa, $txt, $bgcolor, $cZaA, $cQaA) = @_;
	$cQaA = "/abicons/formicons" if not $cQaA;
	$bgcolor = "#e4e4be" if not $bgcolor;
	my $cTaA = $txt;
	$cTaA =~ s/'/\\'/g;
	$cTaA =~ s/\n/\\n/g;
	$cTaA =~ s/\r//g;

my $str = <<"END_OF_FANCY_FORM";
<table border="2" cellspacing="0" cellpadding="0" bgcolor="$bgcolor" width="100%" bordercolor="#f2f2df">
<tr valign="top"> 
 <td> 
 <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
 <tr valign="baseline"> 
 <td nowrap> <img class='xAa' src="$cQaA/new.gif" width="16" height="16" border="0" alt="New File" onClick="wRa('$xSa');"> 
 <img class='xAa' src="$cQaA/cut.gif" width="16" height="16" border="0" alt="Cut " onClick="xFa('$xSa', 'Cut')">&nbsp 
 <img class='xAa' src="$cQaA/copy.gif" width="16" height="16" border="0" alt="Copy" onClick="xFa('$xSa', 'Copy')">&nbsp 
 <img class='xAa' src="$cQaA/paste.gif" border="0" alt="Paste" onClick="xFa('$xSa', 'Paste')" width="16" height="16">&nbsp 
 </td>
 
 <td nowrap> <img class='xAa' src="$cQaA/ul.gif" width="16" height="16" border="0" alt="Bullet List" onClick="xFa('$xSa', 'InsertUnorderedList');" >&nbsp 
 <img class='xAa' src="$cQaA/ol.gif" width="16" height="16" border="0" alt="Numbered List" onClick="xFa('$xSa', 'InsertOrderedList');" >&nbsp 
 <img class='xAa' src="$cQaA/indent.gif" width="20" height="16" alt="Indent" onClick="xFa('$xSa', 'Indent')">&nbsp 
 <img class='xAa' src="$cQaA/outdent.gif" width="20" height="16" alt="Outdent" onClick="xFa('$xSa', 'Outdent')">&nbsp 
 <img class='xAa' src="$cQaA/hr.gif" width="16" height="18" alt="HR" onClick="xFa('$xSa', 'InsertHorizontalRule')">&nbsp 
 </td>
 
 <td title="Select font"> 
 <script>
 wWa("$xSa", new Array("Arial", "Times New Roman", "Verdana", "Courier New", "Georgia"));
				  </script>
 </td>
 
 <td vlaign=baseline>
 <script>
 xXa("$xSa", new Array("1", "2", "3", "4", "5", "6", "7", "+1", "+2", "+3", "+4", "+5", "+6"));
				 </script>
 </td><td vlaign=baseline title="Uncheck the box to view HTML code">
<!--
							  <select name="fancymode" onChange="wUa('$xSa', this.value)" style="font: 8pt verdana;">
							  <option value="HTML" selected">HTML</option>
							  <option value="Text">Text</option>
							  </select>
-->

							  <input type="checkbox" value="1" checked name="fancymode" onClick="wUa('$xSa', this.checked?'HTML':'Text')" style="font: 8pt verdana;">HTML

							  </td>
 </tr>
 </table>
 </td>
 </tr>
 <tr> 
 <td height="41"> 
 
 <table border="0" width="100%">
 <tr> 
 <td nowrap valign="baseline" width=50%> 
 <div align="left">
				  <img class='xAa' src="$cQaA/bold.gif" width="16" height="16" border="0" align="absmiddle" alt="Bold text" onClick="xFa('$xSa', 'Bold')">&nbsp 
 <img class='xAa' src="$cQaA/italics.gif" width="16" height="16" border="0" align="absmiddle" alt="Italic text" onClick="xFa('$xSa', 'Italic')">&nbsp 
 <img class='xAa' src="$cQaA/underline.gif" width="16" height="16" border="0" align="absmiddle" alt="Underline text" onClick="xFa('$xSa', 'Underline')" >&nbsp 
 <img class='xAa' src="$cQaA/left.gif" width="16" height="25" border="0" alt="Align Left" align="absmiddle"  onClick="xFa('$xSa', 'JustifyLeft')"> 
 <img class='xAa' src="$cQaA/center.gif" width="16" height="16" border="0" alt="Align Center" align="absmiddle" onClick="xFa('$xSa', 'JustifyCenter')">&nbsp 
 <img class='xAa' src="$cQaA/right.gif" width="16" height="16" border="0" alt="Align Right" align="absmiddle"  onClick="xFa('$xSa', 'JustifyRight')">&nbsp
				  <img class='xAa' src="$cQaA/link.gif" border="0" alt="Add Link" onClick="xEa('$xSa');" width="20" height="16" > 
 <img class='xAa' src="$cQaA/insertimg.gif" width="16" height="16" alt="Insert Image" onClick="xFa('$xSa', 'InsertImage')"> 
 </div>
 </td>
 <td align="right" nowrap valign="baseline" title="Click to set color for selected text">
				<script>wYa("$xSa");</script>
 </td>
 </tr>
 </table>
 
 
 </td>
 
 </tr>
 <tr valign="top" align="left"> 
 <td valign="top" height=$cZaA> 
<script>
document.write('<iframe id=xGa$xSa width=100% height=100%></iframe>');
document.write('<textarea name="$xSa" style="display: none;" rows="1" cols="20">$cTaA</textarea>');
document.write('<input type=hidden name="used_fancy_html" value="1">');
</script>
<noscript>
<textarea name="$xSa" rows="8" cols="40">$txt</textarea>
</noscript>
</td>
 </tr>
 </table>
<SCRIPT>
window.onload = new Function( "wVa('$xSa')" );
window.onunload = new Function( "oAa('$xSa')" );
</SCRIPT>
END_OF_FANCY_FORM

return $str;

};

# end of sVa::xOa
1;
