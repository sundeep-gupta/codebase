
if (!document.loadHandlers)
{
	document.loadHandlers=new Array();
	document.loadHandlers[0]='initializeMenu';
	document.lastLoadHandler=0;
}
else
{
	document.lastLoadHandler++;
	document.loadHandlers[document.lastLoadHandler]='initializeMenu';
}
window.onload=initializeAll;


var templevel = 0;
var activePopup=null;
var activePopupTimeout;
var maxZ=1000;
var popupFrame;
var targetFrame;
var docLoaded=false;
var bIncBorder=true;
var scrollTimeout=null;
var scrollTimeoutStr;
var scrollDelay=50;
var scrollStep=10;
var curPopupWidth=popupWidth;
var showDelayedTimeout=null;
var fadingSteps=8;
curModule = module;
//if(bBitmapPopups)
//bord=0;
bord=1;
//added newly

function makeTransparent(op,opObj,vis,ns,ie,frc)
{
	if(op||frc)
	{
		if(ns)opObj.style.MozOpacity = vis?op+'%':'';
		if(ie)opObj.style.filter=vis?"alpha(opacity="+op+")":"";
	}
}

function showDelayed(objId,step)
{	
	var obj=popupFrame.document.getElementById(objId);
	var objBg=popupFrame.document.getElementById(objId+'bgWnd');
	if(showDelayedTimeout){showDelayedTimeout=null;clearTimeout(showDelayedTimeout);}
	var max=popupOpacity?popupOpacity:100;
	if(obj)makeTransparent((fadingSteps-step)*max/fadingSteps,obj,1,1,1,1);
	if(objBg)makeTransparent(100,objBg,0,0,bBitmapPopups,1);
	if(step<=0)return;
	setTimeout("showDelayed('"+objId+"',"+(step-1)+")", bShowDel/fadingSteps);
}

function createMenuItem(popup,id,itemLink,itemText,popupArray,levelAttribs,bLast,popupHeight,parent,level)
{
	var itemType=0;
	if(itemText&&itemText.indexOf("(^1)")!=-1)itemType=1;
	if(itemText&&itemText.indexOf("(^2)")!=-1)itemType=2;
	var itemWnd=popupFrame.document.createElement("DIV");
	popup.appendChild(itemWnd);
	if(mac)
	{
		var brWnd=popupFrame.document.createElement("BR");
		popup.appendChild(brWnd)
	}
	addEvent(itemWnd,"mouseover",onItemOver,false);
	addEvent(itemWnd,"mouseout",onItemOut,false);
	addEvent(itemWnd,"mousedown",onItemClick,false);
	addEvent(itemWnd,"dblclick",onItemClick,false);
	itemWnd.owner=popup;
	itemWnd.id=id;
	with (itemWnd.style)
	{
		position="absolute";
		if(itemType==2)top=popupHeight-scrollHeight;
		else top=popupHeight;
		if(itemLink){cursor=(!IE4||version>=6)?"pointer":"hand";}
		else{cursor="default";}
		color=levelAttribs [3];
		if (!bBitmapPopups)
		{
			if (!bLast)
			{
				borderBottomColor=borderCol;
				borderBottomWidth=sep;
				borderBottomStyle="solid";
			}
		}
		else left=popupLeftPad+vertSpace;
		if (!itemType)padding=vertSpace;
		paddingLeft=popupLeftPad+vertSpace;
		paddingRight=(popupRightPad<iconSize?iconSize:popupRightPad)+vertSpace;
		fontSize=levelAttribs[0];
		fontWeight=(levelAttribs[1])?"bold":"normal";
		fontStyle=(levelAttribs[2])?"italic":"normal";
		fontFamily=levelAttribs[6];
		textAlign=(popAlign==1?'center':(popAlign==2?'right':'left'));
		setRealWidth(itemWnd,bBitmapPopups?curPopupWidth-popupLeftPad-popupRightPad-2*vertSpace:curPopupWidth,2*bord,level);
	}
	if (popupArray)itemWnd.popupArray=popupArray;
	if(itemType>0)
	{
		var arrow=popupFrame.document.createElement("IMG");
		itemWnd.appendChild(arrow);
		if (imgFolder&&imgFolder.indexOf('/')!=0)arrow.src=unescape(absPath)+imgFolder;
		else arrow.src=imgFolder;
		arrow.src+="/scroll"+((itemType==1)?"up":"down")+".gif";
		itemWnd.style.textAlign="center";
		itemWnd.style.display="none";
	}
	else itemWnd.innerHTML=itemText;
	if(itemLink&&itemLink.indexOf(':/')==-1&&itemLink.indexOf(':\\')==-1&&itemLink.indexOf('/')!=0)itemWnd.url=unescape(absPath)+itemLink;
	else itemWnd.url=itemLink;
	itemWnd.dispText=itemText;
	if (popupArray)
	{
		var expandArrow=popupFrame.document.createElement("IMG");
		itemWnd.appendChild(expandArrow);
		if (imgFolder&&imgFolder.indexOf('/')!=0)expandArrow.src=unescape(absPath)+imgFolder;
		else expandArrow.src=imgFolder;
		expandArrow.src+="/sxicona.gif";
		with (expandArrow.style)
		{
			width=iconSize;
			height=iconSize;
			position="absolute";
			var itemRect=getClientRect(itemWnd);
			top=(itemRect.bottom-itemRect.top)/2-iconSize/2-2;
			left=itemWnd.offsetWidth-iconSize-1;
		}
	}
	return itemWnd.offsetHeight;
}

