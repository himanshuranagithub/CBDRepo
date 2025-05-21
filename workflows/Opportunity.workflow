<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Close_Date</fullName>
        <description>Close Date</description>
        <protected>false</protected>
        <recipients>
            <recipient>naveenjai@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Time_Trigger</template>
    </alerts>
    <alerts>
        <fullName>Notify_Mgr_on_the_high_value_Opportunity</fullName>
        <description>Notify Mgr on the high value Opportunity</description>
        <protected>false</protected>
        <recipients>
            <recipient>naveenjai@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_MGR</template>
    </alerts>
</Workflow>
