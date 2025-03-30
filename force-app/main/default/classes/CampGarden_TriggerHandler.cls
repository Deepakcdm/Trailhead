/**
 * @description       : 
 * @author            : Deepak
 * @Created on        : 03-30-2025
 * @Created by        : Deepak
 * @last modified on  : 03-30-2025
 * @last modified by  : Deepak 
 * Modifications Log
 * Ver   Date         Author   Modification
 * 1.0   03-30-2025   Deepak   Initial Version
**/
public with sharing class CampGarden_TriggerHandler {

    /**
    * @description 
    * @author Deepak | 03-30-2025 
    * @param List<CAMPX__Garden__c> newGardens 
    **/
    public static void initializeGardenFields(List<CAMPX__Garden__c> newGardens){
        for(CAMPX__Garden__c garden : newGardens){
            garden.CAMPX__Status__c=garden.CAMPX__Status__c==null ? 'Awaiting Resources' : garden.CAMPX__Status__c;
            garden.CAMPX__Max_Plant_Count__c=garden.CAMPX__Max_Plant_Count__c==null ? 100 : garden.CAMPX__Max_Plant_Count__c;
            garden.CAMPX__Minimum_Plant_Count__c=garden.CAMPX__Minimum_Plant_Count__c==null ? 1 : garden.CAMPX__Minimum_Plant_Count__c;
            garden.CAMPX__Total_Plant_Count__c=garden.CAMPX__Total_Plant_Count__c==null ? 0 : garden.CAMPX__Total_Plant_Count__c;
            garden.CAMPX__Total_Unhealthy_Plant_Count__c=garden.CAMPX__Total_Unhealthy_Plant_Count__c==null ? 0 :  garden.CAMPX__Total_Unhealthy_Plant_Count__c;
        }
    }

    /**
    * @description 
    * @author Deepak | 03-30-2025 
    * @param List<CAMPX__Garden__c> newGardens 
    **/
    public static void createTaskForManager(List<CAMPX__Garden__c> newGardens, Map<Id,CAMPX__Garden__c> oldGardens){
        List<Task> managerTasks = new List<Task>();
        for(CAMPX__Garden__c garden : newGardens){
            if(garden.CAMPX__Manager__c!=null && (oldGardens==null || garden.CAMPX__Manager__c!= oldGardens?.get(garden.Id)?.CAMPX__Manager__c)){
                managerTasks.add(new Task(Subject='Acquire Plants',whatId=garden.Id,OwnerId=garden.CAMPX__Manager__c));
            }
        }

        if(!managerTasks.isEmpty()){
            Database.insert(managerTasks);
        }
    }
}