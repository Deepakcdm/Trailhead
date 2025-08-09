@istest(SeeAllData=false)
private class TaskUtilTests {
    
    @istest static void testGetTaskPriorityNormal (){
        Test.StartTest();
        string priority = TaskUtil.getTaskPriority('IL');
        Test.StopTest();
        Assert.areEqual('Normal',priority,'Not an Expected State');
    }
    
    @istest static void testGetTaskPriorityHigh(){
        Test.StartTest();
        string priority = TaskUtil.getTaskPriority('CA');
        Test.StopTest();
        Assert.areEqual('High',priority,'Not an Expected State');
    }
}