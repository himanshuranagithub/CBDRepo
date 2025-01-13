/**
 * @description       : Utility class for handling pre-chat actions
 * @last modified on  : 11-29-2024
 * @last modified by  : Ritesh Kumar
**/
global without sharing class PreChatHandler {
    
    /**
     * @description   : Checks if the current time falls within the working hours
     * @return        : Boolean indicating whether it's working hours
    **/
    @AuraEnabled(cacheable=true)
    global static Boolean checkWorkingHours(String businessHourName){ 
        //System.debug(LoggingLevel.INFO,'====== checkWorkingHours ======');
        // Retrieve the default business hours
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE Name =: businessHourName LIMIT 1];
        //System.debug(LoggingLevel.INFO,'====== checkWorkingHours ======'+bh);
        // Check if the current time falls within the business hours
        return BusinessHours.isWithin(bh.Id, System.now());
    }

    @AuraEnabled
    public static Boolean sendOTP(Map<String, String> emailInfo, String template){  
      Boolean isContactPresent = checkContact(emailInfo.get('email'));
      if(isContactPresent){
        OTPService.sendOTP(emailInfo,template);
        return true;
      }else {
        return false;
      } 
    }

	 @AuraEnabled
    public static void reSendOTP(Map<String, String> emailInfo, String template){  
      OTP__c otpRecord = [SELECT OTP_Code__c, Expiration_Time__c FROM OTP__c WHERE Email__c = :emailInfo.get('email') ORDER BY CreatedDate DESC LIMIT 1]; 
      emailInfo.put('otp', otpRecord.OTP_Code__c);
      OTPService.sendOTPEmail(emailInfo, template);			
    }

    @AuraEnabled
    public static Boolean validateOTP(String email, String otp){  
        return OTPService.validateOTP(email,otp);
    }

	private static Boolean checkContact(String email){
		Contact [] record =  [SELECT Id , Email FROM Contact Where Email =: email AND RecordType.Name = 'CRM Contact' ORDER BY CreatedDate LIMIT 1];
		return record.size() > 0 ? true:false;
	}

	@AuraEnabled
	public static Chat_Setting__mdt loadChatSetting(){
		Chat_Setting__mdt config = [SELECT Verification_Error__c, Email_Subject__c, Verification_button_Label__c, Verification_Input_Label__c, Record_Not_Found_Message__c, Email_Message__c, Verification_Code_Message__c, Validation_Message__c, Resend_Button_Label__c, Start_Chat_button_Label__c, Day_Off__c, Day_Off_Title__c, SystemModstamp, QualifiedApiName, Label, NamespacePrefix, Language, MasterLabel, DeveloperName, Id, OPT_Expired_Title__c, OPT_Expired_Message__c FROM Chat_Setting__mdt WHERE  DeveloperName = 'Koozie_Group' LIMIT 1];
		System.debug(System.LoggingLevel.INFO,'======== config ==='+config);
		return config;

	}

}