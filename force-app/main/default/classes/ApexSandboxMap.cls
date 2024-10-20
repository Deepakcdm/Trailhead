/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 10-20-2024
 * @last modified by  : Deepak
**/
public with sharing class ApexSandboxMap {

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param Map<String String> employeeIdToEmail 
    * @param String employeeId 
    * @return String 
    **/
    public String employeeEmail(Map<String, String> employeeIdToEmail, String employeeId) {
        //code here
       string employeeEmail = employeeIdToEmail.containsKey(employeeId) ? employeeIdToEmail.get(employeeId) : 'info@apexsandbox.io';
       return employeeEmail;
    }

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param List<Contact> contacts 
    * @return Map<String, String> 
    **/
    public Map<String, String> phonebook(List<Contact> contacts) {
        //code here
        Map<String,String> conPhoneMap = new Map<String,String>();
        for(Contact con : contacts){
            if(!String.isBlank(con.Phone)){
                conPhoneMap.put(con.Name, con.Phone);
            }
        }
        return conPhoneMap;
    }
    
}