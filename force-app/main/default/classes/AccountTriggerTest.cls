@isTest
public with sharing class AccountTriggerTest {

    @isTest private static void testCreateAccounts(){
        List<Account>accList = new List<Account>();
        for(integer i=0;i<=200;i++){
            Account acc = new Account(Name='Test Account '+i,BillingState='CA');
            accList.add(acc);
        }
        insert accList;
    }
    
    @isTest Static void createAccounts(){
        Account acct = new Account();
        acct.Name='Test Account';
        acct.First_Name__c='Deepak';
        acct.Last_Name__c='Kumar';
        insert acct;
    }
}