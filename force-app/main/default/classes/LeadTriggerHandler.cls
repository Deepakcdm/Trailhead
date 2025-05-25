/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 05-25-2025
 * @last modified by  : Deepak
**/
public with sharing class LeadTriggerHandler {

    /**
    * @description 
    * @author Deepak | 05-25-2025 
    **/
    public static void createTask(List<Lead> openLeads){
        List<Task> newTasks = new List<Task>();
        for(Lead openLead: openLeads){
            newTasks.add(new Task(WhoId=openLead.Id,
            Subject='Schedule Demo Call',
            OwnerId=openLead.OwnerId,
            ActivityDate=Date.Today().addDays(14))
            );
        }

        if(!newTasks.isEmpty()){
            Database.insert(newTasks);
        }
    }
}