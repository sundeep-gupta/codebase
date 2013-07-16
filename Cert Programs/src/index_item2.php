			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
				<td><a href="certLog.php?ppl=<?=$data["id"]?>"><?=$data["ID"]?></a>&nbsp;</td>
				<td><?=$data["CompanyName"]?>&nbsp;</td>
				<td><?=$data["ProductName"]?>&nbsp;</td>
				<td><?=$data["Status"]?>&nbsp;</td>
				<td><?=substr($data["Date"],0,10)?>&nbsp;</td>
<?
  $testComplete = GetCompletionDate($data["id"]);
?>
				<td><?=substr($testComplete[0]["whenMet"],0,10)?>&nbsp;</td>
			</tr>
