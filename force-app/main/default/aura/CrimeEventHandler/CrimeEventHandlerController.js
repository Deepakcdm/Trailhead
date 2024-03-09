({
	handleCrime : function(component, event, helper) {
        //1. Get Param
       var message = event.getParam("message");
        
       
        //2. Take Action
        alert("Received message from informer:"+message);
		
	}
})