function BubbleAJAX() {
  this.xmlHttp = null;
  if(window.ActiveXObject) {
    try {
      this.xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (e) {
      this.xmlHttp = false;
    }
  } else { // if running Mozilla or other browsers
    try {
      this.xmlHttp = new XMLHttpRequest();
    } catch (e) {
      this.xmlHttp = false;
    }
  }
// return the created object or display an error message
  if (!this.xmlHttp)
     alert("Error creating the XMLHttpRequest object.");
}

BubbleAJAX.prototype.isReadyState = function(state) {
  return this.xmlHttp.readyState == state ;
}

BubbleAJAX.prototype.isStatus = function(s) {
  return this.xmlHttp.status == s ;
}

BubbleAJAX.prototype.responseText = function() {
  return this.xmlHttp.responseText;
}


BubbleAJAX.prototype.responseXML = function() {
  return this.xmlHttp.responseXML;
}

BubbleAJAX.prototype.statusText = function() {
  return this.xmlHttp.statusText;
}