@IsTest
private class TestTW_RestService {

    @IsTest
    private static void testSendSMS(){
        Test.setMock(HttpCalloutMock.class, new TestSendMockResponseImpl());
        Twilio_Credentials__c creds = new Twilio_Credentials__c();
        creds.ACCOUNT_SID__c = 'Test1';
        creds.AUTH_TOKEN__c = 'Test2';
        creds.Twilio_Url__c = 'https://api.twilio.com/2010-04-01/';
        TW_DTO_SendSMSRequest dtoSendSMS = new TW_DTO_SendSMSRequest();
        dtoSendSMS.Body = 'Test Msg';
        dtoSendSMS.From_N = '+1111111';
        dtoSendSMS.To = '+2222222';
        Test.startTest();
        HttpResponse response = TW_RestService.sendSMS(creds, dtoSendSMS);
        Test.stopTest();
        System.assert(response.getStatusCode() == 200);
    }
}
