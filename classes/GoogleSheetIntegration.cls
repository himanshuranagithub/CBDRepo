public with sharing class GoogleSheetIntegration {
    @AuraEnabled
    public static void refreshData() {
        String sheetId = '1YFiB_OlLcdkQBmswUj0ZvwSyRyHoTTvsXqEwSVtBHf0';
        String apiKey = 'AIzaSyCaUeA_DaCNl6pAET6DqVUts_W-oSs4oms';
        String tabName = 'Account sheet'; // e.g., 'Accounts', 'Data', etc.
        String tabRange = '%27Account%20sheet%27!A1:D100';
        String url = 'https://sheets.googleapis.com/v4/spreadsheets/' + sheetId + '/values/' + tabRange + '?key=' + apiKey;
System.debug('Request URL: ' + url);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        System.debug('HttpRequest object: ' + request);

        HttpResponse response;
        try {
            response = http.send(request);
            System.debug('Status Code: ' + response.getStatusCode());
            System.debug('Response Body: ' + response.getBody());
        } catch (Exception e) {
            System.debug('Exception during HTTP callout: ' + e.getMessage());
            throw new AuraHandledException('HTTP callout failed: ' + e.getMessage());
        }

        if (response.getStatusCode() == 200) {
            Map<String, Object> responseMap;
            try {
                responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Deserialized JSON: ' + responseMap);
            } catch (Exception e) {
                System.debug('JSON Deserialization Error: ' + e.getMessage());
                throw new AuraHandledException('Failed to parse JSON: ' + e.getMessage());
            }

            List<Object> values = (List<Object>) responseMap.get('values');
            if (values == null || values.size() < 2) {
                System.debug('No data rows found in Google Sheet.');
                throw new AuraHandledException('No data found in the Google Sheet.');
            }

            List<Account> accountsToInsert = new List<Account>();

            for (Integer i = 1; i < values.size(); i++) {
                List<Object> row = (List<Object>) values[i];
                System.debug('Processing row ' + i + ': ' + row);

                Account acc = new Account();
                if (row.size() > 0) acc.Name = String.valueOf(row[0]);
                if (row.size() > 1) acc.email__c = String.valueOf(row[1]);
                if (row.size() > 2) acc.Phone = String.valueOf(row[2]);
                if (row.size() > 3) acc.AccountNumber = String.valueOf(row[3]);

                accountsToInsert.add(acc);
            }

            if (!accountsToInsert.isEmpty()) {
                insert accountsToInsert;
                System.debug('Inserted Accounts: ' + accountsToInsert);
            }
        } else {
            System.debug('Non-200 status received: ' + response.getStatusCode());
            throw new AuraHandledException('Failed to fetch data. Status: ' + response.getStatusCode());
        }
    }
}