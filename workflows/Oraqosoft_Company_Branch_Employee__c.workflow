<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>test_Description</fullName>
        <description>test Description</description>
        <protected>false</protected>
        <recipients>
            <recipient>krishkumar@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Test</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved_Medical_Expanse</fullName>
        <field>Medical_Expense_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved Medical Expanse</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Employe_Type_Fresher</fullName>
        <field>Employee_Type__c</field>
        <literalValue>Fresher</literalValue>
        <name>Employe Type Fresher</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Medical_Expense_Pending</fullName>
        <field>Medical_Expense_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Medical Expense Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reject_Medical_Expanse</fullName>
        <field>Medical_Expense_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Reject Medical Expanse</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Employee Type</fullName>
        <actions>
            <name>Employe_Type_Fresher</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Oraqosoft_Company_Branch_Employee__c.Employee_Salary__c</field>
            <operation>equals</operation>
            <value>Less than 10000</value>
        </criteriaItems>
        <description>Update Employee type with salary less than 10k</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
