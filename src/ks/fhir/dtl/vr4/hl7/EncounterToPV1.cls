Class ks.fhir.dtl.vr4.hl7.EncounterToPV1 Extends (Ens.DataTransformDTL, Commons) [ DependsOn = (HS.FHIR.DTL.vR4.Model.Resource.Encounter, EnsLib.HL7.Segment) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

Parameter FHIResourceType = "Patient";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.DTL.vR4.Model.Resource.Encounter' targetClass='EnsLib.HL7.Segment' targetDocType='2.5.1:PV1' create='new' language='objectscript' >
<assign value='..HL7PatientClass(source)' property='target.{PatientClass}' action='set' />
<assign value='source.id' property='target.{VisitNumber.IDNumber}' action='set' />
<assign value='..HL7DateTime(source.period.start)' property='target.{AdmitDateTime}' action='set' />
<assign value='..HL7DateTime(source.period.end)' property='target.{DischargeDateTime()}' action='set' />
</transform>
}

}
