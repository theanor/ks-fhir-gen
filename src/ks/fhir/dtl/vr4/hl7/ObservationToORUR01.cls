Class ks.fhir.dtl.vr4.hl7.ObservationToORUR01 Extends (Ens.DataTransformDTL, Commons) [ DependsOn = (HS.FHIR.DTL.vR4.Model.Resource.Observation, EnsLib.HL7.Message) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

Parameter FHIResourceType = "Patient";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.DTL.vR4.Model.Resource.Observation' targetClass='EnsLib.HL7.Message' targetDocType='2.5.1:ORU_R01' create='new' language='objectscript' >
<assign value='aux.ResolveReference(source.subject)' property='patient' action='set' />
<assign value='aux.ResolveReference(source.encounter)' property='encounter' action='set' />
<subtransform class='ks.fhir.dtl.vr4.hl7.ResourceToMSH' targetObj='target.{MSH}' sourceObj='source' aux='aux' />
<assign value='"ORU"' property='target.{MSH:9.1}' action='set' />
<assign value='"R01"' property='target.{MSH:9.2}' action='set' />
<subtransform class='ks.fhir.dtl.vr4.hl7.PatientToPID' targetObj='target.{PIDgrpgrp(1).PIDgrp.PID}' sourceObj='patient' aux='aux' />
<subtransform class='ks.fhir.dtl.vr4.hl7.EncounterToPV1' targetObj='target.{PIDgrpgrp(1).PIDgrp.PV1grp.PV1}' sourceObj='encounter' aux='aux'  />
<subtransform class='ks.fhir.dtl.vr4.hl7.ObservationToOBR' targetObj='target.{PIDgrpgrp(1).ORCgrp(1).OBR}' sourceObj='source' aux='aux'  />
<subtransform class='ks.fhir.dtl.vr4.hl7.ObservationToOBX' targetObj='target.{PIDgrpgrp(1).ORCgrp(1).OBXgrp(1).OBX}' sourceObj='source' aux='aux'  />
</transform>
}

}
