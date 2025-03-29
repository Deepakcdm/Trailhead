/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 03-29-2025
 * @last modified by  : Deepak
**/
public with sharing class CampSponsor_TriggerHandler {

    /**
    * @description 
    * @author Deepak | 03-29-2025 
    **/
    public static void updateSponsorPendingStatus(List<CAMPX__Sponsor__c> newSponsors){
        for(CAMPX__Sponsor__c sponsor :newSponsors){
            if(string.isBlank(sponsor.CAMPX__Status__c)){
                sponsor.CAMPX__Status__c='Pending';
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 03-29-2025 
    * @param List<CAMPX__Sponsor__c> newSponsors 
    **/
    public static void restrictSponsorWithoutEmail(List<CAMPX__Sponsor__c> newSponsors){
        for(CAMPX__Sponsor__c sponsor : newSponsors){
            if(string.isBlank(sponsor.CAMPX__Email__c)){
                sponsor.addError('A sponsor can not be created without an email address');
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 03-29-2025 
    **/
    public static void updateSponsorShipTier(List<CAMPX__Sponsor__c> newSponsors){
        for(CAMPX__Sponsor__c sponsor : newSponsors){
            if(sponsor.CAMPX__ContributionAmount__c==null || sponsor.CAMPX__ContributionAmount__c <= 0){
                sponsor.CAMPX__Tier__c=null;
            }else if(sponsor.CAMPX__ContributionAmount__c > 0 && sponsor.CAMPX__ContributionAmount__c < 1000){
                sponsor.CAMPX__Tier__c='Bronze';
            }else if(sponsor.CAMPX__ContributionAmount__c >= 1000 && sponsor.CAMPX__ContributionAmount__c < 5000){
                sponsor.CAMPX__Tier__c='Silver';
            }else if(sponsor.CAMPX__ContributionAmount__c > 5000){
                sponsor.CAMPX__Tier__c='Gold';
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 03-29-2025 
    * @param List<CAMPX__Sponsor__c> newSponsors 
    * @param Map<Id CAMPX__Sponsor__c> oldSponsors 
    **/
    public static void restrictSponsorWithoutEvent(List<CAMPX__Sponsor__c> newSponsors, Map<Id,CAMPX__Sponsor__c> oldSponsors){
        for(CAMPX__Sponsor__c sponsor : newSponsors){
            if((oldSponsors==null || sponsor.CAMPX__Status__c!= oldSponsors.get(sponsor.Id)?.CAMPX__Status__c) && sponsor.CAMPX__Event__c==null && sponsor.CAMPX__Status__c=='Accepted'){
                sponsor.addError('A Sponsor must be associated with an event before being Accepted.');
            }
        }
    }

    /**
    * @description 
    * @author Deepak | 03-29-2025 
    **/
    public static void updateEventGrossRevenue(List<CAMPX__Sponsor__c> newSponsors, Map<Id,CAMPX__Sponsor__c> oldSponsors){
        set<Id> eventIds = new set<Id>();
        for(CAMPX__Sponsor__c sponsor : newSponsors){
            if((oldSponsors==null || sponsor.CAMPX__Status__c!= oldSponsors.get(sponsor.Id)?.CAMPX__Status__c) && sponsor.CAMPX__Status__c=='Accepted'){
                eventIds.add(sponsor.CAMPX__Event__c);
            }
        }

        if(!eventIds.isEmpty()){
            List<CAMPX__Event__c> events = new List<CAMPX__Event__c>();
            List<AggregateResult> groupedResults = [Select CAMPX__Event__c,SUM(CAMPX__ContributionAmount__c)contributionAmount FROM CAMPX__Sponsor__c 
            Where CAMPX__Event__c IN :eventIds AND CAMPX__Status__c='Accepted' GROUP BY CAMPX__Event__c];

            for(AggregateResult ar : groupedResults){
                Id eventId = (Id)ar.get('CAMPX__Event__c');
                Decimal contributionAmt = (Decimal)ar.get('contributionAmount');
                events.add(new CAMPX__Event__c(Id=eventId, CAMPX__GrossRevenue__c= contributionAmt));
            }

            if(!events.isEmpty()){
                Database.update(events);
            }
        }
    }
}