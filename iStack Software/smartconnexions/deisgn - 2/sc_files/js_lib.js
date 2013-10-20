function confirmDelete()
{
    var agree=confirm("Are you sure you wish to delete this entry?");
    if (agree)
        return true;
    else
        return false;
}

function openWindow(url,winName,features) {
window.open(url,'','toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=1,resizable=0,width=640,height=540,left = 25,top = 25');
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,'','toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=1,resizable=0,width=640,height=540,left = 25,top = 25');
}

function openCustom(URL,name,w,h){ 
	
		myW = 'width=' + w + ',';
		myH = 'height=' + h + ',';
		
		params = 'toolbars=1, scrollbars=0, location=0, statusbars=0, menubars=1, resizable=0';
			

		window.open(URL,name,myW + myH + params); 
}

function openC2(URL,name,w,h,p){ 
	
		myW = 'width=' + w + ',';
		myH = 'height=' + h + ',';
		
		params = p + 'toolbars=1, location=0, statusbars=0, menubars=1, resizable=0';
			

		window.open(URL,name,myW + myH + params); 
}

function openPopup(url,winName,features) {
	if (features.length > 0)
	{
		window.open(url,'',features);
	}
	else
	{
	window.open(theURL,'','toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=1,resizable=0,width=640,height=540,left = 25,top = 25');
	}
}

<!-- This script and many more are available free online at -->
<!-- The JavaScript Source!! http://javascript.internet.com -->
<!-- Original:  Russ (NewXS3@aol.com) -->
<!-- Web Site:  http://dblast.cjb.net -->

function copyit(theField) {
var tempval=eval("document."+theField)
tempval.focus()
tempval.select()
therange=tempval.createTextRange()
therange.execCommand("Copy")
}

function blockError(){
	return true;
}
window.onerror = blockError;
