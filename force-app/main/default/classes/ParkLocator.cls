public with sharing class ParkLocator {

    public static List<String> country(String CountryName){
        ParkService.ParksImplPort parknames = new ParkService.ParksImplPort();
        return parknames.byCountry('India');
    }
}