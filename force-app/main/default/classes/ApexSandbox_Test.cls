@isTest
public class ApexSandbox_Test {
    @isTest
    static void testIsBirthday() {
        Contact c = new Contact(BirthDate = System.today());
        Boolean result = new ApexSandbox().isBirthday(c);
        System.assert(result, 'The contact should have a birthday today.');
    }

    @isTest
    static void testSetAccountRating() {
        Account a = new Account(AnnualRevenue = 200000);
        new ApexSandbox().setAccountRating(a);
        System.assertEquals('Warm', a.Rating, 'The account rating should be Warm.');
    }

    @isTest
    static void testIsKeyAccount() {
        Account a = new Account(AnnualRevenue = 700000, Industry = 'Banking');
        Boolean result = new ApexSandbox().isKeyAccount(a);
        System.assert(result, 'The account should be a key account.');
    }

    @isTest
    static void testLinkParent() {
        Case c1 = new Case(ContactId = '003000000000001', CreatedDate = DateTime.now().addDays(-1));
        Case c2 = new Case(ContactId = '003000000000001', CreatedDate = DateTime.now());
        new ApexSandbox().linkParent(c1, c2);
        System.assertEquals(c1.Id, c2.ParentId, 'Case c2 should have c1 as its parent.');
    }

    @isTest
    static void testSetParent() {
        Account acc = new Account(Id = '001000000000001');
        Contact con = new Contact();
        Opportunity opp = new Opportunity();
        new ApexSandbox().setParent(acc, con, opp);
        System.assertEquals(acc.Id, con.AccountId, 'Contact should have the account as its parent.');
        System.assertEquals(acc.Id, opp.AccountId, 'Opportunity should have the account as its parent.');
    }

    @isTest
    static void testSameParentContactOpportunity() {
        Account acc = new Account(Id = '001000000000001');
        Contact con = new Contact(AccountId = acc.Id);
        Opportunity opp = new Opportunity(AccountId = acc.Id);
        Boolean result = new ApexSandbox().sameParent(con, opp);
        System.assert(result, 'Contact and Opportunity should have the same parent account.');
    }

    @isTest
    static void testDuplicateContacts() {
        Contact c1 = new Contact(Email = 'test@example.com');
        Contact c2 = new Contact(Email = 'test@example.com');
        Boolean result = new ApexSandbox().duplicateContacts(c1, c2);
        System.assert(result, 'Contacts should be considered duplicates.');
    }

    @isTest
    static void testFormatName() {
        String result = new ApexSandbox().formatName('John', 'Doe');
        System.assertEquals('John Doe', result, 'The formatted name should be "John Doe".');
    }

    @isTest
    static void testAgeGroup() {
        String result = new ApexSandbox().ageGroup(15);
        System.assertEquals('Youth', result, 'The age group should be Youth.');
    }

    @isTest
    static void testComputeTip() {
        Decimal result = new ApexSandbox().computeTip(100, 15);
        System.assertEquals(15, result, 'The computed tip should be 15.');
    }

    @isTest
    static void testIsPassed() {
        Boolean result = new ApexSandbox().isPassed(true, true, false);
        System.assert(result, 'The student should have passed.');
    }

    @isTest
    static void testIsEndWithZero() {
        Boolean result = new ApexSandbox().isEndWithZero(50);
        System.assert(result, 'The number should end with zero.');
    }

    @isTest
    static void testWhichTwo() {
        String result = new ApexSandbox().whichTwo(3, 5, 8);
        System.assertEquals('c', result, 'The result should indicate that a + b equals c.');
    }

    @isTest
    static void testCompanionPlants() {
        Boolean result = new ApexSandbox().companionPlants('lettuce', 'onions');
        System.assert(result, 'Lettuce and onions should be companion plants.');
    }

    @isTest
    static void testIsLeapYear() {
        Boolean result = new ApexSandbox().isLeapYear(2024);
        System.assert(result, '2024 should be a leap year.');
    }

    @isTest
    static void testSumToN() {
        Integer result = new ApexSandbox().sumToN(5);
        System.assertEquals(15, result, 'The sum of numbers up to 5 should be 15.');
    }

    @isTest
    static void testIsPrime() {
        Boolean result = new ApexSandbox().isPrime(7);
        System.assert(result, '7 should be a prime number.');
    }

    @isTest
    static void testAscendingOrder() {
        Boolean result = new ApexSandbox().ascendingOrder(1, 2, 3);
        System.assert(result, 'The numbers should be in ascending order.');
    }

    @isTest
    static void testRockPaperScissors() {
        Integer result = new ApexSandbox().rockPaperScissors('rock', 'scissors');
        System.assertEquals(1, result, 'Player 1 should win with rock against scissors.');
    }

    @isTest
    static void testNameFromEmail() {
        String result = new ApexSandbox().nameFromEmail('john.doe@example.com');
        System.assertEquals('John Doe', result, 'The name extracted from the email should be "John Doe".');
        
        result = new ApexSandbox().nameFromEmail('jane.smith@example.com');
        System.assertEquals('Jane Smith', result, 'The name extracted from the email should be "Jane Smith".');
        
        result = new ApexSandbox().nameFromEmail('');
        System.assertEquals('', result, 'The result should be empty for a blank email.');
        
        result = new ApexSandbox().nameFromEmail(null);
        System.assertEquals('', result, 'The result should be empty for a null email.');
    }

    @isTest
    static void testFormatName1() {
        // Test case 1: Both firstName and lastName are provided
        String result = new ApexSandbox().formatName1('John', 'Doe');
        System.assertEquals('Doe, John', result, 'The formatted name should be "Doe, John".');

        // Test case 2: Only lastName is provided
        result = new ApexSandbox().formatName1('', 'Doe');
        System.assertEquals('Doe', result, 'The formatted name should be "Doe".');

        // Test case 3: Only firstName is provided
        result = new ApexSandbox().formatName1('John', '');
        System.assertEquals('John', result, 'The formatted name should be "John".');

        // Test case 4: Both firstName and lastName are blank
        result = new ApexSandbox().formatName1('', '');
        System.assertEquals('', result, 'The formatted name should be empty.');

        // Test case 5: Both firstName and lastName are null
        result = new ApexSandbox().formatName1(null, null);
        System.assertEquals('', result, 'The formatted name should be empty.');
    }
}