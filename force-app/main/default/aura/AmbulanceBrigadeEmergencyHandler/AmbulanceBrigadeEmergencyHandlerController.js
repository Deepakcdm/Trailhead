({
    
    handleEmergency : function(component, event, helper) {
        //Get param for Event
        var message = event.getParam("message");
        //Take Action
        alert("Ambulance Brigade received message :"+message);
    }

	
})