Class ks.fhir.dtl.vr4.hl7.ObservationToOBX Extends (Ens.DataTransformDTL, Commons) [ DependsOn = (HS.FHIR.DTL.vR4.Model.Resource.Observation, EnsLib.HL7.Segment) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

Parameter FHIResourceType = "Patient";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.DTL.vR4.Model.Resource.Encounter' targetClass='EnsLib.HL7.Segment' targetDocType='2.5.1:OBX' create='new' language='objectscript' >
  
  <if condition='source.valueCodeableConcept &apos;=""'>
    <true>
     <assign property='target.{2}' value='"CE"' action='set' />
     <assign property='target.{5.1}' value='source.valueCodeableConcept.coding.(1).code' action='set' />
     <assign property='target.{5.2}' value='source.valueCodeableConcept.coding.(1).display' action='set' />
     <assign property='target.{5.3}' value='..HL7CodeSystem(source.valueCodeableConcept.coding.(1).system)' action='set' />
    </true>
  </if>

  <if condition='source.valueQuantity &apos;=""'>
    <true>
     <assign property='target.{2}' value='"NM"' action='set' />
     <assign property='target.{5}' value='source.valueQuantity.value' action='set' />
     <assign property='target.{6.1}' value='source.valueQuantity.code' action='set' />
     <assign property='target.{6.2}' value='source.valueQuantity.unit' action='set' />
     <assign property='target.{6.3}' value='..HL7CodeSystem(source.valueQuantity.system)' action='set' />
    </true>
  </if>

  <assign property='target.{4.1}' value='source.code.coding.(1).code' action='set' />
  <assign property='target.{4.2}' value='source.code.coding.(1).display' action='set' />
  <assign property='target.{4.3}' value='..HL7CodeSystem(source.code.coding.(1).system)' action='set' />

  <assign property='target.{14}' value='..HL7DateTime(source.effectiveDateTime)' action='set' />
  <assign property='target.{19}' value='..HL7DateTime(source.issued)' action='set' />
</transform>
}

}
