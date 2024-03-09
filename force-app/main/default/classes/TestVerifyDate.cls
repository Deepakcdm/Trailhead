@isTest
public with sharing class TestVerifyDate {

    @isTest static void CheckDatesTest(){
        Date date1 = Date.newInstance(2020,1,1);
        Date date2 = Date.newInstance(2020,4,1);
        Date targetDate = VerifyDate.checkDates(date1,date2);
    }

    @isTest static void checkDatesTest2(){
        Date newDate = Date.newInstance(2020,4,1);
        Date oldDate = Date.newInstance(2020,4,15);
        Date resultDate = verifyDate.CheckDates(newDate,oldDate);
    }
}