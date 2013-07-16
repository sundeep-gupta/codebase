# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 251 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/tWa.al)"
sub tWa{
return qq@
<script type="text/javascript">
<!--
var ab_newin=null;
function newWindow(nH, myname, w, h, scroll) {
w=(screen.width)?screen.width*w: 620;
h=(screen.height)?screen.height*h:420;
LeftPos=(screen.height)?screen.width-w-200:0;
TopPos=(screen.height)?100:0;
settings='height='+h+',width='+w+',top='+TopPos+',left='+LeftPos+',scrollbars='+scroll+',resizable';
var ab_newin = window[myname];
if(ab_newin==null || ab_newin.closed) {
	ab_newin=window.open(nH, myname, settings);
	window[myname]=ab_newin;
}else {

	ab_newin.location=nH;
}

ab_newin.focus();
if(nH == null) return ab_newin;
}

function changeStyle(ele, sty) {
	ele.className=sty;
}

function setCssPropByID(eid, prop, val) {
	var ele = document.getElementById(eid);
	if(ele!=null) ele.style[prop]=val;

}

function submitButtonClicked(btn) {
	btn.className='clickedButtonStyle';
 if(!btn.disabled) {
		if(btn.form.target == window.name) {
			btn.value= "$sVa::please_wait_label";
			window._tmfunc = function() { btn.form.submit(); }
			btn.disabled = true;
			setTimeout("_tmfunc()", 350);
			return false;
		}else {
			return true;
		}
	}else {
		return false;
	}
}

var cm=null;
var cobj=null;
document.onclick = new Function("hide_m()");

function getPos(el,sProp) {
	var iPos = 0
	while (el!=null) {
		iPos+=el["offset" + sProp]
		el = el.offsetParent
	}
	return iPos

}

var tid = null;
function hide_m() {
	if(cm!=null) {
		 cm.style.display='none';
	}
	cm = null;
}

function show_m(el,mn) {
 var m = document.getElementById(mn);
	if(el==null) {
		el = cobj;
	}
	if(m && m == cm) {
		clearTimeout(tid);
		tid = null;
	}else {
		if (cm != null) {
			clearTimeout(tid);
			tid = null;
			hide_m();
		}
	}

	if (m) {
		m.style.display='';
		m.style.pixelLeft = getPos(el,"Left") + 4;
		m.style.pixelTop = getPos(el,"Top") + el.offsetHeight +0;
	}
	cm=m;
	cobj=el;
}

function out_m(mn) {
 var m = document.getElementById(mn);
	if(m!=null) {
		tid = window.setTimeout('hide_m()', 550);
		
	} 
	cm=m;
}

//-->
</script>
@;

}

# end of sVa::tWa
1;
