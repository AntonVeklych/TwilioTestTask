@IsTest
private class TestHelperAccountTrigger {

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
        twMsg.Client_Type__c = 'GOLD';
        insert twMsg;
    }

    @IsTest
    private static void testSendSMSIfGoldAccount(){

        Test.setMock(HttpCalloutMock.class, new TestSendMockResponseImpl());

        Account acc = new Account();
        acc.Name = 'Test Name';
        insert acc;

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opp';
        opp.AccountId = acc.Id;
        opp.CloseDate = Date.Today();
        opp.StageName = 'Closed Won';
        opp.Amount = 60000;
        insert opp;
        List<Account> listAccs = [SELECT Id, Name, Client_Type__c, Is_sent_sms__c FROM Account];
        listAccs.get(0).Is_sent_sms__c = false;
        Test.startTest();
        HelperAccountTrigger.sendSMSIfGoldAccount(listAccs);
        Test.stopTest();

        List<Log__c> logs = [
            SELECT Id
            FROM Log__c
        ];

        System.assert(logs.size() == 0);
    }
}