function setRealWidth(wnd,width,borderWidth,level)
{	
	wnd.style.width=width-borderWidth;
	if (wnd.offsetWidth>width-borderWidth) wnd.style.width=width-parseInt(wnd.style.paddingLeft)-parseInt(wnd.style.paddingRight);	
}

function createPopupFromCode(arrayName,level,ownerMenu)
{
	bBitmapPopups=false
	var popupName=arrayName+"popup";
	var popup=popupFrame.document.getElementById(popupName);	
	if (popup)return popup;
	var levelAttribs;
	//added newly
	if(level==0)
		curPopupWidth=popupWidth;
	else if(level==1)
		curPopupWidth=popupWidth-30;
	else
		curPopupWidth=popupWidth-45;	
	//added newly-end	
	if (level > maxlev) {levelAttribs = eval ("lev" + maxlev) ;} else {levelAttribs = eval ("lev" + level) ;}
	popup=popupFrame.document.createElement("DIV");
	popupFrame.document.body.appendChild(popup);
	popup.id=popupName;
	popup.ownerMenu=ownerMenu;
	popup.level=level;
	popup.highlightColor=levelAttribs[5];
	popup.normalColor=levelAttribs[3];
	popup.highlightBgColor=levelAttribs[7];
	popup.normalBgColor=levelAttribs[4];
	popup.scrVis=false;
	with (popup.style)
	{
		zIndex=maxZ;
		position="absolute";
		width=curPopupWidth;		
		if (!bBitmapPopups)
		{
			borderColor=borderCol;
			backgroundColor=levelAttribs[4];
			borderWidth=bord;
			borderStyle="solid";
		}
		else backgroundColor="";
	}
	addEvent(popup,"mouseout",onPopupOut,false);
	addEvent(popup,"mouseover",onPopupOver,false);

	var popupHeight=0;
	if (bBitmapPopups)
	{
		var source=document.getElementById('menubg4');
		if (source)
		{
			/*var imel=popupFrame.document.createElement("IMG");
			popup.appendChild(imel);
			imel.src=source.src;
			imel.id=popup.id+"openingImg"
			imel.style.position="absolute";
			imel.style.top=0;*/
			//makeTransparent(popupOpacity,imel,1,0,1,0);
			//popupHeight+=popupOpenHeight;
		}
	}

	var bgWnd=popupFrame.document.createElement("DIV");
	popup.appendChild(bgWnd);
	bgWnd.id=popup.id+"bgWnd";
	bgWnd.style.position="absolute";
	bgWnd.style.top=popupOpenHeight;
	bgWnd.style.width=curPopupWidth-2*bord;
	bgWnd.innerHTML="<font size='1'>&nbsp;</font>";
	if (bBitmapPopups)
	{
		var source=document.getElementById('menubg5');
		//if (source) bgWnd.style.backgroundImage="url("+source.src+")";
		bgWnd.style.backgroundColor=levelAttribs[4];
	}
	else
	{
		/*if(level>1) 
			bgWnd.style.width=110;
		else
			bgWnd.style.width=curPopupWidth-2*bord;	*/
		bgWnd.style.backgroundColor=levelAttribs[4];
	}

	var array=eval(arrayName);
	var arrayItem;
	createMenuItem(popup,popup.id+"scrollUp","javascript:scrollUp('"+popup.id+"');","(^1)",null,levelAttribs,true,popupHeight,bgWnd,level);
	for(arrayItem=0;arrayItem<array.length/3;arrayItem++)
	{
		var popupArray=(array[arrayItem*3+2])?(arrayName+"_"+parseInt(arrayItem+1)):null;
		popupHeight+=createMenuItem(popup,null,array[arrayItem*3+1],array[arrayItem*3],popupArray,levelAttribs,(arrayItem == array.length/3-1),popupHeight,bgWnd,level);
	}
	createMenuItem(popup,popup.id+"scrollDown","javascript:scrollDown('"+popup.id+"');","(^2)",null,levelAttribs,true,popupHeight,bgWnd,level);
	var bottomImgHeight=0;
	if (bBitmapPopups)
	{
		var source=document.getElementById('menubg6');
		if (source)
		{
			/*var imel=popupFrame.document.createElement("IMG");
			popup.appendChild(imel);
			imel.src=source.src;
			imel.id=popup.id+"closingImg";
			imel.style.position="absolute";
			imel.style.top=popupHeight-1;*/
			//makeTransparent(popupOpacity,imel,1,0,1,0);
			//bottomImgHeight=imel.offsetHeight;
			//popupHeight+=bottomImgHeight;
		}
	}
	popup.style.height=popupHeight+bord*2+bottomImgHeight;
	popup.maxHeight=popupHeight+bord*2+bottomImgHeight;
	bgWnd.style.height=popupHeight-popupOpenHeight-bottomImgHeight;
	makeTransparent(popupOpacity,bgWnd,1,0,bBitmapPopups,0);
	makeTransparent(popupOpacity,popup,1,1,!bBitmapPopups,0);
	if(popup.offsetHeight>popupHeight+bord*2+bottomImgHeight){popup.style.height=popupHeight;bIncBorder=false;popup.maxHeight=popupHeight;}
	return popup;
}

