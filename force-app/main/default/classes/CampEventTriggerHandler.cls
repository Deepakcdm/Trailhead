/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 03-29-2025
 * @last modified by  : Deepak
**/
public with sharing class CampEventTriggerHandler {

    /**
    * @description 
    * @author Deepak | 03-29-2025 
    **/
    public static void updateCampEventNetRevenue(List<CAMPX__Event__c> newEvents, Map<Id,CAMPX__Event__c> oldEvents){
        for(CAMPX__Event__c event : newEvents){
            if(oldEvents==null || (event.CAMPX__GrossRevenue__c != oldEvents.get(event.Id)?.CAMPX__GrossRevenue__c || event.CAMPX__TotalExpenses__c != oldEvents.get(event.Id)?.CAMPX__TotalExpenses__c)){
                event.CAMPX__NetRevenue__c = (event.CAMPX__GrossRevenue__c==null || event.CAMPX__TotalExpenses__c == null) ? null : event.CAMPX__GrossRevenue__c-event.CAMPX__TotalExpenses__c;
            }
        }
    }
}