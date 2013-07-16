/*
 * menuExpandable3.js - implements an expandable menu based on a HTML list
 * Author: Dave Lindquist (http://www.gazingus.org)
 */
 
 /*
    modified by Rich Corbridge to allow for persistence.  the idea and the cookie
    functions were pulled from the treeview component found at http://www.treemenu.net
 */

if (!document.getElementById)
    document.getElementById = function() { return null; }
    
if (window.cookieName == undefined)
	cookieName = 'openMenus';

function initializeMenu(menuId, actuatorId) {
    var menu = document.getElementById(menuId);
    var actuator = document.getElementById(actuatorId);
    var items = getCookie(cookieName);
    
    if (items[actuator.id] == 1) {
       menu.style.display = "block";
	    actuator.parentNode.style.backgroundImage = "url(/graphics/minus.gif)";
    } else {
       menu.style.display = "none";
	    actuator.parentNode.style.backgroundImage = "url(/graphics/plus.gif)";
    }
    if (menu == null || actuator == null) return;

    //if (window.opera) return; // I'm too tired
    actuator.onclick = function() {
		//the first thing i need to to regardless of the new state is get the cookie
      var items = getCookie(cookieName);
                  
        var display = menu.style.display;
        if (display == "block") {
          //here i need to remove the item, and any children from the list of open menus
          var len = this.id.length;
          
          var newitems = new Array();
          for (var key in items) {
            if (key != this.id)
          	//if (key.substring(0, len) != this.id)
            	newitems[key] = 1;
          }
          setCookie(cookieName, newitems);
          this.parentNode.style.backgroundImage = "url(/graphics/plus.gif)";
          menu.style.display = "none";         }
        else {
          //add the item onto the list of open items and set the cookie
          items[this.id] = 1;
          setCookie(cookieName, items);
          this.parentNode.style.backgroundImage = "url(/graphics/minus.gif)";
          menu.style.display = "block";
        }
        return false;
    }
}

function setCookie(name, items) {
	//first reformat the value
   var tmp = new Array();
   var x = 0;
   for (var key in items)
   	tmp[x++] = key;
      
    document.cookie= name + "=" + escape(tmp.join(":"));
}

/**
 * Gets the value of the specified cookie.
 *
 * name  Name of the desired cookie.
 *
 * Returns a string containing value of specified cookie,
 *   or null if cookie does not exist.
 */
function getCookie(name)
{
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1)
    {
        begin = dc.indexOf(prefix);
        if (begin != 0) return new Array();
    }
    else
    {
        begin += 2;
    }
    var end = document.cookie.indexOf(";", begin);
    if (end == -1)
    {
        end = dc.length;
    }
    var str = unescape(dc.substring(begin + prefix.length, end));
    
    //now format that into a hash
    if (str != "") {
    	var ret = new Array();
      var ar = str.split(":");
      for(var x=0;x<ar.length;x++)
      	ret[ar[x]] = 1;
      return ret
    } else {
    	return new Array();
    }
}
