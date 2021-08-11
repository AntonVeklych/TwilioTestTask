global class TestSendBadMockResponseImpl implements HttpCalloutMock{

    private static final String badResponse = '{' +
        '"code": 21606,' +
        '"message": "Test",' +
        '"more_info": "Test",' +
        '"status": 400' +
    '}';

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(400);
        res.setBody(badResponse);
        return res;
    }
}