function closePopup(popupId)
{
	if(popupId.indexOf('_')==-1){var hideWnd=popupFrame.document.getElementById('HideItem');if(hideWnd)hideWnd.style.visibility='visible';}
	if(scrollTimeout){scrollTimeoutStr=null;clearTimeout(scrollTimeout);}
	var popup=popupFrame.document.getElementById(popupId);
	if(popup)
	{
		if(popup.expandedWnd)closePopup(popup.expandedWnd.id);
		if(popup.ownerMenu)popup.ownerMenu.expandedWnd=null;
		popup.style.display="none";
		popup.style.visibility="hidden";
	}
	if(activePopup&&activePopup.id==popupId)activePopup=null;
}

function absToRel(rect,refx,refy)
{
	var retval=new rct(rect.left-refx,rect.top-refy,rect.right-refx,rect.bottom-refy);
	return retval;
}

function openPopup(popup,x,y,bDontMove,refWnd)
{
	if(popup.id.indexOf('_')==-1){var hideWnd=popupFrame.document.getElementById('HideItem');if(hideWnd)hideWnd.style.visibility='hidden';}
	if(activePopup&&activePopup.id==popup.id)return;
	//popup.style.left=x+20;
	popup.style.left=x;
	popup.style.top=y;
	popup.style.display="";
	popup.style.visibility="visible";
	var popupRect=getClientRect(popup);
	var browserRect=getBrowserRect(popupFrame);
	var bResize=(popup.offsetHeight<popup.maxHeight);	
	if (popupRect.right>browserRect.right)
	{
		var offLeft = 760;
		if(refWnd.offsetLeft > offLeft)
			offLeft = refWnd.offsetLeft;
		if(refWnd.id&&refWnd.id.indexOf('top')==-1)
			popup.style.left=Math.max(0,offLeft-popup.offsetWidth+levelOffset);
		else 
			popup.style.left=browserRect.right-popup.offsetWidth-5;
	}
	var wnd1=popupFrame.document.getElementById(popup.id+"scrollDown");
	var wnd2=popupFrame.document.getElementById(popup.id+"scrollUp");
	var cv=mac?15:(bIncBorder?3:20);
	if (((popupRect.bottom>browserRect.bottom)||bResize)&&!NS60)
	{
		var newtop=browserRect.bottom-popup.offsetHeight-cv;
		if(!menuHorizontal)bDontMove=false;
		if (newtop<0||bDontMove||bResize)
		{
			if(sepFrame&&!openSameFrame&&menuPos==3)popup.style.top=Math.max(browserRect.top,newtop);
			var minNum=Math.min(popup.maxHeight,browserRect.bottom-popup.offsetTop-cv-(bIncBorder?0:bord*2));
			popup.scrVis=(minNum!=popup.maxHeight);
			setPopupHeight(popup,browserRect.top,minNum);
		}
		else popup.style.top=newtop;
	}
	wnd1.style.display=popup.scrVis?"":"none";
	wnd2.style.display=popup.scrVis?"":"none";
	if(bShowDel&&!mac)showDelayed(popup.id,fadingSteps);
}

