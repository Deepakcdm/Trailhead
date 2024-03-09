/**
 * @description       :
 * @author            : Deepak Kumar
 * @group             :
 * @Created on  : 03-09-2024
 **/
public with sharing class AccountTriggerHandler {
  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   * @param accList
   **/
  public static void createAccounts(List<Account> accList) {
    for (Account acct : accList) {
      acct.ShippingState = acct.BillingState;
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void copyShippingAddress(List<Account> newAccts,Map<Id, Account> oldAccMap) {
    try {
      for (Account acct : newAccts) {
        Boolean billingStreetChanged = (acct.BillingStreet != oldAccMap.get(acct.Id)?.BillingStreet ? True : False);
        Boolean billingCityChanged = (acct.BillingCity != oldAccMap.get(acct.Id)?.BillingCity ? True : False);
        Boolean billingStateChanged = (acct.BillingState != oldAccMap.get(acct.Id)?.BillingState ? True : False);
        Boolean billingCountryChanged = (acct.BillingCountry != oldAccMap.get(acct.Id)?.BillingCountry ? True : False);
        Boolean billingPostalCodeChanged = (acct.BillingPostalCode != oldAccMap.get(acct.Id)?.BillingPostalCode ? True : False);

        if (billingStreetChanged || billingCityChanged || billingStateChanged || billingCountryChanged || billingPostalCodeChanged) {
          acct.ShippingStreet = oldAccMap.get(acct.Id)?.BillingStreet;
          acct.ShippingCity = oldAccMap.get(acct.Id)?.BillingCity;
          acct.ShippingState = oldAccMap.get(acct.Id)?.BillingState;
          acct.ShippingCountry = oldAccMap.get(acct.Id)?.BillingCountry;
          acct.ShippingPostalCode = oldAccMap.get(acct.Id)?.BillingPostalCode;
        }
      }
    } catch (exception e) {
      system.debug('There is an Error'+ e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictDuplicateAccounts(List<Account> newAccts, Map<Id,Account> oldAccMap) {
    try {
  }catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictNonAdminAccCreate(List<Account> newAccts) {
    try {
      String currentProfileName = [Select Id,Name from Profile Where Id =:UserInfo.getProfileId()]?.Name;
      if(currentProfileName != 'System Administrator'){
        for(Account acct : newAccts){
          acct.addError('No Non-Admin Profiles are allowed to create an Account');
        }
      }
    }catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictAccWithTwoContacts(Map<Id,Account> acctsMap) {
    try {
      Map<Id,Account> acctContactMap = new Map<Id,Account>([Select Id,(Select Id from Contacts) from Account Where Id IN :acctsMap.keySet()]);
      for(Account acct : acctsMap.values()){
        if(acctContactMap.containskey(acct.Id) && acctContactMap.get(acct.Id)?.Contacts!= null && acctContactMap.get(acct.Id)?.Contacts?.size() > 2){
          acct.addError('You cannot delete the Account with more than 2 Child Contacts');
        }
      }
    }catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictAccWithContacts(Map<Id,Account> acctsMap) {
    try {
      Map<Id,Account> acctContactMap = new Map<Id,Account>([Select Id,(Select Id from Contacts) from Account Where Id IN :acctsMap.keySet()]);
      for(Account acct : acctsMap.values()){
        if(acctContactMap.containskey(acct.Id) && acctContactMap.get(acct.Id)?.Contacts!= null && acctContactMap.get(acct.Id)?.Contacts?.size() > 0){
          acct.addError('You cannot delete the Account with Child Contacts');
        }
      }
    }catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictAccwithParentAcc(Map<Id,Account> oldAccMap) {
    try {
      for(Account acct : oldAccMap.values()){
        if(acct.parentId!= null){
          acct.addError('You cannot delete Accounts associated with Parent Account');
        }
      }
    } catch (exception e) {
      system.debug(e.getMessage());
    }
  }
}
