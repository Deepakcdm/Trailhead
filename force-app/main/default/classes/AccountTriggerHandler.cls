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
  public static void copyShippingAddress() {
    try {
    } catch (exception e) {
      system.debug(e.getMessage());
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
