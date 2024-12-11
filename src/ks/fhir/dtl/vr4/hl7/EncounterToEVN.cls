Class ks.fhir.dtl.vr4.hl7.EncounterToEVN Extends (Ens.DataTransformDTL, Commons) [ DependsOn = (HS.FHIR.DTL.vR4.Model.Resource.Encounter, EnsLib.HL7.Segment) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

Parameter FHIResourceType = "Patient";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.DTL.vR4.Model.Resource.Encounter' targetClass='EnsLib.HL7.Segment' targetDocType='2.5.1:EVN' create='new' language='objectscript' >
<if condition='source.meta.lastUpdated=""'>
 <true>
  <assign value='..CurrentDateTime("%q(0)")' property='target.{RecordedDateTime}' action='set' />
 </true>
 <false>
  <assign value='..HL7DateTime(source.meta.lastUpdated)' property='target.{RecordedDateTime}' action='set' />
 </false>
</if>
</transform>
}

}
