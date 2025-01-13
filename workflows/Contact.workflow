<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Correct Case for Names</fullName>
        <actions>
            <name>SET_LAST_NAME</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>first_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Contact.FirstName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.LastName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Making sure that case for names are corrected to the right format : Example - BOB SMITH - Bob Smith</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MKT CHK W R%2ETYPE</fullName>
        <actions>
            <name>MKT_CHK_W_R_TYPE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(CASE(PRIORVALUE(Responsibility_Type__c),&quot;Clarifications&quot;,1,&quot;Invoice&quot;,1,&quot;Website&quot;,1,0)=1,
TEXT( Responsibility_Type__c )=&quot;Sales_Service&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>clz_2022a9f0-e48d-4ca0-b543-ff49f016d074</fullName>
        <actions>
            <name>clz_6349493ff00946d992ff379b9958d449</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <formula>(Account.Name&lt;&gt;null)&amp;&amp;(Email&lt;&gt;null)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
