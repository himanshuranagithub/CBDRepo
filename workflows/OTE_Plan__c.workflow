<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>OTE_Plan</fullName>
        <description>OTE Plan</description>
        <protected>false</protected>
        <recipients>
            <field>Sales_Rep__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/OTE_Plan</template>
    </alerts>
</Workflow>
