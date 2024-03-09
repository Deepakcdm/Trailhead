public class OpportunityController {

    @auraenabled
public static List<Opportunity> fetchAllOpportunities()
    {
        return[Select Name,StageName,Amount from Opportunity];
    }
@auraenabled    
Public static List<Opportunity> fetchWonOpportunities()
{
    return[Select Name,StageName,Amount from Opportunity where StageName='Closed Won']; 
}
}