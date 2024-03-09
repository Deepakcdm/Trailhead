({
	search : function(component, event, helper) {
        var casestudy = component.getEvent("v.AccountInput");
        casestudy.setParams({"AccountInput":"Response is received"});
        casestudy.fire();
		
	}
})