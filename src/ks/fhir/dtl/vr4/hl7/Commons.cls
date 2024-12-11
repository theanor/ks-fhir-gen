Class ks.fhir.dtl.vr4.hl7.Commons Extends Ens.Rule.FunctionSet [ Abstract ]
{

Parameter FHIResourceType;

ClassMethod HL7Gender(value As %String) As %String [ CodeMode = expression ]
{
$case(value,"":"","male":"M","female":"F",:"U")
}

ClassMethod HL7Date(value As %String) As %String [ CodeMode = expression ]
{
##class(Ens.Util.FunctionSet).ConvertDateTime(value,"%q(2)","%q(0)")
}

ClassMethod HL7DateTime(value As %String) As %String [ CodeMode = expression ]
{
##class(Ens.Util.FunctionSet).ConvertDateTime(##class(%DateTime).XSDToLogical(value),"%Y-%m-%d %H:%M:%S","%q(0)")
}

ClassMethod HL7CX(value As HS.FHIR.DTL.vR4.Model.Datatype.Identifier, segment As EnsLib.HL7.Segment) As %String [ CodeMode = expression ]
{
$listtostring($listbuild(segment.Escape(value.value),"","",segment.Escape(value.assigner),segment.Escape(value.type.coding.GetAt(1).code),segment.Escape(value.type.coding.GetAt(1).system)),$extract(segment.Separators,2))
}

ClassMethod HL7PatientClass(encounter As HS.FHIR.DTL.vR4.Model.Resource.Encounter) As %String [ CodeMode = expression ]
{
$select(encounter.class.system="http://terminology.hl7.org/CodeSystem/v3-ActCode":$case(encounter.class.code,"AMB":"O","IMP":"I","EMER":"E",:"N"),1:"N")
}

}
