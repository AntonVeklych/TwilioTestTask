@IsTest
private class TestLogger {

    @IsTest
    private static void testLoggerOk() {
        Test.startTest();
        Logger.logInfo('Test Info');
        Logger.logSuccess('Test Ok');
        Logger.logError('Test Error');
        Logger.commitLogs();
        Test.stopTest();
        List<Log__c> logs = [
            SELECT Id
            FROM Log__c
        ];

        System.assertNotEquals(0, logs.size());
    }
}
