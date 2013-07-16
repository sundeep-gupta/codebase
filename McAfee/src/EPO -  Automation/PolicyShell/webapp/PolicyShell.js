function init(){
	OrionEvent.registerHandlerById("policyshell_productId", selectionChange, null, "change", true);
	OrionEvent.registerHandlerById("policyshell_typeId", selectionChange, null, "change", true);
	OrionEvent.registerHandlerById("policyshell_poId", selectionChange, null, "change", true);
	OrionEvent.registerHandlerById("policyshell_settingId", selectionChange, null, "change", true);

	OrionEvent.registerHandlerById("policyshell_applyChanges", apply, null, "click", true);

}

function selectionChange(){
	//ajax call to repopulate the type list
	OrionCore.doAsyncFormAction("/PolicyShell/Refresh.do", null, refreshHandler);
}

function apply(){
	OrionCore.doAsyncFormAction("/PolicyShell/Apply.do", null, refreshHandler);
}

function refreshHandler(result){
//	var content = document.getElementById("contentPane");
	var content = document.getElementById("orionRootContentID");
	content.innerHTML = result;

	//now we need to execute all script elements in the new content
	execScripts(content);

	//re-register event handlers
	init();
	OrionCore.fireResizeEvent();
}

function execScripts(elem){
	if(elem.tagName.toLowerCase() == "script"){
		elem.normalize();
		eval(elem.firstChild.nodeValue);
	}else{
		var childElem = elem.firstChild;
		while(childElem != null){
			if(childElem.nodeType == 1){ // is element
				execScripts(childElem);
			}
			childElem = childElem.nextSibling;
		}
	}
}