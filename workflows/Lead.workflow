<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Awaiting_Approval</fullName>
        <field>Status</field>
        <literalValue>Awaiting Approval</literalValue>
        <name>Awaiting Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Rejected</fullName>
        <field>Status</field>
        <literalValue>Rejected</literalValue>
        <name>Lead Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_owner_to_New_Accounts_Team</fullName>
        <description>Set the Lead owner to New Accounts Team in Approval.</description>
        <field>OwnerId</field>
        <lookupValue>New_Accounts_Team</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Lead owner to New Accounts Team</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
