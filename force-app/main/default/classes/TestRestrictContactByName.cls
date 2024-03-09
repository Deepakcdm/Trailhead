@isTest
public with sharing class TestRestrictContactByName {

    @isTest Static void CheckValidName(){
        Contact con = new Contact();
        con.firstName='Deepak';
        con.LastName='Kumar';
        Database.insert(con,false);
    }

    @isTest Static void CheckInvalidName(){
        Contact cont = new Contact();
        cont.firstName='Contact';
        cont.LastName='INVALIDNAME';
        Database.insert(cont,False);
    }
}