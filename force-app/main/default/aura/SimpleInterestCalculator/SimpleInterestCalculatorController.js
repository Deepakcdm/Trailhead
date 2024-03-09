({
	calculateInterest : function(component, event, helper) {
		var amount=component.get("v.principal") * component.get("v.interestrate") * component.get("v.timeperiod");
        var totalAmount = parseInt(component.get("v.principal"))+parseInt(amount);
        component.set("v.amount",totalAmount);
	}
})