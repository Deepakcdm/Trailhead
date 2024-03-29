@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        List<String> parknames = ParkLocator.country('India');
        // Verify that a fake result is returned
        System.assertEquals(new List<String>{'Anamudi Shola National Park', 'Anshi National Park', 'Bandipur National Park'}, parknames); 
    }
}