function setPopupHeight(popup,documentOffset,height)
{
	var wnd2=popupFrame.document.getElementById(popup.id+"scrollDown");
	var wnd4=popupFrame.document.getElementById(popup.id+"scrollUp");
	var wnd3=popupFrame.document.getElementById(popup.id+"bgWnd");
	var wnd1Height=0;
	if(bBitmapPopups)
	{
		var wnd1=popupFrame.document.getElementById(popup.id+"closingImg");
		var wnd5=popupFrame.document.getElementById(popup.id+"openingImg");
		wnd1Height=wnd1.offsetHeight;
		wnd1.style.top=height-1-wnd1Height;
	}
	wnd2.style.zIndex=maxZ+1;
	wnd4.style.zIndex=maxZ+1;
	popup.style.height=height;
	wnd3.style.height=height-popupOpenHeight-bord*2-wnd1Height;
	wnd2.style.top=height-wnd1Height-scrollHeight-(bIncBorder?bord*2:0);
	scrollPopup(popup.id,0);
}

function scrollPopup(popupId,dir)
{
	var popup=popupFrame.document.getElementById(popupId);
	var popupRect=getClientRect(popup);
	var items=popup.getElementsByTagName("DIV");
	var i=(dir>0?0:items.length-1);
	var off=(dir>0?1:-1);
	var bFirst=true;
	var offset=dir*scrollStep;
	if(popup.scrVis)
	{
		popupRect.top+=scrollHeight;
		popupRect.bottom-=scrollHeight;
	}
	popupRect.bottom-=2*bord;
	for (;i<items.length&&i>=0;i+=off)
	{
		var item=items[i];
		if (!item.id||(item.id.indexOf("scroll")==-1&&item.id.indexOf("bgWnd")==-1))
		{
			var itemRect=getClientRect(item);
			if(bFirst&&dir==0){offset=popup.maxHeight-(item.offsetTop+item.offsetHeight)+(popup.scrVis?scrollHeight:0)-(bIncBorder?bord*2:0);}
			var relRect=absToRel(popupRect,itemRect.left,itemRect.top+offset);
			if (dir>0 && relRect.top<-scrollHeight && bFirst) return;
			if (dir<0 && itemRect.bottom+offset<popupRect.bottom-scrollHeight && bFirst) return;
			if(offset!=0)item.style.top=item.offsetTop+offset;
			if(!mac)item.style.clip="rect("+relRect.top+","+relRect.right+","+relRect.bottom+","+relRect.left+")";
			if (relRect.bottom<0||relRect.top>item.offsetHeight)
				item.style.visibility="hidden";
			else
				item.style.visibility="visible";
			bFirst=false;
		}
	}
	if(popup.scrPos)popup.scrPos+=offset;
	else popup.scrPos=offset;
}

function scrollUp(popupId)
{
	scrollPopup(popupId,1);
}

function scrollDown(popupId)
{
	scrollPopup(popupId,-1);
}

function isChildOfActivePopup(popup)
{
	var wnd=activePopup;
	while(wnd)
	{
		if (wnd.id==popup.id)
			return true;
		wnd=wnd.expandedWnd;
	}
	return false;
}

function onPopupOver()
{
	if (activePopup&&activePopupTimeout&&isChildOfActivePopup (this))clearTimeout(activePopupTimeout);
}

function onPopupOut()
{
	onPopupOutImpl(this);
}

