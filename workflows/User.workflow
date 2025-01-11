<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Audit_Email</fullName>
        <description>Audit Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>duane.aylsworth@kooziegroup.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>john.harris@kooziegroup.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sfmcadmin@kooziegroup.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>victor@bicgraphic.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Audit_Check</template>
    </alerts>
</Workflow>
