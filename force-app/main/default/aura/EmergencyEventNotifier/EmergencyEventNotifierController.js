({
	dial911 : function(component, event, helper) {
        
        //1.Get reference for the Event using $A.get
        var emergencyEvent=$A.get("e.c:EmergencyEvent");
        
        //2. Set params in Json Format
        emergencyEvent.setParams({"message":"House on Fire...."})
        
        //3. Fire Events
        emergencyEvent.fire();
        
		
	}
})