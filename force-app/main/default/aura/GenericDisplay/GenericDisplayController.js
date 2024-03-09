({
	viewRec : function(component, event, helper) {
        
        var sid= component.get("v.sid");
        
        var eventRef = $A.get("e.force:navigateToSObject");
        if(eventRef){
            eventRef.setParams({"recordId":sid});
            //set params
            //fire event
            eventRef.fire();
        } else{
            alert("please use LEX or Salesforce 1 mobile app for this operation");
        }
		
	},
    
    editrec : function(component, event, helper) {
       
        
        var sid= component.get("v.sid");
        
        var eventRef = $A.get("e.force:navigateToSObject");
        if(eventRef){
            eventRef.setParams({"recordId":sid});
            //set params
            //fire event
            eventRef.fire();
        } else{
            alert("please use LEX or Salesforce 1 mobile app for this operation");
        }

		
	}
})