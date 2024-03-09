({
	callServer : function(component,methodName,attributeName,params) {
        //alert("inside,,,,");
        var methodRef = component.get(methodName);
        //2. set the parameters,if any 
        if(params){
            methodRef.setParams(params);
        }
        
        methodRef.setCallback(this,function(response){
         var responseState=response.getState();
        if(responseState=="SUCCESS")
        {
            var result=response.getReturnValue();
            component.set(attributeName,result);
        }
        });
    $A.enqueueAction(methodRef);
}
 })