({
	handleclick : function(component, event, helper) {
        
        for(var i=1;i<=3;i++){
            var btn= component.find(i);
            btn.set("v.variant","neutral");
            }
    var buttonclick=event.getSource();
        buttonclick.set("v.variant","brand")
   // var buttonclicklabel= buttonclick.get("v.label");
    //alert("you clicked on "+buttonclickl);
          }
})