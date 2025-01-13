<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Cadence_Owner_Change</fullName>
        <field>Cadence_Owner_Change__c</field>
        <literalValue>1</literalValue>
        <name>Cadence Owner Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_RT_to_VOC</fullName>
        <description>Update case RT to voice of Customer</description>
        <field>RecordTypeId</field>
        <lookupValue>Voice_of_Customer</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Case RT to VOC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_Day_1</fullName>
        <field>Status</field>
        <literalValue>Day 1 Call (24 Hour)</literalValue>
        <name>Change Status - Day 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_Day_3</fullName>
        <field>Status</field>
        <literalValue>Day 3 Call</literalValue>
        <name>Change Status - Day 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_Day_9</fullName>
        <field>Status</field>
        <literalValue>Day 9 Escalate to Sales</literalValue>
        <name>Change Status - Day 9</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clarification_Cancel_Clarification</fullName>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Clarification - Cancel Clarification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clarification_Stop_Notifications</fullName>
        <field>Stop_Notifications__c</field>
        <literalValue>1</literalValue>
        <name>Clarification - Stop Notifications</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CloseDateForAgeFormula</fullName>
        <field>CloseDateForAge_Alternative__c</field>
        <formula>IF(
	CloseDaylightSavingsForAge__c,
	IF(
		AND(
			DATETIMEVALUE(CloseOrNowForAge__c)&gt;DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c), 10))),
			OR(
				AND(HOUR(TIMEVALUE(CloseOrNowForAge__c))=11,MINUTE(TIMEVALUE(CloseOrNowForAge__c))&lt;30),
				HOUR(TIMEVALUE(CloseOrNowForAge__c))&lt;11
			)
		),
		CASE(WEEKDAY(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c), 10))),
			7, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c), 10))+2)+(11.5/24),
			1, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c), 10))+1)+(11.5/24),
			DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c), 10)))+(11.5/24)
		),
		CASE(WEEKDAY(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c-(4/24)), 10))),
			7, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c-(4/24)), 10))+2)+(11.5/24),
			1, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c-(4/24)), 10))+1)+(11.5/24),
			CloseOrNowForAge__c
		)
	),
	IF(
		AND(
			DATETIMEVALUE(CloseOrNowForAge__c)&gt;DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c+1/24), 10))),
			OR(
				AND(HOUR(TIMEVALUE(CloseOrNowForAge__c))=12,MINUTE(TIMEVALUE(CloseOrNowForAge__c))&lt;30),
				HOUR(TIMEVALUE(CloseOrNowForAge__c))&lt;12
			)
		),
		CASE(WEEKDAY(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c), 10))),
			7, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c), 10))+2)+(12.5/24),
			1, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c), 10))+1)+(12.5/24),
			DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c), 10)))+(12.5/24)
		),
		CASE(WEEKDAY(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c-(5/24)), 10))),
			7, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c-(5/24)), 10))+2)+(12.5/24),
			1, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(CloseOrNowForAge__c-(5/24)), 10))+1)+(12.5/24),
			CloseOrNowForAge__c
		)
	)
)</formula>
        <name>CloseDateForAgeFormula</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Close_Case</fullName>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Close Case</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_11_Final_Notice</fullName>
        <field>Current_Process__c</field>
        <literalValue>Day 11 Final Notice</literalValue>
        <name>Day 11 - Final Notice</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_12_Cancellation</fullName>
        <field>Current_Process__c</field>
        <literalValue>Day 12 Cancellation</literalValue>
        <name>Day 12 - Cancellation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_1_Call</fullName>
        <field>Current_Process__c</field>
        <literalValue>Confirmation/Reminder Call - 24 Hr</literalValue>
        <name>Day 1 - Call</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_1_Change_Owner</fullName>
        <field>OwnerId</field>
        <lookupValue>Clar_Tier_I</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Day 1 - Change Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_3_Change_Owner</fullName>
        <field>OwnerId</field>
        <lookupValue>Clar_Tier_I</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Day 3 - Change Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_3_Reminder_Call</fullName>
        <field>Status</field>
        <literalValue>Day 3 Call</literalValue>
        <name>Day 3 - Reminder Call</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_6_Reminder_Email</fullName>
        <field>Current_Process__c</field>
        <literalValue>Day 6 Reminder Email</literalValue>
        <name>Day 6 - Reminder Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_6_Reminder_Email_Check</fullName>
        <field>Day_6_Reminder_Email_Sent__c</field>
        <literalValue>1</literalValue>
        <name>Day 6 Reminder Email Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_9_Change_Owner</fullName>
        <field>OwnerId</field>
        <lookupValue>Clar_Tier_I</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Day 9 - Change Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Day_9_Escalate_to_Sales</fullName>
        <field>Status</field>
        <literalValue>Day 9 Escalate to Sales</literalValue>
        <name>Day 9 - Escalate to Sales</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pause_Entitlement</fullName>
        <field>IsStopped</field>
        <literalValue>1</literalValue>
        <name>Pause Entitlement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ReOpenDateForAgeFormula</fullName>
        <field>ReopenDateForAge_Alternative__c</field>
        <formula>IF(
	DaylightSavingsForAging__c,
	IF(
		AND(
			DATETIMEVALUE(Aging_Reopened__c)&gt;DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c), 10))),
			OR(
				AND(HOUR(TIMEVALUE(Aging_Reopened__c))=11,MINUTE(TIMEVALUE(Aging_Reopened__c))&lt;30),
				HOUR(TIMEVALUE(Aging_Reopened__c))&lt;11
			)
		),
		CASE(WEEKDAY(DATEVALUE(LEFT(TEXT(Aging_Reopened__c), 10))),
			7, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c), 10))+2)+(11.5/24),
			1, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c), 10))+1)+(11.5/24),
			DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c), 10)))+(11.5/24)
		),
		CASE(WEEKDAY(DATEVALUE(LEFT(TEXT(Aging_Reopened__c-(4/24)), 10))),
			7, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c-(4/24)), 10))+2)+(11.5/24),
			1, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c-(4/24)), 10))+1)+(11.5/24),
			Aging_Reopened__c
		)
	),
	IF(
		AND(
			DATETIMEVALUE(Aging_Reopened__c)&gt;DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c+1/24), 10))),
			OR(
				AND(HOUR(TIMEVALUE(Aging_Reopened__c))=12,MINUTE(TIMEVALUE(Aging_Reopened__c))&lt;30),
				HOUR(TIMEVALUE(Aging_Reopened__c))&lt;12
			)
		),
		CASE(WEEKDAY(DATEVALUE(LEFT(TEXT(Aging_Reopened__c), 10))),
			7, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c), 10))+2)+(12.5/24),
			1, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c), 10))+1)+(12.5/24),
			DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c), 10)))+(12.5/24)
		),
		CASE(WEEKDAY(DATEVALUE(LEFT(TEXT(Aging_Reopened__c-(5/24)), 10))),
			7, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c-(5/24)), 10))+2)+(12.5/24),
			1, DATETIMEVALUE(DATEVALUE(LEFT(TEXT(Aging_Reopened__c-(5/24)), 10))+1)+(12.5/24),
			Aging_Reopened__c
		)
	)
)</formula>
        <name>ReOpenDateForAgeFormula</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>StampTimeUsers</fullName>
        <field>Case_Collaborative_Notes__c</field>
        <formula>Case_Collaborative_Notes__c &amp; br()&amp; &quot;[&quot; &amp;
 LEFT( $User.FirstName,1) &amp; &quot; &quot; &amp; $User.LastName &amp; &quot;: &quot; &amp; TEXT(MONTH(DATEVALUE(NOW())))+&quot;/&quot; +TEXT(DAY( DATEVALUE(NOW())))+&quot;/&quot; +TEXT(YEAR(DATEVALUE(NOW()))) &amp;&quot;]&quot;&amp;&quot;.&quot;</formula>
        <name>StampTimeUsers</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stamp_it</fullName>
        <field>Description</field>
        <formula>Description &amp; &quot;--&quot; &amp; LEFT( $User.FirstName,1) &amp; &quot; &quot; &amp; $User.LastName &amp; &quot;: &quot; &amp; TEXT(MONTH(DATEVALUE(NOW())))+&quot;/&quot; +TEXT(DAY( DATEVALUE(NOW())))+&quot;/&quot; +TEXT(YEAR(DATEVALUE(NOW()))) &amp; &quot;|&quot;</formula>
        <name>Stamp it</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Send_Clarification_Email_Flag</fullName>
        <field>Send_Clarification_Email_Flag__c</field>
        <literalValue>1</literalValue>
        <name>Update Send Clarification Email Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Send_Email_Flag_to_True</fullName>
        <field>Send_Email_Flag__c</field>
        <literalValue>1</literalValue>
        <name>Update Send Email Flag to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
