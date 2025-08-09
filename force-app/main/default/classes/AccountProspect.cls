/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 10-18-2024
 * @last modified by  : Deepak
**/
public with sharing class AccountProspect {

  /**
  * @description 
  * @author Deepak | 10-18-2024 
  * @return List<Account> 
  **/
  @auraenabled
  public static List<Account> fetchAllAccounts() {
    return [SELECT Name, Type, Industry FROM Account WITH USER_MODE  LIMIT 10];
  }


  /**
  * @description 
  * @author Deepak | 10-18-2024 
  * @return List<Account> 
  **/
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