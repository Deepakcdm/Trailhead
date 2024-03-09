({
	createRecord : function(component, event, helper) {
		var createcaseEvent = $A.get("e.force:createRecord");
        createcaseEvent.setParams({
            "entityApiName": "Case",
            "defaultFieldValues": {
                'Subject' :'Test Case from Custom Lightning Component',
                'Description': 'Test Case Description',
                'Status':'New',
                'Reason':'Installation'
            }
});
createcaseEvent.fire();
	}
})