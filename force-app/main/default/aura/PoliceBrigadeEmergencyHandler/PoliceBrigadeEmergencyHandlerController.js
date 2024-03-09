({
    
    handleEmergency : function(component, event, helper) {
        //Get param for Event
        var message = event.getParam("message");
        //Take Action
        alert("Police BRigade received message :"+message);
    }
	
})