function onPopupOutImpl(popup)
{
	if(mout&&activePopup&&isChildOfActivePopup(popup))
	{
		if(activePopupTimeout)clearTimeout(activePopupTimeout);
		activePopupTimeout=setTimeout("closePopup('"+activePopup.id+"');",closeDelay);
	}
}

function rct(left,top,right,bottom)
{
	this.left=left;
	this.top=top;
	this.right=right;
	this.bottom=bottom;
}

function getBrowserRect(doc)
{
	var left=0;
	var top=0;
	var right;
	var bottom;
	if(doc.pageXOffset)left=doc.pageXOffset;
	else if(doc.document.body.scrollLeft)left=doc.document.body.scrollLeft;
	if(doc.pageYOffset)top=doc.pageYOffset;
	else if(doc.document.body.scrollTop)top=doc.document.body.scrollTop;
	if(doc.innerWidth)right=left+doc.innerWidth;
	else if(doc.document.body.clientWidth)right=left+doc.document.body.clientWidth;
	if(doc.innerHeight)bottom=top+doc.innerHeight;
	else if(doc.document.body.clientHeight)bottom=top+doc.document.body.clientHeight;
	var retval=new rct(left,top,right,bottom);
	return retval;	
}

function calcClientRect(wnd)
{
	var left=mac?document.body.leftMargin:0;
	var top=mac?document.body.topMargin:0;
	var right=0;
	var bottom=0;
	var par=wnd;
	while (par)
	{
		left+=par.offsetLeft;
		top+=par.offsetTop;
		if (par.offsetParent==par || par.offsetParent==popupFrame.document.body) break;
		par=par.offsetParent;
	}
	//if(left>640 && templevel == 0)
	if(left>780 && templevel == 0){		
		if(curModule == "Inventory")
			left = left-70;	
		else
			left = left-106;
	}
		
	right=left+wnd.offsetWidth;
	templevel = 0;	
	bottom=top+wnd.offsetHeight;
	var retval=new rct(left,top,right,bottom);
	return retval;
}

function getClientRect(wnd)
{
	if ((mac||DOM)&&wnd.getBoundingClientRect) return wnd.getBoundingClientRect ();
	return calcClientRect(wnd);
}

function onItemClick()
{
	var item=this;
	var close=true;
	if (item.url)
	{
		var startPos=item.dispText.indexOf('<!--');
		if (startPos!=-1)
		{
			var endPos = item.dispText.indexOf('-->',startPos);
			var trgFrame = item.dispText.substring (startPos+4,endPos);
			if (trgFrame=="_blank") window.open (item.url);
			else eval("parent.frames."+trgFrame).location.href=item.url;
		}
		else
		{
			var find=item.url.indexOf("javascript:");
			if (find!=-1)
				{
				eval(item.url.substring(find));
				if(item.url.indexOf("scroll")!=-1) close=false;
				}
			else
				{
				var mt=item.url.indexOf("mailto:");
				if(mt!=-1)window.top.location=item.url.substring(mt);
				else targetFrame.location=item.url;
				}
		}
		if(activePopup&&close)closePopup(activePopup.id);
	}
}

function onNextScroll()
{
	if(scrollTimeoutStr)
	{
		eval(scrollTimeoutStr);
		if(scrollTimeout)clearTimeout(scrollTimeout);
		scrollTimeout=setTimeout("onNextScroll()",scrollDelay);
	}
}

function onItemOver()
{
	var item=this;
	var bOp=0;
	if (item.id&&item.id.indexOf("scroll")!=-1)
	{
		scrollTimeoutStr=item.url;
		onNextScroll();
		return;
	}
	if (item.owner.expandedWnd)
	{
		if(item.popupArray&&item.popupArray+'popup'==item.owner.expandedWnd.id)bOp=1;
		if(!bOp)closePopup(item.owner.expandedWnd.id);
	}
	if (item.url&&item.url.indexOf("javascript:")==-1)
		window.status=item.url;
	else
		window.status="";
	item.style.color=item.owner.highlightColor;
	item.style.backgroundColor=item.owner.highlightBgColor;
	makeTransparent(popupOpacity,item,1,0,bBitmapPopups,0);
	var items=item.owner.getElementsByTagName("DIV");
	var i=0;
	for (;i<items.length;i++)if(item!=items[i]&&(!items[i].id||items[i].id.indexOf("scroll")==-1))
	{
		items[i].style.backgroundColor=bBitmapPopups?"transparent":item.owner.normalBgColor;
		items[i].style.color=item.owner.normalColor;
	}
	if (item.popupArray&&!bOp)
	{
		var rect=getClientRect(item);
		var x=rect.right-levelOffset;
		var y=rect.top;
		var popup=createPopupFromCode(item.popupArray,item.owner.level+1,item.owner);
		templevel = item.owner.level+1;
		item.owner.expandedWnd=popup;
		openPopup(popup,x,y+2,false,item.owner);
	}
}

