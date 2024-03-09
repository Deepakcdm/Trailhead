public with Sharing class opportunityExtController {
    public opportunity opp{get;set;}
    public string accountId{get;set;}
    public string accRecTypeId{get;set;}
    
    public opportunityExtController(ApexPages.StandardsetController controller){
        controller.addFields(new List<String>{'Account_RecordType_Name__c'});
        this.opp=(Opportunity)controller.getRecord();
    }

}