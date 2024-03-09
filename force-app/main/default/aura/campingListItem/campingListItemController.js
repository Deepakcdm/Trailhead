({
    packItem : function(component, event, helper) {
        var btn = event.getSource();
        btn.set("v.disabled",true);
        component.set("v.item.Packed__c", "true");
    }
})