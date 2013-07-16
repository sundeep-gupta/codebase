/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


window.onload = function(){
     $('#page').text("Loading...")
     $('#menu').load('jspf/Menu.jsp',{})
     $('#logo').load('jspf/Logo.jsp',{})
     $('#page').load("jspf/index.jsp",{})
     $('#footer').load('jspf/Footer.jsp',{})
};

