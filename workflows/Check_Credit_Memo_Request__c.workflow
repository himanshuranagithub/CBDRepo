<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Credit_Memo_Check_Request</fullName>
        <ccEmails>melissa.deisher@kooziegroup.com</ccEmails>
        <description>New Credit Memo / Check Request</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Credit_Memo_Check_Request</template>
    </alerts>
    <fieldUpdates>
        <fullName>Credit_Memo_Manager_Approval</fullName>
        <description>Move stage to &quot;Request Payment&quot; once manager approval is provided</description>
        <field>Status__c</field>
        <literalValue>Payment Requested</literalValue>
        <name>Credit Memo Manager Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Manager_Approval_Status</fullName>
        <field>Status__c</field>
        <literalValue>In Manager Approval</literalValue>
        <name>Update to Manager Approval Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
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
