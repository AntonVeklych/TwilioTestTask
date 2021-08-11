global class TestSendMockResponseImpl implements HttpCalloutMock{

    private static final String responseBody = '{' +
        '"sid": "SM9f950eb66f6540b49d2af9d48a42ed47",' +
        '"date_created": "Tue, 10 Aug 2021 20:48:02 +0000",' +
        '"date_updated": "Tue, 10 Aug 2021 20:48:02 +0000",' +
        '"date_sent": null,' +
        '"account_sid": "AC2c8178ef6e3274981d69ec30fcb322cc",' +
        '"to": "+380974533412",' +
        '"from": "+16024970178",' +
        '"messaging_service_sid": null,' +
        '"body": "Test 5555",' +
        '"status": "queued",' +
        '"num_segments": "1",' +
        '"num_media": "0",' +
        '"direction": "outbound-api",' +
        '"api_version": "2010-04-01",' +
        '"price": null,' +
        '"price_unit": "USD",' +
        '"error_code": null,' +
        '"error_message": null' +
    '}';

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody(responseBody);
        return res;
    }
}
