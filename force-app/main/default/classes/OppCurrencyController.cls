public class OppCurrencyController {
    public Opportunity opp {get;set;}
    
    public OppCurrencyController (ApexPages.StandardController stdController){
        stdController.addFields(new List<String>{'AccountId'});
        this.opp = (Opportunity)stdController.getRecord();
    }
    
    
    public pagereference oppcurrency(){
        getCurrencies();
        return null;
    }
 
    public List<SelectOption> getCurrencies(){
        List<SelectOption> currencies = new List<SelectOption>();
        if(opp.AccountId==null){
        currencies.add(new SelectOption(userinfo.getDefaultCurrency(),userinfo.getDefaultCurrency()));
        return currencies;
        }
        else{
            Account acc=[Select Id,CurrencyIsoCode from Account where Id =:opp.AccountId];
            currencies.add(new SelectOption(acc.CurrencyIsoCode,acc.CurrencyIsoCode));
            return currencies;
        }

    }
 }