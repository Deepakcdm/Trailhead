public with sharing class DailyLeadProcessor implements schedulable{
    public void execute(schedulableContext ctx) {
        List<Lead>leadList = new List<Lead>();
        List<Lead>leads=[Select Id,LeadSource from Lead where LeadSource=null LIMIT 200];
        for(Lead blankLeads:leads){
            blankLeads.LeadSource='Dreamforce';
            leadList.add(blankLeads);
        }
        Database.update(leadList,false);
    }
}