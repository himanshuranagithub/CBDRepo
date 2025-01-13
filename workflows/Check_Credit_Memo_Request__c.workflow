<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
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
</Workflow>
