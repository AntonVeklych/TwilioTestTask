public with sharing class TW_RestService {
    
    public static HttpResponse sendSMS(Twilio_Credentials__c creds, TW_DTO_SendSMSRequest dtoSendSMS){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(creds.Twilio_Url__c + 'Accounts/' + creds.ACCOUNT_SID__c + '/Messages.json');
        request.setMethod(HTTPMethod.POST);
        setRequestHeader(request, creds);
        String body = 'Body=' + EncodingUtil.urlEncode(dtoSendSMS.Body,'UTF-8') +
                      '&From=' + EncodingUtil.urlEncode(dtoSendSMS.From_N,'UTF-8') +
                      '&To=' + EncodingUtil.urlEncode(dtoSendSMS.To,'UTF-8');
        request.setBody(body);
        HttpResponse response = http.send(request);

        return response;
    }

    private static void setRequestHeader(HttpRequest request, Twilio_Credentials__c creds){
        Blob headerValue = Blob.valueOf(creds.ACCOUNT_SID__c + ':' + creds.AUTH_TOKEN__c);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
    }
}