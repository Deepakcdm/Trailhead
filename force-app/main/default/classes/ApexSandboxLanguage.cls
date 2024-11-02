/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 11-02-2024
 * @last modified by  : Deepak
**/
public with sharing class ApexSandboxLanguage {

    /**
    * @description 
    * @author Deepak | 11-02-2024 
    * @param sObject record 
    * @return Boolean 
    **/
    public Boolean isTypeAccount(sObject record){
    // code here
      return Schema.Account.getSObjectType() == record?.getSObjectType() ? true : false;
    }

    /**
    * @description 
    * @author Deepak | 11-02-2024 
    * @param String fifteenDigit 
    * @return String 
    **/
    public static String convert15to18DigitId(String fifteenDigit){
    //code here
    if(string.isNotBlank(fifteenDigit) && fifteenDigit.length()== 15){
        Id eighteenDigitId = fifteenDigit;
        return eighteenDigitId;
        }else{
        return string.valueof(-1);
        }
    }

    /**
    * @description 
    * @author Deepak | 11-02-2024 
    * @param Integer a 
    * @param Integer b 
    * @return String 
    **/
    public String divide(Integer a, Integer b){
        //code here
        String result;
        try{
            result =  string.valueof(a/b);
        }catch(exception e){
            result =  e.getMessage();
        }
        return result;
    }

    /**
    * @description 
    * @author Deepak | 11-02-2024 
    * @param List<Account> accounts 
    * @return String 
    **/
    public String getAccountBillingCityWithSafeNavigation(List<Account> accounts){
        // Code here
        return accounts[0]?.BillingCity?.toUpperCase();
     }

/**
* @description 
* @author Deepak | 11-02-2024 
* @return Map<String, String> 
**/
public Map<String,String> getContextUserInformation(){
    //code here
    return new Map<String,String>{'EmailId'=>userInfo.getUserEmail(),'ProfileId'=>UserInfo.getProfileId(),'Type'=>userInfo.getUserType(),'UserName'=>UserInfo.getUserName()};
    }

    /**
    * @description 
    * @author Deepak | 11-02-2024 
    * @param List<Account> accounts 
    * @param List<Contact> contacts 
    * @return List<sObject> 
    **/
    public List<sObject> getListOfsObject(List<Account> accounts, List<Contact> contacts){
    // code here
    List<Sobject>getListOfsObject = new List<Sobject>();
    if(accounts!=null && !accounts.isEmpty()){
        getListOfsObject.addAll(accounts);
    }
    if(contacts!=null && !contacts.isEmpty()){
        getListOfsObject.addAll(contacts);
    }
    return getListOfsObject;
   }

   /**
   * @description 
   * @author Deepak | 11-02-2024 
   * @param List<Account> accounts 
   * @return String 
   **/
   public String getAccountsInJSONFormat(List<Account> accounts){
    // code here
    return JSON.serialize(accounts);
    }

    /**
    * @description 
    * @author Deepak | 11-02-2024 
    * @param String inputJSON 
    * @return List<Account> 
    **/
    public List<Account> getAccountsFromJSONString(String inputJSON){
        // code here
        return String.isNotBlank(inputJSON) ? (List<Account>)JSON.deserialize(inputJSON, List<Account>.class) : null;
    }

    /**
    * @description 
    * @author Deepak | 11-02-2024 
    * @param Account acc 
    * @param List<String> fields 
    * @return List<String> 
    **/
    public List<String> getFieldsValue(Account acc, List<String> fields){
    // code here
    List<String> getFieldsValue = new List<String>();
    for(String field : fields){
        getFieldsValue.add(string.valueof(acc?.get(field)));
         }
         return getFieldsValue;
    }

    /**
    * @description 
    * @author Deepak | 11-02-2024 
    * @param List<Account> accounts 
    * @return List<Account> 
    **/
    public List<Account> checkAccounts(List<Account> accounts){
    // code here 
    List<Account> returnAccounts = new List<Account>();
    if(accounts==null || accounts.isEmpty()){
        throw new IllegalArgumentException('Accounts should not be null');
    }else{
        for(Account acc : accounts){
            if(acc.BillingCity==null){
                throw new AccountException('Invalid BillingCity');
            }else{
                returnAccounts.add(acc);
            }
        }
        return returnAccounts;
    }
}

//do not remove the following custom-defined exception
public class AccountException extends Exception {}
}