({
	doInit : function(component, event, helper) {
		var todaysDate = new Date();
         component.set("v.todaysDate",$A.localizationService.formatDate(todaysDate , "YYYY-MM-DD"));
	},
    
    calculateAge: function(component,event,helper){
        var inputCmp = component.find("dob");
        var dob = component.get("v.dob");
        var dobdate = $A.localizationService.formatDate(dob , "YYYY-MM-DD");
        var dobyear = new Date(dobdate).getFullYear();
        var dobdd = new Date(dobdate).getDate();
        var dobmm = new Date(dobdate).getMonth()+1;
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();
        if(mm >= dobmm && dd >= dobdd){
            var diffage= yyyy - dobyear;
        }
        else if((dobmm === mm && dd < dobdd) || (mm < dobmm && dd < dobdd)){
            var diffage = (yyyy - dobyear) - 1;
        }
        component.set("v.age",diffage);
        
        if(diffage < 18){
         
         inputCmp.setCustomValidity('your age must be above 18');
            
        }
        else{
            inputCmp.setCustomValidity('');
        }
        inputCmp.reportValidity();
    },
    
    validate: function(component,event,helper){
        
    }
})