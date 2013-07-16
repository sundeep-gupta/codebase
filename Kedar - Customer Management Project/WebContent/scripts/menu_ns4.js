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

var activePopup=null;
var activePopupTimeout;
var maxZ=1000;
var popupFrame;
var targetFrame;
var docLoaded=false;
pr=bord+3;
iconTag="<IMG SRC=\'";
if (imgFolder.indexOf('/')!=0)iconTag+=absPath;
iconTag+=imgFolder+"/sxicona.gif\' BORDER=0 WIDTH="+iconSize+" HEIGHT="+iconSize+" HSPACE=6 ALIGN=RIGHT>";

var resizeRef=(sepFrame&&!openSameFrame)?parent:window;
var startWidth=resizeRef.innerWidth;
var startHeight=resizeRef.innerHeight;
resizeRef.onresize=function()
{
	if(resizeRef.innerWidth==startWidth && resizeRef.innerHeight==startHeight)return;
	resizeRef.location.reload();
}

function createMenuItem(popup,itemLink,itemText,popupArray,levelAttribs,bLast,popupHeight)
{
    var itemWnd;
	eval("itemWnd=new Layer(popupWidth,popup)");

	var itemHoverText="<font style='font-size:"+levelAttribs[0]+";width:"+(popupWidth-vertSpace*2-bord*2)+"' color="+levelAttribs[5]+" face='"+levelAttribs[6]+"'>"+itemText+"</font>";
	var targetFr="";
	if (itemLink)
	{
		var startPos=itemText.indexOf('<!--');
		if(sepFrame&&openSameFrame)targetFr="target='"+cntFrame+"'";
		if (startPos!=-1)
		{
			var endPos = itemText.indexOf('-->',startPos);
			targetFr = "target='"+itemText.substring (startPos+4,endPos)+"'";
		}
	}
	if(itemLink)itemHoverText="<a href=\""+itemLink+"\" "+targetFr+" style='width:"+(popupWidth-vertSpace*2-bord*2)+";text-decoration:none'>"+itemHoverText+"</a>";
	if(levelAttribs[1])itemHoverText=itemHoverText.bold();
	if(levelAttribs[2])itemHoverText=itemHoverText.italic();
    if(popupArray)itemHoverText=iconTag+itemHoverText;

	itemText="<font style='font-size:"+levelAttribs[0]+";width:"+(popupWidth-vertSpace*2-bord*2)+"' color="+levelAttribs[3]+" face='"+levelAttribs[6]+"'>"+itemText+"</font>";
    if(itemLink)itemText="<a href=\""+itemLink+"\" "+targetFr+" style='width:"+(popupWidth-vertSpace*2-bord*2)+";text-decoration:none'>"+itemText+"</a>";
	if(levelAttribs[1])itemText=itemText.bold();
	if(levelAttribs[2])itemText=itemText.italic();
    if(popupArray)itemText=iconTag+itemText;

	itemWnd.captureEvents(Event.CLICK);
    itemWnd.onclick=onItemClick;
	addEvent(itemWnd,"mouseout",onItemOut,false);
	addEvent(itemWnd,"mouseover",onItemOver,false);
    itemWnd.document.write(itemText);
    itemWnd.document.close();
	itemWnd.document.tags.A.textDecoration="none";
	itemWnd.document.tags.FONT.width=popupWidth-vertSpace*2-bord*2;
	itemWnd.document.tags.FONT.fontSize=levelAttribs[0];
	itemWnd.pageX=vertSpace+bord;
    if (popupArray)itemWnd.popupArray=popupArray;
    itemWnd.owner=popup;
	if(itemLink&&itemLink.indexOf(':/')==-1&&itemLink.indexOf(':\\')==-1&&itemLink.indexOf('/')!=0)itemWnd.url=unescape(absPath)+itemLink;
	else itemWnd.url=itemLink;
    itemWnd.pageY=popupHeight+vertSpace;
    itemWnd.dispText=itemText;
	itemWnd.dispHoverText=itemHoverText;
    itemWnd.bgColor=levelAttribs[4];
    itemWnd.clip.top=-vertSpace;
    itemWnd.clip.left=-vertSpace;
    var newHeight=itemWnd.document.height+2*vertSpace;
    itemWnd.resizeTo(popupWidth-2*bord,newHeight);
    itemWnd.visibility="inherit";
    return newHeight;
}

function createPopupFromCode(arrayName,level)
{
	var popupName=arrayName+"popup";
	var popup=eval("popupFrame.document."+popupName);
	if (popup)return popup;
	var levelAttribs;
	if (level > maxlev) {levelAttribs = eval ("lev" + maxlev) ;} else {levelAttribs = eval ("lev" + level) ;}
	eval("popupFrame.document."+popupName+"=new Layer(popupWidth,popupFrame)");
	popup=eval("popupFrame.document."+popupName);
	popup.level=level;
    popup.wid=popupName;
	popup.highlightColor=levelAttribs[5];
	popup.normalColor=levelAttribs[3];
	popup.highlightBgColor=levelAttribs[7];
	popup.normalBgColor=levelAttribs[4];
	popup.zIndex=maxZ;
	popup.bgColor=bord?borderCol:levelAttribs[4];
	addEvent(popup,"mouseout",onPopupOut,false);
	addEvent(popup,"mouseover",onPopupOver,false);
	var popupHeight=bord;
	var array=eval(arrayName);
	var arrayItem;
	var popupText="";
	for(arrayItem=0;arrayItem<array.length/3;arrayItem++)
	{
		var popupArray=(array[arrayItem*3+2])?(arrayName+"_"+parseInt(arrayItem+1)):null;
		popupHeight+=createMenuItem(popup,array[arrayItem*3+1],array[arrayItem*3],popupArray,levelAttribs,(arrayItem == array.length/3-1),popupHeight);
        popupHeight+=sep;
	}
	popupHeight+=bord;
    popup.resizeTo(popupWidth,popupHeight);
	popup.popupHeight=popupHeight;
	return popup;
}

