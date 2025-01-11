public class getUserTimeHourMinutes {
  @InvocableMethod(label = 'Get User Time Info')
    public static List<returnValues> getUserTimes(List<DateTime> userdate){
      List<returnValues> rtrList = new List<returnValues>();
        returnValues rtr = new returnValues();
        rtr.hour = userdate[0].hour();
        rtr.minute = userdate[0].minute();
        rtrList.add(rtr);
        return rtrList;
}
    public class returnValues{
        
        @InvocableVariable 
        public Integer hour;
        
        @InvocableVariable 
        public Integer minute;
        
    }
}