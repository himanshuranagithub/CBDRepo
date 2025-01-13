<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AP_CHECKBOX</fullName>
        <field>InApprovalProcess__c</field>
        <literalValue>0</literalValue>
        <name>AP CHECKBOX</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AP_SB_PPT_OWNER</fullName>
        <field>OwnerId</field>
        <lookupValue>leslie.dawson@kooziegroup.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>AP SB/PPT OWNER</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>In_Approval_Process</fullName>
        <description>Mark field checked for approval process</description>
        <field>InApprovalProcess__c</field>
        <literalValue>0</literalValue>
        <name>In Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mark_project_approved</fullName>
        <field>Project_is_Approved__c</field>
        <literalValue>1</literalValue>
        <name>Mark project approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Marketing_Project_Record_Type_Switch</fullName>
        <description>From Create to Master Record Type</description>
        <field>RecordTypeId</field>
        <lookupValue>Standard_Project</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Marketing Project Record Type Switch</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Marketing_Project_Record_Type_Switch_2</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Newsletter_Marketing_Project</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Marketing Project Record Type Switch 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Not_In_Approval_Process</fullName>
        <field>InApprovalProcess__c</field>
        <literalValue>0</literalValue>
        <name>Not In Approval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Request_Rejected</fullName>
        <description>Project request rejected (lead time &lt; 7 days)</description>
        <field>Status__c</field>
        <literalValue>Created</literalValue>
        <name>Project Request Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submission_Due_Date</fullName>
        <field>Due_Date_Project_Submission__c</field>
        <formula>if( Due_Date_Project_Submission__c &gt; DATEVALUE(CreatedDate) + 5, Due_Date_Project_Submission__c, DATEVALUE(CreatedDate) + 5)</formula>
        <name>Submission Due Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_to_Creative</fullName>
        <description>Field update if project requires lead time of less than 7 days</description>
        <field>Status__c</field>
        <literalValue>Submitted to Creative</literalValue>
        <name>Submitted to Creative</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Inapproval_Process</fullName>
        <field>InApprovalProcess__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Inapproval Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Submit_to_creative</fullName>
        <field>Status__c</field>
        <literalValue>Submitted to Creative</literalValue>
        <name>Update Submit to creative</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
