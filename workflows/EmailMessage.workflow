<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Last_Replied_Email</fullName>
        <description>Update last replied email from customer on case</description>
        <field>Last_Replied_Email__c</field>
        <formula>NOW()</formula>
        <name>Update Last Replied Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
</Workflow>
