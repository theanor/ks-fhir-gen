Class ks.fhir.dtl.vr4.hl7.EncounterToADTA01 Extends (Ens.DataTransformDTL, Commons) [ DependsOn = (HS.FHIR.DTL.vR4.Model.Resource.Encounter, EnsLib.HL7.Message) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

Parameter FHIResourceType = "Patient";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.DTL.vR4.Model.Resource.Encounter' targetClass='EnsLib.HL7.Message' targetDocType='2.5.1:ADT_A01' create='new' language='objectscript' >
<assign value='aux.ResolveReference(source.subject)' property='patient' action='set' />
<subtransform class='ks.fhir.dtl.vr4.hl7.ResourceToMSH' targetObj='target.{MSH}' sourceObj='source' aux='aux' />
<assign value='"ADT"' property='target.{MSH:9.1}' action='set' />
<assign value='"A01"' property='target.{MSH:9.2}' action='set' />
<subtransform class='ks.fhir.dtl.vr4.hl7.PatientToPID' targetObj='target.{PID}' sourceObj='patient' aux='aux' />
<subtransform class='ks.fhir.dtl.vr4.hl7.EncounterToEVN' targetObj='target.{EVN}' sourceObj='source' aux='aux' />
<subtransform class='ks.fhir.dtl.vr4.hl7.EncounterToPV1' targetObj='target.{PV1}' sourceObj='source' aux='aux'  />
</transform>
}

}
