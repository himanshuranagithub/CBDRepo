<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Creates a Follow up Task in Account</fullName>
        <actions>
            <name>Follow_Up_Required</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Inquiry__c.Follow_Up_Required__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Follow_Up_Required</fullName>
        <assignedToType>owner</assignedToType>
        <description>The following Task was generated automatically based on flagging the prices request - FOLLOW UP REQUIRED.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Inquiry__c.Follow_Up_Date__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>In Progress</status>
        <subject>Follow Up Required</subject>
    </tasks>
</Workflow>
