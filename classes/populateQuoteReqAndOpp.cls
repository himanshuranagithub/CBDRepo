public without sharing class populateQuoteReqAndOpp { 
    /* public static void updateEBSOrderWithQuote(List<EBS_Order__c> orderList){
Map<String,EBS_Order__c> mapOfOpp_OQR = new Map<String,EBS_Order__c>();
Map<String,EBS_Order__c> mapOfQuote_QR = new Map<String,EBS_Order__c>();
Map<String,Opportunity> oppMapToUpdateOrder = new Map<String,Opportunity>();
Map<String,Quote_Request__c> quoteMapToUpdateOrder = new Map<String,Quote_Request__c>();
if(!orderList.isEmpty()){
for(EBS_Order__c  ebsOrder:orderList){
if(ebsOrder.Quote_Number__c != null && ebsOrder.Quote_Number__c != ''){
if(ebsOrder.Quote_Number__c != null && ebsOrder.Quote_Number__c.startswith('OQR')){
mapOfOpp_OQR.put(ebsOrder.Quote_Number__c, ebsOrder);
}else if(ebsOrder.Quote_Number__c != null && ebsOrder.Quote_Number__c.startswith('QR')){
mapOfQuote_QR.put(ebsOrder.Quote_Number__c, ebsOrder);
}
}
}
if(!mapOfOpp_OQR.isEmpty()){
List<Opportunity> oppList = [SELECT Id,Quote_Number__c FROM Opportunity WHERE Quote_Number__c IN : mapOfOpp_OQR.keyset()  ];
if(oppList.size() > 0){
for(Opportunity opp : oppList){
oppMapToUpdateOrder.put(opp.Quote_Number__c, opp);
for(EBS_Order__c ebsOrder : orderList){
if(ebsOrder.Quote_Number__c.startswith('OQR')){
ebsOrder.Opportunity__c = oppMapToUpdateOrder.get(opp.Quote_Number__c).Id;
}
}
}
}  

} else if(!mapOfQuote_QR.isEmpty()){
List<Quote_Request__c> qrList =  [Select Id,Name,Opportunity__c,Quote_Number__c FROM Quote_Request__c where Name IN : mapOfQuote_QR.keyset() ];
if(qrList.size() > 0){
for(Quote_Request__c quoteReq : qrList){
quoteMapToUpdateOrder.put(quoteReq.Quote_Number__c, quoteReq);
for(EBS_Order__c ebsOrder : orderList){
if(ebsOrder.Quote_Number__c.startswith('QR')){
ebsOrder.Quote_Request__c = quoteMapToUpdateOrder.get(quoteReq.Quote_Number__c).Id;
ebsOrder.Opportunity__c =  quoteMapToUpdateOrder.get(quoteReq.Quote_Number__c).Opportunity__c;
}
}
}
}
}
}

}*/
    //LIFT-2064 : Task : LIFT-2082
    public static void updateOrderWithQuoteAndOpp(Map<String,EBS_Order__c> quoteNumOrderMap){
        
        Set<String> qrSet = new Set<String>();
        Set<String> oqrSet = new Set<String>();
        if(!quoteNumOrderMap.isEmpty()){
            for(String num : quoteNumOrderMap.keySet()){
                if(num != null && num != ''){
                    if(num.startsWith('OQR')){
                        System.debug('Entered in if condition');
                        oqrSet.add(num);
                    }else if (num.startsWith('QR')) { // QR-14403
                        qrSet.add(num);
                        System.debug('qrSet'+qrSet);
                    }
                }   
                
            }
        }
        
        Map<String, Opportunity> quoteNumberOppMap = new Map<String, Opportunity>();
        Map<String, Quote_Request__c> quoteNumberQRMap = new Map<String, Quote_Request__c>();
        
        List<Opportunity> oppList = [SELECT Id, Quote_Number__c FROM Opportunity WHERE Quote_Number__c IN: oqrSet LIMIT 50000];
        List<Quote_Request__c> qrList = [SELECT Id, Name,Quote_Number__c,Opportunity__c FROM Quote_Request__c WHERE Name IN: qrSet LIMIT 50000];
        System.debug('oppList'+oppList);
        System.debug('qrList'+qrList);
        
        if(oppList.size() > 0){
            for (Opportunity oppRec : oppList) {
                quoteNumberOppMap.put(oppRec.Quote_Number__c, oppRec);
                System.debug('quoteNumberOppMap'+quoteNumberOppMap);
                
            }
        }
        if(qrList.size() > 0){
            for (Quote_Request__c orRec : qrList) {
                quoteNumberQRMap.put(orRec.Name, orRec);
                System.debug('quoteNumberQRMap'+quoteNumberQRMap);
            }
            
        }//if(!quoteNumberOppMap.isEmpty()){
            for (EBS_Order__c order : quoteNumOrderMap.values()) {
                if (!quoteNumberOppMap.isEmpty() && order.Quote_Number__c != null && order.Quote_Number__c.startsWith('OQR')) {
                    order.Opportunity__c = quoteNumberOppMap.get(order.Quote_Number__c).Id;
                }
                else if (!quoteNumberQRMap.isEmpty() && order.Quote_Number__c != null && order.Quote_Number__c.startsWith('QR')) {
                    
                    order.Quote_Request__c = quoteNumberQRMap.get(order.Quote_Number__c).Id;
                    order.Opportunity__c = quoteNumberQRMap.get(order.Quote_Number__c).Opportunity__c;
                }
            }
        //}
    }
}