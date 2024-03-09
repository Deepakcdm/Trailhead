({
	add : function(component, event, helper) {
        
        var firstnumber=component.get("v.value1");
        var secondnumber=component.get("v.value2");
        var result= parseInt(firstnumber) + parseInt(secondnumber);
        component.set("v.result",result);
       //alert("from add :"+result);
        
	},
    sub : function(component, event, helper) {
		
        var firstnumber=component.get("v.value1");
        var secondnumber=component.get("v.value2");
        var result= firstnumber - secondnumber;
        component.set("v.result",result);
        //alert("from add :"+result);
	},
    multiply : function(component, event, helper) {
		
        var firstnumber=component.get("v.value1");
        var secondnumber=component.get("v.value2");
        var result= firstnumber * secondnumber;
        component.set("v.result",result);
        //alert("from add :"+result);
	},
    div : function(component, event, helper) {
		
        var firstnumber=component.get("v.value1");
        var secondnumber=component.get("v.value2");
        var result= firstnumber / secondnumber;
        component.set("v.result",result);
        //alert("from add :"+result);
	},
})