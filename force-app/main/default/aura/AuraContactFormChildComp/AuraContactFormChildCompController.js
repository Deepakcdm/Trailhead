({
    createNewComponent : function(component, event, helper) {
        alert('New Component has to be created');
        helper.createComponent(component, event, helper);
    },

    deleteComponent : function(component, event, helper){
        alert('Component Has to be deleted');
        helper.deleteNewComponent(component, event, helper);
    }
})