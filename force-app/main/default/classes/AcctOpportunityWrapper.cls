/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 09-07-2025
 * @last modified by  : Deepak
**/
public class AcctOpportunityWrapper {

    String acctName;
    Integer opptCount;
    Decimal opptAmount;


    /**
    * @description 
    * @author Deepak | 09-07-2025 
    * @param String acctName 
    * @param Integer opptCount 
    * @param Decimal opptAmount 
    **/
    public AcctOpportunityWrapper(String acctName, Integer opptCount, Decimal opptAmount) {
        this.acctName = acctName;
        this.opptCount = opptCount;
        this.opptAmount = opptAmount;
    }
}