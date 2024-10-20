/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 10-20-2024
 * @last modified by  : Deepak
**/
public with sharing class ApexSandbox {

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param Contact c 
    * @return Boolean 
    **/
    public Boolean isBirthday(Contact c) {
        //code here

        Boolean birthDay = c.BirthDate.day() == System.Today().day() && c.BirthDate.month() == System.Today().month() ? true : false;
        return birthDay;
    }

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param Account a 
    **/
    public void setAccountRating(Account a) {
        //code here
        if(a.AnnualRevenue!=null){
            if(a.AnnualRevenue <= 100000 ){
                a.Rating = 'Cold';
            }else if(a.AnnualRevenue >= 100000 && a.AnnualRevenue <= 500000){
                a.Rating = 'Warm';
            }else if(a.AnnualRevenue > 500000){
                a.Rating = 'Hot';
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param Account a 
    * @return Boolean 
    **/
    public Boolean isKeyAccount(Account a) {
        //code here
        Boolean isKeyAccount=false;
        if(a.AnnualRevenue!=null && !string.isBlank(a.Industry)){
           if(a.AnnualRevenue >= 600000 && a.AnnualRevenue < 800000 && 'Banking'.equalsIgnoreCase(a.Industry)){
            isKeyAccount = true;
           }else if(a.AnnualRevenue >= 800000 && a.AnnualRevenue < 2000000 && 'Technology'.equalsIgnoreCase(a.Industry)){
            isKeyAccount = true;
           }else if(a.AnnualRevenue >= 2000000 && 'Retail'.equalsIgnoreCase(a.Industry)){
            isKeyAccount=True;
           }else if(a.AnnualRevenue == 500000){
            isKeyAccount=True;
           }
        }
        return isKeyAccount;
    }

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param Case c1 
    * @param Case c2 
    **/
    public void linkParent(Case c1, Case c2) {
        //code here
        if(c1.ContactId!=null & c2.ContactId!=null && c1.ContactId==c2.ContactId){
            if(c1.CreatedDate < c2.CreatedDate){
                c2.ParentId=c1.Id;
            }
            else if(c2.CreatedDate < c1.CreatedDate){
                c1.ParentId=c2.Id;
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param Account acc 
    * @param Contact con 
    * @param Opportunity opp 
    **/
    public void setParent(Account acc, Contact con, Opportunity opp) {
        //code here
        if(acc?.Id!=null){
            con.AccountId = acc.Id;
            opp.AccountId = acc.Id;
        }
    }

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param Contact c 
    * @param Opportunity opp 
    * @return Boolean 
    **/
    public Boolean sameParent(Contact c, Opportunity opp) {
        //code here
        Boolean sameParent = c?.AccountId!=null && opp?.AccountId!=null && c.AccountId == opp.AccountId;
        return sameParent;
    }

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param Account acc 
    * @param Contact con 
    * @param Opportunity opp 
    * @return Boolean 
    **/
    public Boolean sameParent(Account acc, Contact con, Opportunity opp) {
        //code here
        Boolean sameParent = con?.AccountId!=null && opp?.AccountId!=null && con.AccountId == acc?.Id && opp.AccountId == acc?.Id ? true : false;
        return sameParent;
    }

    /**
    * @description 
    * @author Deepak | 10-20-2024 
    * @param Contact c1 
    * @param Contact c2 
    * @return Boolean 
    **/
    public Boolean duplicateContacts(Contact c1, Contact c2) {
        //code here
        Boolean duplicateContacts = (c1?.Email!=null && c2?.Email!=null && c1.Email == c2.Email) || (c1?.Phone!=null && c2?.Phone!=null && c1.Phone == c2.Phone) ? true : false;
        return duplicateContacts;
    }
}