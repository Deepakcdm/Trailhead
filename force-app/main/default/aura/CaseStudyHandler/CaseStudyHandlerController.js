({
	casestudy : function(component, event, helper) {
        var message=event.getParam("AccountList");
        
        message.setParams("Account received message:" +message);
        message.fire();
        
		
	}
})