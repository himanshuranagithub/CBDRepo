@isTest
private class getUserTimeHourMinutesTest {

    @isTest
    static void testGetUserTimes() {
        // Create a test DateTime
        DateTime testDateTime = DateTime.newInstance(2022, 1, 1, 12, 30, 0);

        // Create a list of DateTime to pass to the invocable method
        List<DateTime> userdateList = new List<DateTime>{testDateTime};

        // Call the invocable method
        List<getUserTimeHourMinutes.returnValues> result = getUserTimeHourMinutes.getUserTimes(userdateList);

        // Ensure the result is not null and has one element
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());

        // Check the returned values
        getUserTimeHourMinutes.returnValues returnedValues = result[0];
        System.assertEquals(12, returnedValues.hour);
        System.assertEquals(30, returnedValues.minute);
    }
}