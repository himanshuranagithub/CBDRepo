public class HolidayCalculatorHelper {
    // Method to calculate holiday count dynamically
    public static Integer calculateHolidayCount() {
        // Query all holidays
        List<Holiday> holidays = [
            SELECT Id, ActivityDate
            FROM Holiday
            WHERE ActivityDate != NULL
        ];
        
        // Return the count of holidays dynamically
        return holidays.size();
    }

    // Update the holiday count on Case records
    public static void updateHolidayCountForCases(List<Case> caseRecords) {
        // Calculate the holiday count dynamically
        Integer holidayCount = calculateHolidayCount();
        
        // Update the custom Holiday_Count__c field on Cases
        for (Case c : caseRecords) {
            c.Holiday_Count__c = holidayCount;
        }
    }
}