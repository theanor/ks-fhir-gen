/// 
Class ks.fhir.dtl.vr4.hl7.DefaultTransformRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "Ens.Rule.GeneralBusinessRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="ks.fhir.dtl.vr4.bs.SyntheaGeneratorService" production="">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="Transform inbound patient Encounter resource into ADT^A01" disabled="false">
<when condition="(Resource.resourceType=&quot;Encounter&quot;) &amp;&amp; (HL7PatientClass(Resource)=&quot;I&quot;) " comment="">
<assign property="Transform" value="&quot;ks.fhir.dtl.vr4.hl7.EncounterToADTA01&quot;"></assign>
<return>1</return>
</when>
</rule>
<return>0</return>
</ruleSet>
</ruleDefinition>
}

}
