({
	handleclick : function(component, event, helper) {
        
        for(var i=1;i<=2;i++){
            var btn= component.find(i);
            btn.set("v.variant","neutral");
            }
        
        
    var buttonclick=event.getSource();
        buttonclick.set("v.variant","brand")
        
           var deepakdiv=component.find("deepakdiv");
        var dineshdiv=component.find("dineshdiv");

        
               //get Label for both button that is clicked
       var buttonclicklabel=buttonclick.get("v.label");
        if(buttonclicklabel=="Deepak")
        {
          $A.util.removeClass(deepakdiv,"slds-hide");
          $A.util.addClass(dineshdiv,"slds-hide");  
        }else{
               $A.util.removeClass(dineshdiv,"slds-hide");
          $A.util.addClass(deepakdiv,"slds-hide"); 
        }
         }
          
})