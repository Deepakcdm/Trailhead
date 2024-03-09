/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 03-09-2024
**/
public with sharing class CaseTriggerHandler {
      /**
   * @description
   * @author Deepak Kumar | 03-09-2024
   **/
  public static void updateCaseofEmailOrigin(List<Case> newCases) {
    try {
        for(Case newCase : newCases){
            if('Email'.equalsIgnoreCase(newCase.Origin)){
                newCase.Status = 'New';
                newCase.Priority = 'Medium';
            }
        }
    } catch (exception e) {
      system.debug(e.getMessage());
    }
  }
}