public with Sharing class StdVFPageController{
    public List<Opportunity>oppList{get;set;}

    public StdVFPageController(){
        getOpps();
    }

    public List<Opportunity>getOpps(){
        oppList=[Select Name,CloseDate from Opportunity];
        return oppList;
    }
}