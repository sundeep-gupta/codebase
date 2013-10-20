#!/usr/bin/perl

print "Content-type:text/html\n\n";

#$linecount = `wc -l /usr/local/apache2/htdocs/isdnlog | cut -f7 -d " "`;

$count = `awk ' END { print NR; }' /usr/local/apache2/htdocs/isdnstatus`;

if ( $count == 0)
{
 $disco = 0;
 $total = 0;
}

elsif ( $count == 1)
{
$disco = 0;
$total = 1;
}

else
{
$disco = `awk '/lasted/ {com++} END {print com;}' /usr/local/apache2/htdocs/isdnstatus` ;

$total = `awk '/progress/ {act++}  END {print act;}' /usr/local/apache2/htdocs/isdnstatus` ;

$total += $disco ;
}



printf <<"EOF";

<html>
<head>
<script language="Javascript">
var i=60;
function timer()
{
                delay.innerText = i;
                i--;
                if(i==0)
                        location.reload();
}
function start()
{
                        setInterval("timer()",1000);
}
</script>
<title>ADP Wilco Monitoring System</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000" onload="start();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><b><font face="verdana" size="2">ISDN ACTIVITIES</font></b></td>
  </tr>
  <tr>
    <td align="center"><font face="verdana" size="2"><font size="1">(3 days activities)</font></font></td>
  </tr>
  <tr>
    <td align="center">
       <div align="left"><font face="verdana"><b><font size="2">Next <a href="#" onClick="location.reload();">Refresh</a>
        in <span id="delay">&nbsp;</span> seconds</font></b></font></div>
    </td>
  </tr>
</table>
<br>
<table width="750" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="ABD1DE">
      <table width="100%" border="0" cellspacing="1" cellpadding="3">
        <tr>
          <td bgcolor="#00688B" width="15%"><b><font face="verdana" size="2" color="#FFFFFF">&nbsp;
Total
            calls</font></b></td>
          <td bgcolor="#00688B" width="85%"><b><font face="verdana" size="2" color="#FFFFFF">&nbsp
$total</font></b></td>
        </tr>
        <tr>
          <td bgcolor="#00688B" width="15%"><b><font face="verdana" size="2" color="#FFFFFF">
            &nbsp;Total discos</font></b></td>
          <td bgcolor="#00688B" width="85%"><b><font face="verdana" size="2" color="#FFFFFF">&nbsp;
$disco</font></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br>
<table width="750" border="0" cellspacing="0" cellpadding="0" bgcolor="ABD1DE">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="1" cellpadding="3">
        <tr bgcolor="#00688B">
          <td colspan="5"><font face="Verdana, Arial, Helvetica, sans-serif"><font color="#FFFFFF">
<b><font size="2" face="verdana">&nbsp;ISDN
            Calls</font></b></font></font></td>
        </tr>
        <tr bgcolor="#8DB6CD" align="center">
          <td height="21"><b><font face="verdana" size="1">Host</font></b></td>
          <td height="21"><b><font face="verdana" size="1">&nbsp;Disco Time</font></b></td>
          <td height="21"><b><font face="verdana" size="1">&nbsp;BRI Router</font></b></td>
          <td height="21" bgcolor="#8DB6CD"><b><font face="verdana" size="1">&nbsp;Syslog
            Msg</font></b></td>
          <td height="21"><b><font face="verdana" size="1">&nbsp;Status</font></b></td>
        </tr>

EOF

my ($row1,$srcip,$packets,$bytes,$srchost);
my $i=1;

open(DAT,"</usr/local/apache2/htdocs/isdnstatus"); 

while ( <DAT> )
{
 
 $line = $_;
 
 @token = split(" ",$line); 

  $statement = $token[2]." ".$token[3]." ".$token[4]." ".$token[5]." ".$token[6]." ".$token[7]." ".$token[8]." ".$token[9]." ".$token[10];
 
  $status = $token[9];
  $color ="#308014";
  $bgcolor="#E9EFF2";
  
   $status = $token[9];
 
if ( $status eq "in")
   {
    $color ="#FF0000";
    $bgcolor ="#FFFFFF";
    $sec = "###";
    $flagging = "active";
   }

else 
 {
  $statement = $statement." ".$token[11];
  $flagging = "completed";
 } 

 print "<tr>";
 print "<td bgcolor=$bgcolor><font face=verdana size=2 color=$color>Adp-wilco</font></td>";
 
 print "<td bgcolor=$bgcolor><font face=verdana size=2 color=$color>&nbsp;$token[0]<br>&nbsp;$token[1]</font></td>";
    print "<td bgcolor=$bgcolor align=center><font face=verdana size=2 color=$color>172.25.63.4</font></td>";

        print "<td bgcolor=$bgcolor><font face=verdana size=2 color=$color>&nbsp;$statement</font></td>";

 print "<td bgcolor=$bgcolor><font face=verdana size=2 color=$color>&nbsp;$flagging</font></td>";

print "</tr>";

 }  

print "</table>";
    print "</td>";
  print "</tr>";
print "</table>";
print "<br>";
print "</body>";
print "</html>";


