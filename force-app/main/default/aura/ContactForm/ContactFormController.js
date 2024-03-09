({
	onSubmit : function(component, event, helper) {
        //alert('hi');
        var cont=component.get("v.cont");
        helper.callServer(component,
                         "c.createcontact",
                         "v.status",
                          {"con":cont}
                         );
		
	},
    
    validateLastName : function(component, event, helper){
        var button=component.find("button");
        var cont=component.get("v.cont");
        if(cont.LastName.length>2){
            button.set("v.disabled",false);
        }
        else{
           button.set("v.disabled",true); 
        }
    }
})