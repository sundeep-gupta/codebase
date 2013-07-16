			<tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
				<td><a href="certLog.php?ppl=<?=$data["id"]?>"><?=$data["ID"]?></a>&nbsp;</td>
				<td><?=$data["CompanyName"]?>&nbsp;</td>
				<td><?=$data["ProductName"]?>&nbsp;</td>
				<td><?=$data["productsTested"]?></td>
				<td><?=$data["Status"]?>&nbsp;</td>
				<td><?=$data["Initials"]?>&nbsp;</td>
				<td><?=$data["Date"]?>&nbsp;</td>
				<td>
          <? 
				    if ($filescnt > 0) {
              for ($i=0;$i<$filescnt;$i++){
				        //printf("<a href=getFile.php?ppl=%d&getid=%d title=\"%s\">F%d</a> ", $files[$i]["product_id"], $files[$i]["id"], $files[$i]["name"], $i+1);
				        printf("<a href=getFile.php?ppl=%d&getid=%d title=\"%s\">F%d</a> ", $data["id"], $files[$i]["id"], $files[$i]["name"], $i+1);
				      }
				    } else {
              echo "&nbsp;";
            }
          ?>
        </td>
				<td>
					<?
						if (isset($_SESSION["Permissions"]["KeyLabs"])){
					?>
							<a href="chooseEmail.php?ppl=<?=$data["id"]?>"><img src="graphics/email.gif" title="send e-mail" alt="send e-mail" border="0"></a>
					<? } ?>&nbsp;
				</td>
			</tr>
