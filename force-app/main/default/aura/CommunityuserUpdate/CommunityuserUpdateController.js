({
	doInit : function(component, event, helper) {
		var currentuserId = $A.get("$SObjectType.CurrentUser.Id");
        component.set("v.userId",currentuserId);
	}
})