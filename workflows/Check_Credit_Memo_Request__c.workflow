<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>New Check %2F Credit Memo Request</fullName>
        <actions>
            <name>New_Credit_Memo_Check_Request</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Check_Credit_Memo_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Payment Requested</value>
        </criteriaItems>
        <description>Notification for Payment Request Stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
