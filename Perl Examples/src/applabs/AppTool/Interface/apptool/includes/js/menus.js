//
// Copyright:     AppLabs Technologies, 2006
// Created By:    Author: Jason Smallcanyon $
// Revision:      $Revision: $
// Last Modified: $Date: $
// Modified By:   $Author: $
// Source:        $Source: $
//



var xcNode = []; 

//
// xcSet() - Transforms <ul> elements into an expand/collapse list. Creates +/- controls with event triggers 
//           and adjusts classes to allow the menu style to be altered upon success.
// Input:  m - String: id of the menu items’ parent in the HTML source.
//         c - String: class name applied to menu items.
// Output: 
function xcSet(m, c) { 
    if (document.getElementById && document.createElement) {
        m = document.getElementById(m).getElementsByTagName('ul');
        var d, p, x, h, i, j;
        
        for (i = 0; i < m.length; i++) {
            if (d = m[i].getAttribute('id')) {
                xcCtrl(d, c, 'x', '[+]', 'Show', m[i].getAttribute('title')+' (expand menu)');
                x = xcCtrl(d, c, 'c', '[-]', 'Hide', m[i].getAttribute('title')+' (collapse menu)');
                
                p = m[i].parentNode;
                if (h = !p.className) {
                    j = 2;
                    while ((h = !(d == arguments[j])) && (j++ < arguments.length));
                    if (h) {
                        m[i].style.display = 'none';
                        x = xcNode[d+'x'];
                    }
                }
                
                p.className = c;
                p.insertBefore(x, p.firstChild);
            }
        }
    }
}

//
// xcShow() - Expands a menu that is collapsed. Causes an error if the supplied id is not an collapsed menu.
// Input:  m - String: id of menu item to show (expand).
// Output: 
function xcShow(m) {
    xcXC(m, 'block', m+'c', m+'x');
}

//
// xcHide() - Collapses a menu that is expanded. Causes an error if the supplied id is not an expanded menu.
// Input:  m - String: id of menu item to hide (collapse).
// Output: 
function xcHide(m) {
    xcXC(m, 'none', m+'x', m+'c');
}

//
// xcXC() - Internal function used by xcShow and xcHide to manage menu expand/collapse behaviour. Toggles 
//          the menu and related +/- node.
// Input:  e - Object: element to expand/collapse.
//         d - String: style.display value: 'block' or 'none'.
//         s - String: id of +/- node to display.
//         h - String: id of +/- node to hide.
// Output: 
function xcXC(e, d, s, h) {
    e = document.getElementById(e);
    e.style.display = d;
    e.parentNode.replaceChild(xcNode[s], xcNode[h]);
    xcNode[s].firstChild.focus();
}

//
// xcCtrl() - Internal function used by xcSet to create the +/- controls.
// Input:  m - String: id of menu item.
//         c - String: class name for custom styles.
//         s - String: 'x' or 'c' suffix for node id and class name c.
//         v - String: control text value: '[+]' or '[-]'.
//         f - String: function name 'Show' or 'Hide' event trigger (xcShow or xcHide).
//         t - String: node’s title attribute.
// Output: 
function xcCtrl(m, c, s, v, f, t) {
    var a = document.createElement('a');
    a.setAttribute('href', 'javascript:xc'+f+'(\''+m+'\');');
    a.setAttribute('title', t);
    a.appendChild(document.createTextNode(v));
    
    var d = document.createElement('div');
    d.className = c+s;
    d.appendChild(a);
    
    return xcNode[m+s] = d;
}


