			NS4=(document.layers) ;
			NS60=(navigator.userAgent.indexOf("Netscape6/6.0")!=-1);
			Opera=(navigator.userAgent.indexOf('Opera')!=-1)||(navigator.appName.indexOf('Opera')!=-1)||(window.opera);
			IE4=(document.all&&!Opera) ;
			mac=((IE4)&&(navigator.appVersion.indexOf ("Mac")!=-1));
			DOM=document.documentElement&&!NS4&&!IE4&&!Opera;
			mswnd=(navigator.appVersion.indexOf("Windows")!=-1||navigator.appVersion.indexOf("WinNT")!=-1);

			if(IE4){
				av=navigator.appVersion;
				avi=av.indexOf("MSIE");
				if (avi==-1)
					version = parseInt (av) ;
				  else
					version = parseInt(av.substr(avi+4)) ;
			}

			if(NS4||IE4||DOM||Opera)
			{
				imgFolder = "images";
				maxlev = 3;
				popAlign = 0;
				bVarWidth = 0;
				bShowDel = 0;
				popupWidth = 150;
				levelOffset = 20;
				bord = 5;
				vertSpace = 4;
				sep = 0;
				sepFrame = false;
				openSameFrame = false;
				cntFrame = "content";
				contentFrame = "content";
				mout = true;
				iconSize = 8;
				closeDelay = 1000;
				tlmOrigBg = "#CCE6FF";
				tlmOrigCol = "Black";
				bBitmapScheme = true;
				popupOpacity = 200;
				bBitmapPopups = true;
				popupOpenHeight = 5;
				popupLeftPad = 5;
				popupRightPad = 2;
				tlmHlBg = "#CCE6FF";
				tlmHlCol = "#0000A0";
				//borderCol = "#75BAFF";
				borderCol = "#800000";
				menuHorizontal = true;
				scrollHeight=6;
				module = "Customer";
			}

			lev0 = new Array ("xx-small",true,false,"Black","#9DAEA5","white","Arial","#CFC6AD");
			lev1 = new Array ("xx-small",true,false,"Black","#9DAEA5","navy","Arial","#CFC6AD");
			lev2 = new Array ("xx-small",true,false,"Black","#dee8d0","navy","Arial","#edfde2");
			lev3 = new Array ("xx-small",true,false,"Black","#dee8d0","navy","Arial","#edfde2");

			mn1 = new Array
			(
			"Add Customer Group","/kndn/jsp3",0
			,"Edit Customer Group","/kndn/editcg1",0
			,"Search Customer Group","/kndn/editcg3",0
			)
			mn2 = new Array
			(
			"Add Customer","/kndn/jsp11",0
			,"Edit Customer","CMUI5EditSearch.html",0
			,"Search Customer","CMUI5.html",0
			)
			mn3 = new Array
			(
			"Add Customer Account","CMUI7.html",0
			,"Edit Customer Account","CMUI8EditSearch.html",0
			,"Search Customer Account","CMUI8.html",0
			)
			mn4 = new Array
			(
			"Add Quirk","CMUI13.html",0
			,"Edit Quirk","CMUI14Edit.html",0
			,"Search Quirk","CMUI14Search.html",0
			)
			absPath="";
			if (sepFrame && !openSameFrame)
				{
				if (document.URL.lastIndexOf("\\")>document.URL.lastIndexOf("/")) {sepCh = "\\" ;} else {sepCh = "/" ;}
				absPath = document.URL.substring(0,document.URL.lastIndexOf(sepCh)+1);
				}
			popupOffset = 2;
			if (DOM||IE4) document.write("<img width=1 height=1 id='menubg4' src='img/menubg4.gif' style='display:none' /><img width=1 height=1 id='menubg5' src='images/menubg5.gif' style='display:none' /><img width=1 height=1 id='menubg6' src='images/menubg6.gif' style='display:none' />");
			if(Opera) document.write("<"+"script language='JavaScript1.2' src='scripts/menu_opera.js'><"+"/"+"script>");
			else if (NS4) document.write("<"+"script language='JavaScript1.2' src='scripts/menu_ns4.js'><"+"/"+"script>");
			else if (document.getElementById) document.write("<"+"script language='JavaScript1.2' src='scripts/menu_dom.js'><"+"/"+"script>");
			else document.write("<"+"script language='JavaScript1.2' src='scripts/menu_ie4.js'><"+"/"+"script>");
			document.write("<style type='text/css'>\n");
			document.write(".CL0 {text-decoration:none;color:Black; }\n");
			if(!IE4&&!DOM) document.write(".topFold {position:relative}\n");
			document.write(((NS4&&!bBitmapScheme)?".mm2":".mit")+" {padding-left:0px;padding-right:0px;}\n");
			document.write("</style>\n");