function closePopup(popupId)
{
	if(popupId.indexOf('_')==-1){var hideWnd=eval("popupFrame.document.HideItem");if(hideWnd)hideWnd.visibility='show';}
	var popup=eval("popupFrame.document."+popupId);
	if (popup)
	{
		if (popup.expandedWnd) closePopup (popup.expandedWnd.wid);
		popup.visibility="hide";
	}
	if (activePopup && activePopup.wid==popupId) activePopup=null;
}

function absToRel(rect,refx,refy)
{
	var retval=new rct(rect.left-refx,rect.top-refy,rect.right-refx,rect.bottom-refy);
	return retval;
}

function openPopup(popup,x,y,bDontMove)
{
	if(popup.wid.indexOf('_')==-1){var hideWnd=eval("popupFrame.document.HideItem");if(hideWnd)hideWnd.visibility='hide';}
	popup.left=x;
	popup.top=y;
	popup.visibility="show";
	var browserRect=getBrowserRect(popupFrame);
	if(x+popupWidth>browserRect.right)popup.left=Math.max(0,browserRect.right-popupWidth-5-popup.level*20);
	if(y+popup.popupHeight>browserRect.bottom)popup.top=Math.max(0,browserRect.bottom-popup.popupHeight-5);
}

function isChildOfActivePopup(popup)
{
	var wnd=activePopup;
	while(wnd)
	{
		if (wnd.wid==popup.wid)
			return true;
		wnd=wnd.expandedWnd;
	}
	return false;
}

function onPopupOver()
{
	if (activePopup && isChildOfActivePopup (this)) clearTimeout(activePopupTimeout);
}

function onPopupOut()
{
	onPopupOutImpl(this);
}

function onPopupOutImpl(popup)
{
	if (mout && activePopup && isChildOfActivePopup (popup))
	{
		if (activePopupTimeout) clearTimeout (activePopupTimeout);
		activePopupTimeout=setTimeout("closePopup('"+activePopup.wid+"');", closeDelay);
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
	var left=doc.pageXOffset;
	var top=doc.pageYOffset;
	var right=left+doc.innerWidth;
	var bottom=top+doc.innerHeight;
	var retval=new rct(left,top,right,bottom);
	return retval;	
}

function getClientRect(wnd)
{
	var left=wnd.pageX;
	var top=wnd.pageY;
	var right=left+wnd.document.width;
	var bottom=top+wnd.document.height;
	var retval=new rct(left,top,right,bottom);
	return retval;
}

function onItemClick()
{
	var item=this;
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
				eval(item.url.substring(find));
			else
			{
				var mt=item.url.indexOf("mailto:");
				if(mt!=-1)window.location=item.url.substring(mt);
				else targetFrame.location=item.url;
			}
		}
		if(activePopup)closePopup(activePopup.id);
	}
    return false;
}

function onItemOver()
{
	var item=this;
	if (item.owner.expandedWnd)
	{
		closePopup(item.owner.expandedWnd.wid);
	}
	if (item.url&&item.url.indexOf("javascript:")==-1)
		window.status=item.url;
	else
		window.status="";
	item.bgColor=item.owner.highlightBgColor;
	if(mswnd)
	{
		item.document.write(item.dispHoverText);
		item.document.close();
	}
	if (item.popupArray)
	{
		var rect=getClientRect(item);
		var x=item.pageX+popupWidth-levelOffset;//right-levelOffset;
		var y=rect.top;
		var popup=createPopupFromCode(item.popupArray,item.owner.level+1);
		item.owner.expandedWnd=popup;
		openPopup(popup,x,y,false);
	}
}

function onItemOut()
{
	var item=this;
	if(mswnd)
	{
		item.document.write(item.dispText);
		item.document.close();
	}
	item.color=item.owner.normalColor;
	item.bgColor=item.owner.normalBgColor;
}

function expandMenu(popupId,refWnd,e)
{
	if(!docLoaded)return;
	clearTimeout(activePopupTimeout);
	if (activePopup&&activePopup.wid!=popupId+"popup")
		closePopup(activePopup.wid);
	if(popupId=='none')return;
	var posRef=document.layers[popupId+"top"];
	var rect=getClientRect(posRef);
	var x;
	var y;
	if(menuHorizontal)
	{
		x=rect.left;
		y=rect.bottom+1/*popupOffset*/;
	}
	else
	{
		x=rect.right+1/*popupOffset*/;
		y=rect.top;
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
	var popup=createPopupFromCode(popupId,0);
	openPopup(popup,x,y,true);
	activePopup=popup;
}

function collapseMenu(popupId)
{
	if(!docLoaded)return;
	var popup=eval("popupFrame.document."+popupId+"popup");
	if(popup)onPopupOutImpl(popup);
}

function expandMenuNS(popupId,e)
{
	expandMenu(popupId,e);
}

function collapseMenuNS(popupId)
{
	collapseMenu(popupId);
}

function onDocClick()
{
	if(activePopup)closePopup(activePopup.wid);
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
	eval("obj.on"+event+"="+fun);
}

function chgBg(item,color)
{
}

function initializeAll()
{
	var i;
	for(i=0;i<=document.lastLoadHandler;i++)
	{
		eval(document.loadHandlers[i]+'();');
	}
}