public class SendEmailMarketingProjectsHelper {
    public static boolean isTriggerRunning = false;

    public static void sendEmail(List<Marketing_Projects__c> marketingProjectsList) {
        if (isTriggerRunning) {
            return; // Avoid recursion
        }

        try {
            isTriggerRunning = true; // Mark trigger as running

            system.debug('Sending emails from site user...');
            OrgWideEmailAddress owea = [SELECT Id, Address, DisplayName 
                                        FROM OrgWideEmailAddress 
                                        WHERE Address = 'lisa.natisin@kooziegroup.com' LIMIT 1];

            for (Marketing_Projects__c marp : marketingProjectsList) {
                if (marp.Submitter_Email__c != null ){
                    system.debug('Email: ' + marp.Submitter_Email__c);
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                    if (owea != null) {
                        mail.setOrgWideEmailAddressId(owea.Id);
                    }

                    mail.setToAddresses(new String[]{marp.Submitter_Email__c});
                    mail.setSubject('Marketing record created');
					 
                    String emailBody = 'Thanks for submitting your marketing project. For reference your project number is ' + marp.Name + ' Thank you!';

                    mail.setPlainTextBody(emailBody);

                    try {
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
                        system.debug('Email sent successfully.');

                    } catch (Exception e) {
                        system.debug('Error sending email: ' + e.getMessage());
                    }
                }
            }

        } finally {
            isTriggerRunning = false; // Reset trigger running flag
        }
    }
}