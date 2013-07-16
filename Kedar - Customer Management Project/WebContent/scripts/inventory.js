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
				popupWidth = 130;
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
				module = "Inventory";
			}

			lev0 = new Array ("xx-small",true,false,"Black","#9DAEA5","white","Arial","#CFC6AD");
			lev1 = new Array ("xx-small",true,false,"Black","#9DAEA5","navy","Arial","#CFC6AD");
			lev2 = new Array ("xx-small",true,false,"Black","#dee8d0","navy","Arial","#edfde2");
			lev3 = new Array ("xx-small",true,false,"Black","#dee8d0","navy","Arial","#edfde2");

			mn1 = new Array
			(
			"Add Material","UI1.html",0
			,"Edit Material","UI5.html",0
			,"Add Special Material","UI4.html",0
			,"Search Material","UI5a.html",0
			)
			mn2 = new Array
			(
			"Add Equipment","UI7.html",0
			,"Edit Equipment","UI36EditEquip.html",0
			,"Search Equipment","UI36.html",0
			)
			mn3 = new Array
			(
			"Add Service","UI10.html",0
			,"Edit Service","UI10Edit.html",0
			,"Search Service","UI10Search.html",0
			)
			mn4 = new Array
			(
			"Add Vendor","UI13.html",0
			,"Edit Vendor","UI13EditVendor.html",0
			,"Search Vendor","UI13Search.html",0
			)
			mn5 = new Array
			(
			"Place PO","UI14.html",0
			,"Edit PO","UI14Edit.html",0
			,"Search PO","UI14Search.html",0
			)
			mn6 = new Array
			(
			"Enter Invoice","UI27.html",0
			,"Edit Invoice","UI27Edit.html",0
			,"Approve Invoice","UI25.html",0
			,"Search Invoice","UI27Search.html",0
			)
			mn7 = new Array
			(
			"Receive Material","UI20.html",1
			,"Return Material","UI22.html",0
			,"Approve Receipts","UI26.html",0
			)
			mn7_1 = new Array
			(
			"Shipment with PO","UI19.html",0
			,"Shipment without PO","#",0
			)			
			mn8 = new Array
			(
			"Allocate Material","UI30.html",0
			,"Update Inventory","#",0
			,"Place Requisition","UI28.html",0
			)
			mn9 = new Array
			(
			"Add Schedule","UI33.html",0
			,"Edit Schedule","#",0
			,"Delete Schedule","#",0
			,"Search Schedule","UI34.html",0
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
