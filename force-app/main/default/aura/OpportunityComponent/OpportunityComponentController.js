({
	getAllops : function(component, event, helper) {
	//1.Get reference to the Server-Side Apex method
	component.display(component, event, helper);
	helper.callServer(component,"c.fetchAllOpportunities","v.opportunitylist");
    },

	getWonops : function(component, event, helper) {
        component.display(component, event, helper);
	helper.callServer(component,"c.fetchWonOpportunities","v.opportunitylist");
    },
    
    displayToast:function(component,event,helper){
        var toastEvent = $A.get("e.force:showToast");
        if(toastEvent){
            toastEvent.setParams({"message":"Opportunities are getting loaded",
                                  "title" : "Opportunities List",
                                  "type" : "Success"
                                 });
            toastEvent.fire();
        }else{
            alert("Opportunities are not getting overloaded");
        }
    },
    
    showSpinner:function(component,event,helper){
        //Get reference to spinner
        var spinner = component.find("spinner");
        $A.util.removeClass(spinner,"slds-hide");
        
    },
    
    hideSpinner:function(component,event,helper){
        //Get reference to spinner
        var spinner = component.find("spinner");
        $A.util.addClass(spinner,"slds-hide");
        
    },
})