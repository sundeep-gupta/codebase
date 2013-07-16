<?php
$x2h_start = array();
$x2h_end = array();
############################ Converters for START tags ###########################
$x2h_start["TITLE"]   = "<font face = 'Georgia' size='6' color=#666666>
                        ";
$x2h_start["AUTHOR"]  = "<font face = 'Georgia' size = '2' color=#777777>
                        <b><i>
                        ";
$x2h_start["DATE"]    = "<font face='Georgia' size=2 color=#111111>
                        </i>
                        ";
$x2h_start["IMAGE"]   = "<img image_source width = 200 height = 200/>";
$x2h_start["P"]       = "<p style='color: *color*;'>";
$x2h_start["CONTENT"] = "<br/">
$x2h_start["B"]       = "<b>";
$x2h_start["A"]       = "<a style='color: #2a0101; text-decoration: underline;'
                            additional_attributes>";
$x2h_start["SECTION"] = "<div style='margin-left : section_indentpx;
                                     margin-right : 15px;'>\n";
$x2h_start["NAME"]    = "<p>
                        <font face='Georgia' size='2' color=#777777>
                        <b>";
$x2h_start["CODE"]    = "<code><font color=#555555>";
############################ Converters for END tags ###########################
$x2h_end["TITLE"]     = "</font><br/>
                        ";
$x2h_end["AUTHOR"]    = "</i></b>
                        </font><br/>
                        ";
$x2h_end["DATE"]      = "
                        </i>
                        </font>
                        ";
$x2h_end["IMAGE"]   = "";
$x2h_end["P"]       = "</p>";
$x2h_end["B"]       = "</b>";
$x2h_end["CONTENT"] = "";
$x2h_end["A"]       = "</a>";
$x2h_end["SECTION"] = "</div>";
$x2h_end["NAME"]    = "</b></font></p>";
$x2h_end["CODE"]    = "</font></code>";
################################################################################
                    //"<!-- tag=background -->>\n".
                    //"<div style='margin-left : {section_indent}px;".
                    //"margin-right : 15px;'>\n".
                    //"<font class=OraFieldText>";
$comment_x2h_start = array();
$comment_x2h_start["COMMENTS"] = "<table border=0 width='100%'>";
$comment_x2h_start["COMMENT"] = "<tr bgcolor='#cccccc'><td>";

$comment_x2h_end = array();
$comment_x2h_end["COMMENTS"] = "</table>";
$comment_x2h_end["COMMENT"] = "</td></tr>";
?>
