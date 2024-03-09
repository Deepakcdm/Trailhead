({
    createComponent : function(component, event, helper) {
        alert('Call comes insde helper');
        $A.createComponents([
            ["lightning:card",{
                        "title" : "Dynamic Components"
                    }],
                    ["lightning:icon",{
                        "iconName" : "utility:success",
                        "alternativeText": "Icon that represents a successful step",
                        "variant": "success",
                        "class": "slds-m-around_small"
                    }]
            ],
                            function(components, status, errorMessage){
                                if (status === "SUCCESS") {
                                    var body = component.get("v.body");
                                    components.forEach(function(item){
                                        body.push(item);
                                    });
                                    component.set("v.body", body);
                                }
                                else if (status === "INCOMPLETE") {
                                    console.log("No response from server or client is offline.")
                                }
                                    else if (status === "ERROR") {
                                        console.log("Error: " + errorMessage);
                                    }
                            }
                           );
    },

    deleteNewComponent : function(component ,event, helper){
      var body = component.get("v.body");
      body.shift();
      component.set("v.body",body);
    }
})