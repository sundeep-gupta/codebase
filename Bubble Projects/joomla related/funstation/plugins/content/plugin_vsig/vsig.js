// "Very Simple Image Gallery" Plugin for Joomla 1.5 - Version 1.5.2
// License: http://www.gnu.org/copyleft/gpl.html
// Author: Andreas Berger - http://www.bretteleben.de
// Copyright (c) 2009 Andreas Berger - andreas_berger@bretteleben.de
// Project page and Demo at http://www.bretteleben.de
// ***Last update: 2009-12-05***

//dom
function vsig_dom(obj){return document.getElementById(obj);}

//switch without reload
function switchimg(t_ident) {
	//replace &#39; with ' in alt-title
	t_ident[7] = t_ident[7].replace(/&#39;/g, "'");
	//replace &amp;amp; with &amp; in alt-title
	t_ident[7] = t_ident[7].replace(/&amp;/g, "&");
	//switch caption
	var t_cap=vsig_dom(t_ident[0]).parentNode.getElementsByTagName("div");
	if(t_cap.length>=1){
		t_cap[0].innerHTML=(t_ident[2]!=""||t_ident[3]!="")?("<span>"+t_ident[2]+"</span><span>"+t_ident[3]+"</span>"):"";
	}
	//switch link
	if(typeof($(t_ident[0]).parentNode.href)!="undefined"){
		vsig_dom(t_ident[0]).parentNode.href=t_ident[4];
		vsig_dom(t_ident[0]).parentNode.title=t_ident[5];
		vsig_dom(t_ident[0]).parentNode.target=t_ident[6];
		}
	//switch image
	vsig_dom(t_ident[0]).src=t_ident[1];
	vsig_dom(t_ident[0]).alt=t_ident[7];
	vsig_dom(t_ident[0]).title=t_ident[7];
}

//switch set
function switchset(s_ident,s_start,s_number) {
	var ev_ident=eval(s_ident);
	var sets_total=Math.ceil(ev_ident.length/s_number);
	var sets_current=s_start/s_number+1;
	//button back
	vsig_dom('bback'+s_ident).href = "#g_"+s_ident;
	if(sets_current>=2){vsig_dom('bback'+s_ident).onclick = function(){switchset(s_ident,(s_start-s_number)*1,s_number);return false;}}
	else{vsig_dom('bback'+s_ident).onclick = function(){return false;}}
	//button forward
	vsig_dom('bfwd'+s_ident).href = "#g_"+s_ident;
	if(sets_current<=sets_total-1){vsig_dom('bfwd'+s_ident).onclick = function(){switchset(s_ident,(s_start+s_number)*1,s_number);return false;}}
	else{vsig_dom('bfwd'+s_ident).onclick = function(){return false;}}
	//set counter
	vsig_dom('counter'+s_ident).innerHTML="&nbsp;"+sets_current+"/"+sets_total;
	//switch main image
	if(s_start<=ev_ident.length&&s_start>=0){
		switchimg(ev_ident[s_start]);
	}
	if(s_number>=2){
		//thumb ändern
		var a;
		for (a=1;a<=s_number;a++){
			if(ev_ident[s_start+a-1]){
				var b=eval(s_start+a-1);
				var obj=vsig_dom('thb'+s_ident+'_'+a);
				obj.style.visibility="visible";
				obj.getElementsByTagName("img")[0].src = ev_ident[b][8];
				obj.getElementsByTagName("img")[0].alt = ev_ident[b][7];
				obj.getElementsByTagName("a")[0].title = ev_ident[b][7];
				obj.getElementsByTagName("a")[0].href = '';
				obj.getElementsByTagName("a")[0].b=b;
				obj.getElementsByTagName("a")[0].onclick = function(){switchimg(ev_ident[this.b]);return false;}
			}
			else{
				vsig_dom('thb'+s_ident+'_'+a).style.visibility="hidden";
			}
		}
	}
}