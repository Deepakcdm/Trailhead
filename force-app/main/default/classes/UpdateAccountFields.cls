global class UpdateAccountFields implements Database.Batchable<sObject>{

 
 
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query='Select BillingCity,BillingCountry,(Select MailingCity,MailingCountry from Contact) from Account';
       return Database.getQueryLocator(query);
    }
 
    global void execute(Database.BatchableContext BC,List<Account> scope){
        List<Contact>conList = new List<Contact>();
        for(Account acc:Scope){
            for(Contact con:acc.contacts){
                con.MailingCity=acc.BillingCity;
                con.MailingCountry=acc.BillingCountry;
                conList.add(con);
            }
               update conList;
        }
    }
 
    global void finish(Database.BatchableContext BC){
 
    }
 
 }