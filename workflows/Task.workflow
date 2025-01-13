<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Activity_type</fullName>
        <field>Activity_Type__c</field>
        <literalValue>E-mail</literalValue>
        <name>Activity type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Subject_for_Task</fullName>
        <field>Subject</field>
        <formula>LEFT(TEXT( Activity_Type__c),50)</formula>
        <name>Set Subject for Task</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Subject_for_Task_1</fullName>
        <field>Subject</field>
        <formula>LEFT(TEXT(  Type ),50)</formula>
        <name>Set Subject for Task</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Summary_to_Short_Description</fullName>
        <description>Set Summary short description</description>
        <field>Summary__c</field>
        <formula>LEFT(Description,100)&amp;&apos;...&apos;</formula>
        <name>Set Summary to Short Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Task_Type_From_Email</fullName>
        <field>Task_Type__c</field>
        <formula>(&quot;Email&quot;)</formula>
        <name>Set Task Type From Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Task_Type</fullName>
        <field>Task_Type__c</field>
        <formula>IF(
   ISBLANK(LEFT(TEXT(Type ),50))=TRUE,
           LEFT(TEXT( Activity_Type__c),50),
           LEFT(TEXT(Type ),50)
)</formula>
        <name>Update Task Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
