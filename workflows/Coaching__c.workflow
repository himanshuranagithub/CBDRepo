<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Opportunity_Coaching</fullName>
        <description>Opportunity Coaching</description>
        <protected>false</protected>
        <recipients>
            <field>Sales_Rep__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Coaching</template>
    </alerts>
    <alerts>
        <fullName>Skills_Coaching</fullName>
        <description>Skills Coaching</description>
        <protected>false</protected>
        <recipients>
            <field>Sales_Rep__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SKills_Coaching</template>
    </alerts>
</Workflow>
