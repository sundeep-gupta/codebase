# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 2069 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/xPa.al)"
sub xPa{

my $str = <<'END_OF_FANCY_JS';
//**************COPYRIGHT(2002) NETBULA LLC, COPYING OF THIS CODE STRICTLY PROHIBITED
//VIOLATORS WILL BE PROSECUTED

function wYa(xZa) {
var xWa = xZa +'wZa';
var cRaA = xZa +'txt';
document.write('<table border=0 bgcolor="#eeeeff" cellpadding="0" cellspacing="0">'+
'<tr><td colspan=18 align=center id="' + cRaA+ '"><font size=1 face=Verdana>Choose color</font></td>'+
'<td colspan=18 id="'+xWa+'" align=center bgcolor="#888888"><font size=1>&nbsp;</font></td></tr>');

clr = new Array('FF','CC','99','66','33','00');

for(k=0;k<6;++k){
 document.write('<tr>\n');
 for(j=0;j<6;j++){
 for(i=0;i<6;++i){
		    var bg = '#'+clr[k]+clr[j]+clr[i];
 document.write('<td width=8 height=5 bgcolor='+bg +'>');   
	   document.write('<img src=blank.gif width=8 height=5' + 
 '     onClick="xBa(\'' + xZa + "', '" + bg + '\'); return true;" ' + 
 ' onmouseover="zAa(\'' + xZa + "', '" + bg + '\'); return true;" ' + 
			'>');   
 document.write('</td>\n');
 }   
 }
 document.write('</tr>\n');
}

document.write('</table>');

}

function xXa(xZa, xYa) {
 document.write('<select name="size" onChange="xFa(\'' + xZa + '\', \'FontSize\',this);" style="font: 8pt verdana;">');
 document.write('<option value="None" selected>Size</option>');
	 var len = xYa.length;
	 for(i=0; i<len; i++) {
	    	document.write('<option value="' + xYa[i] + 
		 '" style="font-size: ' + xYa[i] +';">'+ xYa[i] + '</option>\n');
	 }
	 document.write("</select>");
}

function wWa(xZa, xDa) {
 document.write('<select name="font" title="Set font for selected text" onChange="xFa(\'' + xZa + '\', \'FontName\', this);" style="font: 8pt verdana;">');
 var len = xDa.length;
 document.write('<option value="">Font Name</option>\n');
 for(i=0; i<len; i++) {
 	document.write('<option value="' + xDa[i] + 
		 '" style="font: 8pt ', + xDa[i] +';"><font face=' + xDa[i]+'>'+ xDa[i] +'</font></option>\n');
 }
 document.write("</select>");
}

function xBa(xZa, wSa){
	zAa(xZa, wSa);
	xFa(xZa, 'ForeColor',wSa);
}

function zAa(xZa, wSa){
	var wZa = document.all[xZa+"txt"];
	wZa.firstChild.style.color=wSa;
	wZa = document.all[xZa+"wZa"];
	wZa.bgColor=wSa;	
	var fr =  wSa.substring(1,3);
	var fg = wSa.substring(3,5);
	var fb = wSa.substring(5,7);
	
	wZa.firstChild.firstChild.nodeValue= wSa;

	var col= (fr < "AA" && fg<"AA" && fb<"AA")? "#ffffff":"#000000";
	wZa.firstChild.style.color=col;
}

function xFa(xZa, what) {
		
	if(what == "FontName" || what == "FontSize"){
		if(arguments[2].selectedIndex != 0){
			xKa(xZa, what, arguments[2].value);
			arguments[2].selectedIndex = 0;
		} 
	}else {
	   xKa(xZa, what, arguments[2]);
	 
	}
}

function xEa(xZa){
	xFa(xZa, 'CreateLink');
}

function oAa(xZa) {
	var xGa = window.frames["xGa"+xZa];
	var xIa = xGa.document.body.innerHTML;
	document.all[xZa].value = xIa;
}

function copyValueFrom(other, xZa) {
	var xGa = window.frames["xGa"+xZa];
	xGa.document.body.innerHTML = other.value;
}

function copyValueTo(xZa, other) {
	var xGa = window.frames["xGa"+xZa];
	if (xJa=="Text") {
		other.value = xGa.document.body.innerText;
	}else{
		other.value = xGa.document.body.innerHTML;
	}
}

var xJa="HTML"

function xKa(xZa, command) {
var xGa = window.frames["xGa"+xZa];
xGa.focus();
 if (xJa=="HTML") {
 var xMa = xGa.document.selection.createRange()
 if (arguments[2]==null)
 xMa.execCommand(command, true)
 else
 xMa.execCommand(command,false, arguments[2])
 xMa.select()
 xGa.focus()
 }
}

function wQa(xZa){
var xGa = window.frames["xGa"+xZa];
var xMa = xGa.document;

xMa.execCommand('SelectAll');
xGa.focus();

}

function wRa(xZa) {
	var xGa = window.frames["xGa"+xZa];
	xGa.document.open()
	xGa.document.write("")
	xGa.document.close()
	xGa.focus()
}

function wTa(xZa, xCa) {
	var xGa = window.frames["xGa"+xZa];
	xGa.document.open()
	xGa.document.write(xCa)
	xGa.document.close()
}

function wVa(xZa) {
	var xGa = window.frames["xGa"+xZa];
	var xCa = document.all[xZa].value;
	xGa.document.designMode="On";
	xGa.document.execCommand("2D-Position", true, true);
	xGa.document.execCommand("MultipleSelection", true, true);
	xGa.document.execCommand("LiveResize", true, true);
	xGa.document.open()
	xGa.document.write(xCa)
	xGa.document.close()
}

function wUa(xZa, funkF) {
	var xGa = window.frames["xGa"+xZa];
	if (funkF=="Text") {
		xGa.document.body.innerText = xGa.document.body.innerHTML
		xGa.document.body.style.fontFamily = "monospace"
		xGa.document.body.style.fontSize = "10pt"
		xJa="Text"
 	}
	else {
 		xGa.document.body.innerHTML = xGa.document.body.innerText
 		xGa.document.body.style.fontFamily = ""
 		xGa.document.body.style.fontSize =""
 		xJa="HTML"
 	}
	var s = xGa.document.body.createTextRange()
	s.collapse(false)
	s.select()
}

END_OF_FANCY_JS

return $str;

};

# end of sVa::xPa
1;
