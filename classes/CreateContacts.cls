/**
* @description       : 
* @author            : Ritesh Kumar
* @group             : 
* @last modified on  : 07-08-2024
* @last modified by  : ritesh.kumar@kooziegroup.com
* Ver   Date         Author         Modification
* 1.0   10-19-2023   Ritesh Kumar   
* 1.1   19-10-2023   Ritesh Kumar   JIRA SF-469 Code Line 74
**/
@RestResource(urlMapping='/CreateContacts/*')
global class CreateContacts { 
    
    @HttpPost
    global static void getContactRequest(){
        Id CustAcc;
        ContactRequest records = new ContactRequest();
        Set<Contact> tempContact = new Set<Contact>();
        RestResponse response = RestContext.response;
        RestRequest request = RestContext.Request;
        Map<String,Callout_Handler_Setting__mdt> calloutSettingMap = new Map<String,Callout_Handler_Setting__mdt>() ; 
        
        for(Callout_Handler_Setting__mdt calloutSetting : [SELECT API_Method_Name__c,Is_Active__c FROM Callout_Handler_Setting__mdt]){
            calloutSettingMap.put(calloutSetting.API_Method_Name__c,calloutSetting); 
        }
        String eventType = 'DML';
        String recordID = '';
        
        String Requestpayload = ''+request.Requestbody.toString();
        if(calloutSettingMap.containsKey('getContactRequest') && calloutSettingMap.get('getContactRequest').Is_Active__c){
            if(Requestpayload != '{}' && Requestpayload != null && Requestpayload!= ''){
                records = (ContactRequest) JSON.deserialize(Requestpayload, ContactRequest.class);
            }
        }else{
            //System.debug('====== CreateContacts Contact Records Not======='+records);
        }
        
        //System.debug('====== CreateContacts Contact Records ======='+records);
        response.addHeader('Content-Type', 'application/json'); 
        System.debug('Apex class ::: '+records.EventRequest.CustomerData.SFId);
        if(records.EventRequest != null){
            Account [] accountRecord = [SELECT Id, Name FROM Account WHERE Customer_Account_Number__c =:records.EventRequest.CustomerData.accountNumber LIMIT 1 ];
            if(accountRecord.size() > 0){
                CustAcc = accountRecord[0].Id ;
            }
            try{
                Contact contactRecord = new Contact();
                //System.debug('====== CreateContacts records.EventRequest.CustomerData.SFId ======='+records.EventRequest.CustomerData.SFId);
                if(String.isNotBlank(records.EventRequest.CustomerData.SFId) && records.EventRequest.CustomerData.SFId != 'null'){
                    contactRecord.Id = records.EventRequest.CustomerData.SFId; 
                }else{ 
                    if( String.isNotBlank(records.EventRequest.CustomerData.Email) &&  String.isNotBlank(records.EventRequest.CustomerData.accountNumber)){
                        System.debug('====== CreateContacts records.EventRequest.CustomerData.Email ======='+records.EventRequest.CustomerData.Email);
                        String contactId  = '';
                        contactId = ContactUtill.checkContact(records.EventRequest.CustomerData.Email, records.EventRequest.CustomerData.accountNumber);
                        if(contactId != ''){
                            contactRecord.Id = contactId; 
                        }
                        eventType = ContactUtill.checkContact(records.EventRequest.CustomerData.Email, records.EventRequest.CustomerData.accountNumber) != ''? 'DML' : 'DML';
                    } 
                }
                
                if(String.isBlank(contactRecord.Id)){
                    contactRecord.RecordTypeId =  Schema.SObjectType.Contact.getRecordTypeInfosByName().get('CRM Contact').getRecordTypeId();
                }
                
                //System.debug('====== CreateContacts contactRecord.Id ======='+contactRecord.Id);
                //System.debug('====== records.EventRequest.CustomerData.LastName ======='+records.EventRequest.CustomerData.LastName);
                System.debug('====== records.EventRequest.CustomerData.Mobile ======='+records.EventRequest.CustomerData.Mobile);
                contactRecord.LastName = records.EventRequest.CustomerData.LastName;
                contactRecord.FirstName =records.EventRequest.CustomerData.FirstName ;
                contactRecord.Email = records.EventRequest.CustomerData.Email ;
                contactRecord.Web_Id__c =records.EventRequest.CustomerData.WebId ; 
                contactRecord.Phone = records.EventRequest.CustomerData.primaryPhone;
                contactRecord.Email = records.EventRequest.CustomerData.Email; 
                contactRecord.MobilePhone = records.EventRequest.CustomerData.Mobile;
                contactRecord.User_Name__c = records.EventRequest.CustomerData.userName;
                contactRecord.Contact_Type__c = records.EventRequest.CustomerData.contactType;
                contactRecord.Industry_Type__c = records.EventRequest.CustomerData.industryType;
                contactRecord.Last_Login_Date__c = records.EventRequest.CustomerData.lastLoginDate;
                if(records.EventRequest.CustomerData.lastLoginDate != null){
                    contactRecord.Last_Login_Date__c = records.EventRequest.CustomerData.lastLoginDate;
                }
                contactRecord.Contact_Status__c = records.EventRequest.CustomerData.contactActiveStatus == TRUE ? 'Active':'Inactive';
                
                if(CustAcc != null){
                    contactRecord.AccountId =  CustAcc;
                }
                
                PickListValues pickListValue =  new PickListValues();
                
                if(fillPicklist(records) != null){
                    pickListValue = fillPicklist(records);
                }
                
                //System.debug('======= CreateContacts pickListValue ===== '+pickListValue);
                if(pickListValue != null){
                    if(String.isNotBlank(pickListValue.poConfirmation)){
                        contactRecord.PO_Confirmation__c = pickListValue.poConfirmation;
                    }
                    
                    if(String.isNotBlank(pickListValue.shipmentConfirmation)){
                        
                        contactRecord.Shipment_Confirmation__c = pickListValue.shipmentConfirmation;
                    } 
                    
                    
                    if(String.isNotBlank(pickListValue.proofConfirmation)){
                        
                        contactRecord.Proof_Confirmation__c = pickListValue.proofConfirmation;
                    } 
                    
                    if(String.isNotBlank(pickListValue.orderAcknowledgement)){
                        
                        contactRecord.Order_Acknowledgement__c = pickListValue.orderAcknowledgement;
                    }
                    
                    if(String.isNotBlank(pickListValue.clarificationConfirmation)){
                        
                        contactRecord.Clarification_Confirmation__c = pickListValue.clarificationConfirmation;
                    }
                    
                    if(String.isNotBlank(pickListValue.whenStatuschanges)){
                        
                        contactRecord.When_Status_changes__c = pickListValue.whenStatuschanges;
                    } 
                    
                }
                
                
                if(records.EventRequest.CustomerData.AccountPreferences != null){
                    ContactRequest.AccountPreferences preferences = records.EventRequest.CustomerData.AccountPreferences;
                    System.debug('==== CreateContacts records.EventRequest.CustomerData.AccountPreferences ====='+records.EventRequest.CustomerData.AccountPreferences);
                    //if(records.EventRequest.CustomerData.AccountPreferences.size() > 0){
                        
                       //for(ContactRequest.AccountPreferences preferences : records.EventRequest.CustomerData.AccountPreferences){
                           // Contact preferenceData = new Contact();  
                            
                            /*if(String.isNotBlank(preferences.firstName)){
                                preferenceData.FirstName = preferences.firstName;
                            }
                            
                            if(String.isNotBlank(preferences.lastName)){
                                preferenceData.LastName = preferences.lastName;
                            }
                            
                            if(String.isNotBlank(preferences.emailId)){
                                preferenceData.Email = preferences.emailId;
                            }
                            
                            if(String.isNotBlank(preferences.mobileNo)){
                                preferenceData.MobilePhone = preferences.mobileNo;
                            }
                            if(CustAcc != null){
                                contactRecord.AccountId =  CustAcc;
                            }*/
                            
                            //if(contactRecord.Email == preferences.emailId ){ 
                            contactRecord.Acc_PO_Contact__c = preferences.Acc_poConfirmation; 
                            contactRecord.Acc_Order_Acknowledgement__c = preferences.Acc_orderAcceptance;
                            contactRecord.Acc_Shipping_Contact__c = preferences.Acc_shipmentConfirmation; 
                            contactRecord.Acc_Proof_Confirmation__c = preferences.Acc_proofConfirmation;
                            contactRecord.Acc_Clarification_Confirmation__c = preferences.Acc_clarificationConfirmation;
                                //tempContact.add(contactRecord);
                            /*}else{
                                //System.debug('======= CreateContacts Else preferences ======= '+preferences);
                                if(String.isNotBlank(preferences.salesforceId)){
                                    //System.debug('====== CreateContacts preferences.salesforceId ===='+preferences.salesforceId);
                                    preferenceData.Id = preferences.salesforceId;
                                }
                                
                                preferenceData.Acc_PO_Contact__c = preferences.Acc_poConfirmation;
                                preferenceData.Acc_Order_Acknowledgement__c = preferences.Acc_orderAcceptance;
                                preferenceData.Acc_Shipping_Contact__c = preferences.Acc_shipmentConfirmation; 
                                preferenceData.Acc_Proof_Confirmation__c = preferences.Acc_proofConfirmation;
                                preferenceData.Acc_Clarification_Confirmation__c = preferences.Acc_clarificationConfirmation; 
                                tempContact.add(preferenceData);
                            }*/
                        //} 22252154
                    //}
                }
                
                if(contactRecord != null){ // if(tempContact.size() > 0){
                    Database.UpsertResult results =  Database.Upsert(contactRecord,true);
                    //System.debug('====== CreateContacts tempContact ===='+tempContact);
                    //System.debug('====== results.getId() ===='+results.getId());
                    recordID = results.getId();
                    //System.debug('===== RecordID ====='+recordID);
                    if(results.isSuccess()){
                        
                        if(tempContact.size() > 0){
                            List<Contact> preferenceList = new List<Contact>(); 
                            preferenceList.addAll(tempContact);
                            Database.Upsert(preferenceList,false);
                        } 
                    }                      
                }
                
                response.addHeader('Content-Type', 'application/json');                
                response.statusCode = 200;
                
                //getAsString()
                String responseData =  ContactUtill.contactResponse(recordID, 'SUCCESS',eventType).getAsString();
                response.responseBody =  Blob.valueOf(responseData);
                //System.debug('==== CreateContacts responseData ==== '+responseData); 
            }catch (DmlException crudException ){
                response.addHeader('Content-Type', 'text/plain');
                response.statusCode = 400;
                response.responseBody =  Blob.valueOf(JSON.serialize(crudException.getMessage()));
                ApexLogUtill.createApexLog('Website', Requestpayload, response.responseBody.toString(), recordID, 'Contact', crudException.getMessage(), response.statusCode);
            } 
        } 
    }
    
    public static PickListValues fillPicklist(ContactRequest jsonData){
        
        //System.debug('====== CreateContacts PreferancesMethod ======'+jsonData.EventRequest.CustomerData.PreferanceTypes);
        PickListValues selectedValues = new PickListValues();
        ContactRequest recordData = new ContactRequest();
        
        if(jsonData.EventRequest.CustomerData.PreferanceTypes != null){
            for(ContactRequest.PreferanceTypes data : jsonData.EventRequest.CustomerData.PreferanceTypes){
                //System.debug('====== CreateContacts PreferanceTypes data ======'+data);
                for(ContactRequest.Preferances  preferance: data.Preferances){
                    
                    System.debug('====== CreateContacts Preferances preferanceName ======'+preferance.preferanceName);
                    if(preferance.preferanceName == 'PO Confirmation'){
                        for(ContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.poConfirmation = value.Value;
                                //System.debug('====== CreateContacts selectedValues.poConfirmation data ======'+selectedValues.poConfirmation);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'Order Acknowledgement'){
                        for(ContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.orderAcknowledgement = value.Value;
                                //System.debug('======CreateContacts selectedValues.orderAcknowledgement data ======'+selectedValues.orderAcknowledgement);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'Shipment Confirmation'){
                        for(ContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.shipmentConfirmation = value.Value;
                                //System.debug('======  CreateContacts selectedValues.shipmentConfirmation data ======'+selectedValues.shipmentConfirmation);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'Proof Confirmation'){
                        for(ContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.proofConfirmation = value.Value;
                                //System.debug('====== CreateContacts selectedValues.proofConfirmation data ======'+selectedValues.proofConfirmation);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'When Status changes'){
                        for(ContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.whenStatuschanges = value.Value;
                                //System.debug('====== CreateContacts selectedValues.whenStatuschanges data ======'+selectedValues.whenStatuschanges);
                            }
                        }
                    }
                    
                    if(preferance.preferanceName == 'Clarification Confirmation'){
                        for(ContactRequest.PreferancesMethod value : preferance.PreferancesMethod){
                            if(value.Selected == 'true'){
                                selectedValues.clarificationConfirmation = value.Value;
                                //System.debug('====== CreateContacts selectedValues.clarificationConfirmation data ======'+selectedValues.clarificationConfirmation);
                            }
                        }
                    } 
                } 
                
            }
        }
        
        return selectedValues != null ? selectedValues : null;
    }
    
    public class PickListValues {
        public String clarificationConfirmation = '';
        public String whenStatuschanges = '';
        public String proofConfirmation = '';
        public String shipmentConfirmation = '';
        public String orderAcknowledgement = '';
        public String poConfirmation = '';
    }
    
}