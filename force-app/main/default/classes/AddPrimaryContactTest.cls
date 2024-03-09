@isTest
public with sharing class AddPrimaryContactTest {

    @isTest private Static void contactCreateTest(){
        Contact cont = new Contact(FirstName='Deepak',LastName='Kumar');
        insert cont;

        List<Account>acctList = new List<Account>();
        for(integer i=1;i<=50;i++){
            Account acct = new Account(Name='Test Account '+i,BillingState='NY');
            acctList.add(acct);
        }

        for(integer i=51;i<=100;i++){
            Account acct = new Account(Name='Test Account '+i,BillingState='CA');
            acctList.add(acct);
        }
        Database.insert(acctList,false);

        AddPrimaryContact updateJob = new AddPrimaryContact(cont,'CA');

        Test.StartTest();
        System.enqueueJob(updateJob);
        Test.StopTest();
    }
}