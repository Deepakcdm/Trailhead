/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 03-16-2025
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

    /**
    * @description 
    * @author Deepak | 02-03-2025 
    * @param String firstName 
    * @param String lastName 
    * @return String 
    **/
    public String formatName(String firstName, String lastName) {
        return firstName+' '+lastName;
    }


    /**
    * @description 
    * @author Deepak | 02-03-2025 
    * @param String firstName 
    * @param String lastName 
    * @return String 
    **/
    public String formatName1(String firstName, String lastName) {
        //code here
        string formatName='';
        if(string.isNotBlank(firstName ) && string.isNotBlank(lastName)){
            formatName = lastName+', '+firstName;
        }else if(string.isNotBlank(lastName) && string.isBlank(firstName)){
            formatName = lastName;
        }else if(string.isBlank(lastName) && string.isNotBlank(firstName)){
            formatName = firstName;
        }else{
            return formatName;
        }
        return formatName;
    }

    /**
    * @description 
    * @author Deepak | 02-03-2025 
    * @param String email 
    * @return String 
    **/
    public String nameFromEmail(String email) {
        //code here
        return string.isNotBlank(email) ? (email.substringBefore('.').tolowerCase()).capitalize()+' '+(email.substringBetween('.','@').tolowerCase()).capitalize() : '';
    }

    /**
    * @description 
    * @author Deepak | 02-03-2025 
    * @param Integer n 
    * @return String 
    **/
    public String ageGroup(Integer n) {
        //code here
        string ageGroup;
            if(n==0 || n==1){
                ageGroup =  'Infant';
            }else if(n > 1 && n <= 14){
                ageGroup = 'Child';
            }else if(n > 14 && n < 22){
                ageGroup = 'Youth';
            }else if(n == 22 || n > 22){
                ageGroup = 'Adult';
            }
            return ageGroup;
     }

     /**
     * @description 
     * @author Deepak | 02-03-2025 
     * @param Decimal total 
     * @param Integer percent 
     * @return Decimal 
     **/
     public Decimal computeTip(Decimal total, Integer percent) {
        //code here
        return total*percent/100;
    }

    /**
    * @description 
    * @author Deepak | 02-03-2025 
    * @param Boolean passedExam 
    * @param Boolean passedAssignments 
    * @param Boolean passedProject 
    * @return Boolean 
    **/
    public Boolean isPassed(Boolean passedExam, Boolean passedAssignments, Boolean passedProject) {
        //code here
        return (passedExam && passedAssignments ) || (passedAssignments && passedProject) || (passedProject && passedExam) ? true : false;
    }

    /**
    * @description 
    * @author Deepak | 02-03-2025 
    * @param Integer num 
    * @return Boolean 
    **/
    public Boolean isEndWithZero(Integer num){
        //code here
        return Math.Mod(num,10) == 0 ? true : false;
   }

   /**
   * @description 
   * @author Deepak | 02-03-2025 
   * @param Integer a 
   * @param Integer b 
   * @param Integer c 
   * @return String 
   **/
   public String whichTwo(Integer a, Integer b, Integer c) {
    //code here
    return a+b==c ? 'c' : b+c==a ? 'a' : c+a == b ? 'b' : '';
    }

    /**
    * @description 
    * @author Deepak | 02-03-2025 
    * @param String plant1 
    * @param String plant2 
    * @return Boolean 
    **/
    public Boolean companionPlants(String plant1, String plant2) {
        //code here
        Map<String, List<String>> companionMap = new Map<String, List<String>>();
        companionMap.put('lettuce', new List<String>{'cucumbers','onions'});
        companionMap.put('onions', new List<String>{'carrots', 'tomatoes','lettuce'});
        companionMap.put('cucumbers', new List<String>{'lettuce'});
        companionMap.put('carrots', new List<String>{'onions'});
        companionMap.put('tomatoes', new List<String>{'onions'});

        return companionMap.get(plant1)?.contains(plant2) == true ? true : false;
    }

    /**
    * @description 
    * @author Deepak | 02-03-2025 
    * @param Integer year 
    * @return Boolean 
    **/
    public Boolean isLeapYear(Integer year) {
        //code here
        return (Math.Mod(year,4) == 0 && Math.Mod(year,100) != 0) || (Math.Mod(year,4) == 0 && Math.Mod(year,100) == 0 && Math.Mod(year,400) == 0) ? true : false;
    }

    /**
    * @description 
    * @author Deepak | 03-16-2025 
    * @param Integer n 
    * @return Integer 
    **/
    public Integer sumToN(Integer n) {
        //code here
        Integer sumToN = 0;
        if(n > 0){
            for(Integer i=1; i<=n ; i++){
                sumtoN+=i;
            }
        }
        return sumToN;
    }
}