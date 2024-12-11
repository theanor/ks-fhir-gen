Class ks.fhir.dtl.vr4.hl7.ResourceToMSH Extends (Ens.DataTransformDTL, Commons) [ DependsOn = (HS.FHIR.DTL.vR4.Model.Resource.Encounter, EnsLib.HL7.Segment) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

Parameter FHIResourceType = "Patient";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.DTL.vR4.Model.Resource.Encounter' targetClass='EnsLib.HL7.Segment' targetDocType='2.5.1:MSH' create='new' language='objectscript' >
 <code>
   s tSC = target.SetValueAt(..CurrentDateTime("%q(0)"),"7")
   s tSC = target.SetValueAt(##class(EnsLib.HL7.Message).NewControlID(),"10")
   s tSC = target.SetValueAt("T","11")
   s tSC = target.SetValueAt("2.5.1","12")
 </code>
</transform>
}

}
