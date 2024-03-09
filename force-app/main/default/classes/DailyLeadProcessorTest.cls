@isTest
public with sharing class DailyLeadProcessorTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    @isTest public static void testLeadSourceUpdate(){
        List<Lead>leadsList = new List<lead>();
        for(integer i=1;i<=200;i++){
            Lead l = new Lead(FirstName='Test',LastName='Lead '+i,Company='Accenture',Status='Open - Not Contacted',CurrencyIsoCode='USD');
            leadsList.add(l);
        }
       insert(leadsList);

        
    Test.StartTest();
    DailyLeadProcessor processor = new DailyLeadProcessor();
    System.schedule('Test Schedule',CRON_EXP,processor);
    Test.StopTest();
    }
}