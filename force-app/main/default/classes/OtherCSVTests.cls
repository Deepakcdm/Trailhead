@isTest
private class OtherCSVTests {
   
    @Testsetup
    static void loadTestDataFromStaticResource(){
     List<sObject> accounts = Test.loadData(Account.SObjectType, 'otherAccountData');
    }
    
    @istest static void testLoadOtherAccountsFromStaticResource(){
        Test.StartTest();
        List<Account> accts = [Select Id from Account];
        Test.StopTest();
        Assert.areEqual(15,accts.size(),'Accounts not retrived from Static Resource');
    }

}