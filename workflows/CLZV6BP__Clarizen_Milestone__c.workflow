<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>clz_f4604699-838b-4580-927f-ae3ca9a8c305</fullName>
        <actions>
            <name>clz_b75f0da11f294ae096c58fc39ae66554</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <formula>CreatedDate&gt;=DATETIMEVALUE(&apos;2022-07-19 00:00:00&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
