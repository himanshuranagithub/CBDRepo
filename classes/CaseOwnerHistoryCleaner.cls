public class CaseOwnerHistoryCleaner {
    
	public static void deleteOldCaseOwnerHistory() {
        // Get the date 90 days ago
        DateTime cutoffDate = DateTime.now().addDays(-90);
        
        // Query records older than 90 days
        List<Case_Owner_History__c> recordsToDelete = [SELECT Id FROM Case_Owner_History__c WHERE CreatedDate <= :cutoffDate];

        // Check if there are records to delete
        if (!recordsToDelete.isEmpty()) {
            // Delete the records
            try {
                delete recordsToDelete;
                System.debug('Deleted ' + recordsToDelete.size() + ' Case Owner History records older than 90 days.');
            } catch (DmlException e) {
                System.debug('Error deleting records: ' + e.getMessage());
            }
        } else {
            System.debug('No Case Owner History records older than 90 days found.');
        }
    }
        
        
    }