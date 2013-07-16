<?php
header('Content-Type: text/xml');
echo '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
echo '';
  echo '<response>
  <FORM METHOD="POST" ACTION="contact.php">
          <TABLE ALIGN="center" WIDTH="90%" CELLPADDING="3">

                <TR>
                    <TD ALIGN="right">
                        Your Email Address
                    </TD>
                    <TD>
                        <INPUT TYPE="text" SIZE="50" NAME="from" VALUE=""></INPUT>
                    </TD>
                </TR>
                <TR>

                    <TD ALIGN="right">
                        Subject
                    </TD>
                    <TD>
                        <INPUT TYPE="text" SIZE="50" NAME="subject" VALUE=""></INPUT>
                    </TD>
                </TR><TR>
                    <TD ALIGN="right" VALIGN="top">
                        Your Message
                    </TD>

                    <TD>
                        <TEXTAREA COLS="50" ROWS="10" NAME="message" VALUE=""></TEXTAREA>
                    </TD>
                </TR>
                     <TR><TD></TD><TD></TD></TR>
                <TR>
                    <TD>
                    </TD>

                    <TD ALIGN="center">
                        <INPUT TYPE="submit" VALUE="submit"></INPUT>
                    </TD>
                </TR>
            </TABLE>
        </FORM>
	</response>';

?>