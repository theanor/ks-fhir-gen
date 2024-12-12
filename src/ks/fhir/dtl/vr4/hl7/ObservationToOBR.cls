Class ks.fhir.dtl.vr4.hl7.ObservationToOBR Extends (Ens.DataTransformDTL, Commons) [ DependsOn = (HS.FHIR.DTL.vR4.Model.Resource.Observation, EnsLib.HL7.Segment) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

Parameter FHIResourceType = "Encounter";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.DTL.vR4.Model.Resource.Observation' targetClass='EnsLib.HL7.Segment' targetDocType='2.5.1:OBR' create='new' language='objectscript' >
  <assign property='target.{3}' value='source.id' action='set' />
  <assign property='target.{4.1}' value='source.code.coding.(1).code' action='set' />
  <assign property='target.{4.2}' value='source.code.coding.(1).display' action='set' />
  <assign property='target.{4.3}' value='..HL7CodeSystem(source.code.coding.(1).system)' action='set' />
</transform>
}

}
