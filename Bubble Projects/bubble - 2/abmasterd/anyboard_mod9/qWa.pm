package qWa;

use strict;

use AutoLoader 'AUTOLOAD';

BEGIN {
@qWa::siteidx_cfgs=(
[siteidx_info=>'head', "Local site index configuration", ""],
[siteidx_method=>'radio', "http=HTTP Spiding (Slower but safe)\nfile=File scan (faster)", "Local index scan method", "file"],
[siteidx_url0=>'text', "size=64", "Full URL of the starting index page", ""],
[siteidx_topdir=>'text', "size=64", "Physical directory of the URL above", ""],
[siteidx_ref0=>"text", "size=64", "Local site refresh interval (in hours)",  72],
[siteidx_depth0=>"text", "", "Maximum index depth",   "100"],
[siteidx_info2=>'head', "Additional site(s) index configuration (HTTP only)", ""],
[siteidx_tit1=>'text', "size=64", "Site 1 Title", "News"], 
[siteidx_url1=>'text', "size=64", "Site 1 URL (must start with http://)", ""], 
[siteidx_ref1=>'text', "size=64", "Site 1 refresh interval (in hours)", "5"], 
[siteidx_depth1=>'text', "size=64", "Site 1 scan depth", "8"], 
[siteidx_tit2=>'text', "size=64", "Site 2 Title", ""], 
[siteidx_url2=>'text', "size=64", "Site 2 URL (must start with http://)", ""], 
[siteidx_ref2=>'text', "size=64", "Site 2 refresh interval (in hours)", "48"], 
[siteidx_depth2=>'text', "size=64", "Site 2 scan depth", "8"], 
[siteidx_tit3=>'text', "size=64", "Site 3 Title", ""], 
[siteidx_url3=>'text', "size=64", "Site 3 URL (must start with http://)", ""], 
[siteidx_ref3=>'text', "size=64", "Site 3 refresh interval (in hours)", "48"], 
[siteidx_depth3=>'text', "size=64", "Site 3 scan depth", "8"], 
[siteidx_tit4=>'text', "size=64", "Site 4 Title", ""], 
[siteidx_url4=>'text', "size=64", "Site 4 URL (must start with http://)", ""], 
[siteidx_ref4=>'text', "size=64", "Site 4 refresh interval (in hours)", "48"], 
[siteidx_depth4=>'text', "size=64", "Site 4 scan depth", "8"], 
[siteidx_info3=>'head', "Index constraints", ""],
[siteidx_filematch=>"text", "size=64", "Local file match pattern",  '\.(htm|html|txt|asp|php|jhtml|shtml)$'],
[siteidx_fileskip=>"text", "size=64", "URL skip pattern",  '/cgi-bin/'],
[siteidx_maxfiles=>"text", "", "Maximum number of files to scan",   "25600"],
[siteidx_multibyte=> "checkbox", '1=', "Spidered pages are non-western", "0"],
[siteidx_wsplit=>"text", "size=60", "Word split pattern",   ""],
[siteidx_info4=>'head', "Search result page configuration", ""],
[siteidx_maxmatch=>"text", "", "Maximum number of matches to return from a search", "20"],
[siteidx_header=> "textarea", 'rows=8 cols=60 wrap=soft', "Result page header, starting from &lt;html&gt;", qq(<HTML>
<head><title>PowerSearch Results</title>
<style type="text/css">
<!--
body {  font-family: Arial, Helvetica, sans-serif; font: 12px  "arial", serif; margin-left: 6pt; margin-top: 2pt}
 TABLE {
 font: 12px "arial", serif;
 }
 
 TABLE TR {
 font: 12px "arial", serif;
 }

 TABLE TD {
 font: 12px "arial", serif;
 }
.inputfields { COLOR: #666666; FONT-WEIGHT: bold; BACKGROUND-COLOR: #ffffff; FONT-FAMILY: Verdana, Helvetica, Arial; BORDER-BOTTOM: #666666 thin solid; BORDER-LEFT: #666666 thin solid; BORDER-RIGHT: #666666 thin solid; BORDER-TOP: #666666 thin solid  }
.buttonstyle  { FONT-SIZE: 12px;}
-->
</style>
</head>
<BODY bgColor=#ffffff>
)
],

[siteidx_banner=> "textarea", 'rows=4 cols=60 wrap=soft', "Result page banner", qq(<H2><font size="4" color="#336633">Power Search Results</font></H2>)],
[siteidx_footer=> "textarea", 'rows=4 cols=60 wrap=soft', "Result page footer", "</body></html>"],
[siteidx_info3=>'head', "Index creation confirmation", ""],
[siteidx_conf=> "checkbox", '1=', "Checking this box causes PowerSearch to spider the site(s) and create the indexes upon submission of the form", "1"],
[pwsearchcmd=>"hidden", "", "", "indexsite"],
);

@qWa::sitesearch_cfgs= (
[find_info =>"head", "Search Web Site"], 
[tK=> "text", 'maxlength=40', "Search words", ""],
[pwsearchcmd=>"hidden", "", "", "searchsite"],
);

$qWa::cEaA =
qq(1a2ac71a3ac73c7cc75b4cc78cbbab3fc73d6a8b3cc73abbc73aabc73a1ac71cbcc74dadc72d1debdac7bb2fc73acac73afbc752c7ac7cc7fb9c2d4dc75d2e0cfec74c7c0cfec7dc8a9bdfc78c7e9bbfc7bc4e8cbbc75bbaac7cc7cb8c8cbbc78c7e4bbcc7eb9b8cbbc72d4dab3fc7ac9b3d3cc74b3d0c4bc71b8d0dbec75d2e1d9fc7ac7cc78c7eabecc7cb0b6c4ec7cbba6c4e);

};

%qWa::bK= (
 siteidxform=>[\&eWa, 'ADM'],
 sitesearchform=>[\&eZa],
#x2
#x2
);

sub sVa::gYaA(@);

1;
