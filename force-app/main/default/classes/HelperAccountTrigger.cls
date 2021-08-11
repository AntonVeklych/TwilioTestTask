public with sharing class HelperAccountTrigger {

    public static void sendSMSIfGoldAccount(List<Account> listAccs){
        Twilio_Message__c twilioMsg = Twilio_Message__c.getValues('TwilioMessage');
        for (Account acc : listAccs) {
            if(acc.Is_sent_sms__c == false && acc.Client_Type__c == twilioMsg.Client_Type__c){
                TW_SMSService.sendSMS(acc.Name);
                acc.Is_sent_sms__c = true;
            }
        }
    }
}
