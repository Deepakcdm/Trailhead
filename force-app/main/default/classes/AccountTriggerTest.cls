/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 09-29-2024
 * @last modified by  : Deepak
**/
@isTest
public with sharing class AccountTriggerTest {

    /**
    * @description 
    * @author Deepak | 09-29-2024 
    **/
    @isTest private static void testCreateAccounts(){
        List<Account>accList = new List<Account>();
        for(integer i=0;i<=200;i++){
            Account acc = new Account(Name='Test Account '+i,BillingState='CA');
            accList.add(acc);
        }
        insert accList;
    }
    
    /**
    * @description 
    * @author Deepak | 09-29-2024 
    **/
    @isTest Static void createAccounts(){
        Account acct = new Account();
        acct.Name='Test Account';
        acct.First_Name__c='Deepak';
        acct.Last_Name__c='Kumar';
        insert acct;
    }
}