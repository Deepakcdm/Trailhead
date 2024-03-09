({
	InformHandler : function(component, event, helper) {
        //1.Get Reference to Event
        var crime = component.getEvent("crime");
        //2. Set parameters
        crime.setParams({"message":"Dawood is coming to city"});
        //3.Fire Event
        crime.fire();
		
	}
})