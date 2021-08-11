@IsTest
private class TestTW_SMSService {

    @TestSetup
    private static void setCredentials(){
        Twilio_Credentials__c creds = new Twilio_Credentials__c();
        creds.Name = 'Twilio';
        creds.ACCOUNT_SID__c = 'Test1';
        creds.AUTH_TOKEN__c = 'Test2';
        creds.Twilio_Url__c = 'https://api.twilio.com/2010-04-01/';
        insert creds;

        Twilio_Message__c twMsg = new Twilio_Message__c();
        twMsg.Name = 'TwilioMessage';
        twMsg.Message__c = 'Test 155';
        twMsg.From__c = '+11111';
        twMsg.To__c = '+22222';
        insert twMsg;
    }

    @IsTest
    private static void testSendSMS(){
        Test.setMock(HttpCalloutMock.class, new TestSendMockResponseImpl());
        
        Test.startTest();
        TW_SMSService.sendSMS('Test Name');
        Test.stopTest();
        List<Log__c> logs = [
            SELECT Id
            FROM Log__c
        ];

        System.assert(logs.size() == 0);
    }

    @IsTest
    private static void testSendSMSError(){
        Test.setMock(HttpCalloutMock.class, new TestSendBadMockResponseImpl());
        
        Test.startTest();
        TW_SMSService.sendSMS('Test2 Name');
        Test.stopTest();
        List<Log__c> logs = [
            SELECT Id
            FROM Log__c
        ];

        System.assert(logs.size() != 0);
    }
}
