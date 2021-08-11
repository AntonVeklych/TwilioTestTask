public with sharing class TW_SMSService {

    @future(Callout=true)
    public static void sendSMS(String accountName){
        TW_DTO_SendSMSResponse dtoResponse;
        Twilio_Credentials__c creds = Twilio_Credentials__c.getValues('Twilio');
        Twilio_Message__c twilioMsg = Twilio_Message__c.getValues('TwilioMessage');
        TW_DTO_SendSMSRequest dtoSMS = new TW_DTO_SendSMSRequest();
        dtoSMS.Body = accountName + ' ' + twilioMsg.Message__c;
        dtoSMS.From_N = twilioMsg.From__c;
        dtoSMS.To = twilioMsg.To__c;
        HttpResponse response = TW_RestService.sendSMS(creds, dtoSMS);
        if (response.getStatusCode() == 200){
            dtoResponse = (TW_DTO_SendSMSResponse)JSON.deserialize(response.getBody(), TW_DTO_SendSMSResponse.class);
        }else{
            TW_DTO_BadResponse badResponse = (TW_DTO_BadResponse)JSON.deserialize(response.getBody(), TW_DTO_BadResponse.class);
            Logger.logError('TW Error Code : ' + badResponse.code + '; Message : ' + badResponse.message);
            Logger.commitLogs();
        }
    }
}