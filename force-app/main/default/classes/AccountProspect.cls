/**
 * description : AccountProspect
 */
public with sharing class AccountProspect {
  /**
   * description : fetchAllAccounts
   * return : returns the list of Accounts
   */
  @auraenabled
  public static List<Account> fetchAllAccounts() {
    return [SELECT Name, Type, Industry FROM Account WITH USER_MODE];
  }

  /**
   * description : fetchAllAccounts
   * return : returns the list of Accounts
   */
  @auraenabled
  public static List<Account> fetchAllProspects() {
    return [
      SELECT Name, Type, Industry
      FROM Account
      WHERE Type = 'Prospect'
      WITH USER_MODE
    ];
  }
}
