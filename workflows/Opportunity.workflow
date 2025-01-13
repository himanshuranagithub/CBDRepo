<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Abandon_Opp</fullName>
        <field>StageName</field>
        <literalValue>Closed Lost</literalValue>
        <name>Abandon Opp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>In_Approval_Process</fullName>
        <field>In__c</field>
        <literalValue>1</literalValue>
        <name>In Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lock_Flag_Disabled</fullName>
        <field>Opportunity_Locked_Under_Pricing_Review__c</field>
        <literalValue>0</literalValue>
        <name>Lock Flag Disabled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lock_Record_Flag_Enabled</fullName>
        <field>Opportunity_Locked_Under_Pricing_Review__c</field>
        <literalValue>1</literalValue>
        <name>Lock Record Flag Enabled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Not_In_Approval_Process</fullName>
        <field>In__c</field>
        <literalValue>0</literalValue>
        <name>Not In Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Price_Approval_Completed</fullName>
        <field>Price_Approval_Completed__c</field>
        <literalValue>1</literalValue>
        <name>Price Approval Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opportunity_Close_Date</fullName>
        <field>CloseDate</field>
        <formula>TODAY()+90</formula>
        <name>Set Opportunity Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opportunity_Name</fullName>
        <field>Name</field>
        <formula>Account.Name &amp; &quot;-&quot; &amp; TEXT(DATEVALUE(CreatedDate))&amp; &quot;-&quot; &amp; Project__c</formula>
        <name>Set Opportunity Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opportunity_Name_2</fullName>
        <field>Name</field>
        <formula>LEFT(Account.Name,60)  &amp; &quot; - &quot; &amp;  Opportunity_Short_Name__c &amp; &quot; - &quot; &amp;  Identitfier__c</formula>
        <name>Set Opportunity Name 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opportunity_Stage_to_Proposal</fullName>
        <field>StageName</field>
        <literalValue>Proposal</literalValue>
        <name>Set Opportunity Stage to Proposal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opportunity_Stage_to_Qualification</fullName>
        <field>StageName</field>
        <literalValue>Qualification</literalValue>
        <name>Set Opportunity Stage to: Qualification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type_to_Government</fullName>
        <field>RecordTypeId</field>
        <lookupValue>RFP</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update - Record Type to Government</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type_to_Program</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Programs</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update - Record Type to Program</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type_to_Programs</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Programs</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update - Record Type to Programs</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
