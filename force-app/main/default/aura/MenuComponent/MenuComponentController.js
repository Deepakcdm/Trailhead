({
	handleselect : function(component, event, helper) {
        var selectedItem=event.getParam("value");
        //alert(selectedItem+ "Feature is not available as of now...");
        $A.createComponent("c:ModalDialog",
                           {"title":"Message",
                            "body":"Feature is not available"},
                           function(myBox){
                               
                               //get reference to div tag
                            var modalDiv = component.find("modalDiv");
                               
                             //get copy of div body
                             var modalDivBody = modalDiv.get("v.body");
                               
                               //push component into the component of div body
                              modalDivBody.push(myBox);
                               
                               //set 
                            	modalDiv.set("v.body",modalDivBody);
                               
                           }
                          );
		
	}
})