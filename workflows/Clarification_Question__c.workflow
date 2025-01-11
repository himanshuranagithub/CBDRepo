<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Notification</fullName>
        <description>New Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Notification_CC_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Notification_To_Address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerservice@kooziegroup.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Service_Templates/X4Imprint_Notification_Template</template>
    </alerts>
    <alerts>
        <fullName>Notification_Email</fullName>
        <description>Notification Email</description>
        <protected>false</protected>
        <recipients>
            <field>Notification_CC_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Notification_To_Address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerservice@kooziegroup.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Notification_Template</template>
    </alerts>
    <alerts>
        <fullName>X4Imprint_New_Notification</fullName>
        <description>4Imprint New Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Notification_CC_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Notification_To_Address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerservice@kooziegroup.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Service_Templates/X4Imprint_Notification_Template</template>
    </alerts>
</Workflow>
