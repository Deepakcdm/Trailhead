({
	handleEmergency : function(component, event, helper) {
        //Get param for Event
        var message = event.getParam("message");
        //Take Action
        alert("Fire BRigade received message :"+message);
		
	}
})