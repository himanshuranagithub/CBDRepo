public class PlatformEventSubscriber {
    private static final String ORG1_INSTANCE_URL = 'https://oraqosoftitserviceprivatedl-dev-ed.develop.my.salesforce.com';
    private static final String ORG1_PLATFORM_EVENT_URL = ORG1_INSTANCE_URL + '/services/data/v52.0/sobjects/AccountChangeEvent__e';
    private static final String CLIENT_ID = '3MVG9pRzvMkjMb6m.qsItpU0c6zXad0.raEUrZ51mh2ylbp.aPtxqz_TjMJa1Fr3za1.Q3MdSVTHiU9ioJtRc';
    private static final String CLIENT_SECRET = '061B39D954F8C0C42A5823C3B881C4657831CE0CAD44BB58AE06BB5C7C462E4E';
    private static final String USERNAME = 'surya.semykolon@gmail.com';
    private static final String PASSWORD = 'Semy2024!';
    private static String accessToken;
    
    // Method to authenticate and get the access token
    public static void authenticate() {
        system.debug('Inside Authenticate');
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ORG1_INSTANCE_URL + '/services/oauth2/token');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String body = 'grant_type=password' +
            '&client_id=' + EncodingUtil.urlEncode(CLIENT_ID, 'UTF-8') +
            '&client_secret=' + EncodingUtil.urlEncode(CLIENT_SECRET, 'UTF-8') +
            '&username=' + EncodingUtil.urlEncode(USERNAME, 'UTF-8') +
            '&password=' + EncodingUtil.urlEncode(PASSWORD, 'UTF-8');
        req.setBody(body);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            Map<String, Object> authResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            accessToken = (String) authResponse.get('access_token');
            system.debug('Access Token @@@@@@@ '+accessToken);
        } else {
            System.debug('Authentication failed: ' + res.getBody());
        }
    }
    
    // Method to subscribe to the platform event
    public static void subscribeToPlatformEvent() {
        if (accessToken == null) {
            authenticate();
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ORG1_PLATFORM_EVENT_URL);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setHeader('Content-Type', 'application/json');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            System.debug('Subscription successful: ' + res.getBody());
            // Handle the event data as needed
        } else {
            System.debug('Subscription failed: ' + res.getBody());
        }
    }
    
    // Call this method to authenticate and subscribe
    public static void startSubscription() {
        subscribeToPlatformEvent();
    }
}