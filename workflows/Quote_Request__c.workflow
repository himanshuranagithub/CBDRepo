<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Item Name changed</fullName>
        <actions>
            <name>Item_priorvalue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(
ISCHANGED(   Item_Name__c   ),
NOT(ISBLANK( PRIORVALUE(Item_Name__c ))), 
NOT(ISNEW()),
$Profile.Name &lt;&gt; &quot;System Administrator&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
