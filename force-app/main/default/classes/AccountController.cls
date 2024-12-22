/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 12-16-2024
 * @last modified by  : Deepak
**/
public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Industry, NumberOfEmployees FROM Account WITH SECURITY_ENFORCED LIMIT 10];
    }
}