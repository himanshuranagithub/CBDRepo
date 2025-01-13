<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Marketing Project%3A New Designer Assigned</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Designer_Assigned__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email notification to designer that new project has been assigned</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Project Submitted</fullName>
        <actions>
            <name>Email_Alert_New_Project_Submitted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted/Locked</value>
        </criteriaItems>
        <description>Email notification to Trade Marketing Services once a new project is submitted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification - Designer Assigned</fullName>
        <actions>
            <name>Designer_has_been_assigned</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Email notification a Designer has been assigned</description>
        <formula>(ISNEW() &amp;&amp; NOT(ISBLANK(Designer_Assigned__c))) ||

ISCHANGED(Designer_Assigned__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Page Layout Change - Marketing Project</fullName>
        <actions>
            <name>Marketing_Project_Record_Type_Switch</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Created</value>
        </criteriaItems>
        <criteriaItems>
            <field>Marketing_Projects__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Custom Calendar</value>
        </criteriaItems>
        <description>Changes From Create to Master Page Layout</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Page Layout Change - Marketing Project%092</fullName>
        <actions>
            <name>Marketing_Project_Record_Type_Switch_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Product_Type__c</field>
            <operation>equals</operation>
            <value>Newsletter</value>
        </criteriaItems>
        <description>Changes From Create to Newsletter Page Layout</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project%3A Completed</fullName>
        <actions>
            <name>Marketing_Project_Completed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Marketing_Projects__c.Status__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <description>Email notification once project is completed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
