<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>MKT_CHK_W_R_TYPE</fullName>
        <field>Mkt__c</field>
        <literalValue>1</literalValue>
        <name>MKT CHK W R.TYPE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SET_LAST_NAME</fullName>
        <field>LastName</field>
        <formula>UPPER(LEFT( LastName , 1))+
IF(OR(BEGINS(LOWER(LastName) , &quot;mc&quot;),BEGINS(LOWER(LastName) , &quot;o&apos;&quot;)),LOWER(MID(LastName,2,1))+UPPER(MID(LastName,3,1))+LOWER(MID(LastName,4,80)),
IF(BEGINS(LOWER(LastName) , &quot;mac&quot;),&quot;ac&quot;+UPPER(MID(LastName,4,1))+LOWER(MID(LastName,5,80)),
 LOWER(MID(LastName, 2,80))))</formula>
        <name>set last name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>first_name</fullName>
        <field>FirstName</field>
        <formula>UPPER(LEFT( FirstName , 1)) + LOWER(MID(FirstName, 2,80))</formula>
        <name>first name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
