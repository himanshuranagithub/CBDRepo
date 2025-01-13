global class CaseHolidayHoursBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('Batch Start Method Invoked');
        String query = 
            'SELECT Id, CreatedDate ' +
            'FROM Case ' +
            'WHERE Case_Record_Type__c NOT IN (\'xForms\', \'xChange Request\', \'SF Maintenance/Data/Request\', \'xService Request\', \'Care Krew SF Request\') ' +
            'AND Status != \'Closed\'';
        
        return Database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        System.debug('Batch Execute Method Invoked');
        if (scope.isEmpty()) {
            System.debug('No records to process.');
            return;
        }
        
        Map<Id, Date> caseCreatedDatesMap = new Map<Id, Date>();
        for (SObject sObj : scope) {
            Case c = (Case) sObj;
            caseCreatedDatesMap.put(c.Id, c.CreatedDate.date());
            System.debug('Processing Case ID: ' + c.Id + ', CreatedDate: ' + c.CreatedDate);
        }
        
        // Fetch relevant Holiday records based on Case CreatedDate
        List<Holiday> holidayList = [SELECT Id, ActivityDate FROM Holiday 
                                     WHERE ActivityDate > :caseCreatedDatesMap.values() 
                                     AND ActivityDate < :Date.today()];
        
        System.debug('Retrieved Holiday Records: ' + holidayList);
        
        // Process Cases and related Holidays
        Map<Id, Integer> caseHolidayCountMap = new Map<Id, Integer>();
        
        for (Holiday h : holidayList) {
            for (Id caseId : caseCreatedDatesMap.keySet()) {
                Date createdDate = caseCreatedDatesMap.get(caseId);
                if (h.ActivityDate > createdDate && h.ActivityDate < Date.today()) {
                    if (!caseHolidayCountMap.containsKey(caseId)) {
                        caseHolidayCountMap.put(caseId, 0);
                    }
                    caseHolidayCountMap.put(caseId, caseHolidayCountMap.get(caseId) + 1);
                    System.debug('Holiday found for Case ID: ' + caseId + ', HolidayDate: ' + h.ActivityDate);
                }
            }
        }
        
        // Update Holiday_Hours__c field in Case records
        List<Case> casesToUpdate = new List<Case>();
        for (Id caseId : caseHolidayCountMap.keySet()) {
            Case c = new Case(Id = caseId);
            c.Holiday_Hours__c = caseHolidayCountMap.get(caseId) * 12.5;
            casesToUpdate.add(c);
            System.debug('Updating Case ID: ' + caseId + ' with Holiday_Hours__c: ' + c.Holiday_Hours__c);
        }
        
        // Update Cases with partial save to handle errors
        if (!casesToUpdate.isEmpty()) {
            Database.SaveResult[] saveResults = Database.update(casesToUpdate, false);
            for (Database.SaveResult result : saveResults) {
                if (!result.isSuccess()) {
                    // Log errors for debugging
                    System.debug('Error updating Case ID: ' + result.getId() + ' - ' + result.getErrors()[0].getMessage());
                } else {
                    System.debug('Successfully updated Case ID: ' + result.getId());
                }
            }
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        System.debug('Batch Process Completed.');
    }
}