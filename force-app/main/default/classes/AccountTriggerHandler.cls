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
  public static void restrictDuplicateAccounts() {
    try {
    } catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictNonAdminAccCreate() {
    try {
    } catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictAccWithTwoContacts() {
    try {
    } catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictAccWithContacts() {
    try {
    } catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictClosedOppUpdate() {
    try {
    } catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void restrictAccwithParentAcc() {
    try {
    } catch (exception e) {
      system.debug(e.getMessage());
    }
  }

  /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void updateCaseofEmailOrigin() {
    try {
    } catch (exception e) {
      system.debug(e.getMessage());
    }
  }
}