function onItemOut()
{
	var item=this;
	if(scrollTimeout){scrollTimeoutStr=null;clearTimeout(scrollTimeout);}
	makeTransparent(popupOpacity,item,0,0,bBitmapPopups,0);
	if (item.id&&item.id.indexOf("scroll")!=-1) return;
	item.style.color=item.owner.normalColor;
	item.style.backgroundColor=bBitmapPopups?"transparent":item.owner.normalBgColor;
}

function expandMenu(popupId,refWnd,dum)
{
	if(!docLoaded)return;
	if(activePopupTimeout)clearTimeout(activePopupTimeout);
	if (activePopup&&activePopup.id!=popupId+"popup")
		closePopup(activePopup.id);
	if(popupId=='none')return;
	var posRef=document.getElementById(refWnd);
	var rect=calcClientRect(posRef);
	if(bVarWidth&&!bBitmapPopups)curPopupWidth=rect.right-rect.left+(IE4?bord*2:0);
	var x;
	var y;
	if(menuHorizontal)
	{
		x=rect.left-bord;
		y=rect.bottom+popupOffset;
	}
	else
	{
		x=rect.right+popupOffset;
		y=rect.top-bord;
	}
	if(sepFrame&&!openSameFrame)
	{
		var brRect=getBrowserRect(popupFrame);
		var wRect=getBrowserRect(window);
		switch (menuPos)
		{
		case 0:
			x=brRect.left;
			y+=brRect.top-wRect.top;
			break;
		case 1:
			x=brRect.right;
			y+=brRect.top-wRect.top;
			break;
		case 2:
			x+=brRect.left-wRect.left;
			y=brRect.top;
			break;
		case 3:
			x+=brRect.left-wRect.left;
			y=brRect.bottom;
			break;
		}
	}
	var popup=createPopupFromCode(popupId,0,null);	
	templevel = 0;
	openPopup(popup,x,y,true,posRef);
	activePopup=popup;
}

function collapseMenu(popupId)
{
	if(!docLoaded)return;
	var popup=popupFrame.document.getElementById(popupId+"popup");
	if(popup)onPopupOutImpl(popup);
}

function expandMenuNS(popupId,e,dItem)
{
}

function collapseMenuNS(popupId)
{
}

function onDocClick()
{
	if(activePopup)closePopup(activePopup.id);
}

function findFrame(name)
{
	if(parent.frames[name])return parent.frames[name];
	var i;
	for(i=0;i<parent.frames.length;i++){if(parent.frames[i].frames[name])return parent.frames[i].frames[name];}
}

function initializeMenu()
{
	popupFrame=(sepFrame&&!openSameFrame)?findFrame(contentFrame):window;
	targetFrame=(sepFrame)?findFrame(cntFrame):window;
	if(!mout)addEvent(popupFrame.document,"mousedown",onDocClick,false);
	docLoaded=true;
}

function addEvent(obj,event,fun,bubble)
{
	if (obj.addEventListener)
		obj.addEventListener(event,fun,bubble);
	else
		eval("obj.on"+event+"="+fun);
}

function chgBg(item,color)
{
	if (!IE4&&!DOM)return;
	var el=document.getElementById(item);
	var ela=document.getElementById(item+'a');
	if (color==0)
	{
		if(!bBitmapScheme)el.style.background=tlmOrigBg;
		if(ela)ela.style.color=tlmOrigCol;el.style.color=tlmOrigCol;
	}
	else
	{
		if(!bBitmapScheme&&(color&1))el.style.background=tlmHlBg;
		if(ela&&color&2)ela.style.color=tlmHlCol;el.style.color=tlmHlCol;
	}
}

function initializeAll()
{	
	var i;	
	for(i=0;i<=document.lastLoadHandler;i++)
	{
		eval(document.loadHandlers[i]+'();');
	}
}