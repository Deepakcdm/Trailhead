({
	getallacc : function(component, event, helper) {
	//1.Get reference to the Server-Side Apex method
	helper.callServer(component,"c.fetchAllAccounts","v.accountlist");
    },

	getallprospects : function(component, event, helper) {
	helper.callServer(component,"c.fetchAllProspects","v.accountlist");
    }
})