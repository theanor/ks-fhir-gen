/// vR4 Patient resource into HL7 v2.5.1 PID segment
Class ks.fhir.dtl.vr4.hl7.PatientToPID Extends (Ens.DataTransformDTL, Commons) [ DependsOn = (HS.FHIR.DTL.vR4.Model.Resource.Patient, EnsLib.HL7.Segment) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

Parameter FHIResourceType = "Patient";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.DTL.vR4.Model.Resource.Patient' targetClass='EnsLib.HL7.Segment' targetDocType='2.5.1:PID' create='new' language='objectscript' >
<assign value='source.id' property='target.{PatientID.IDNumber}' action='set' />
<foreach property='source.identifier()' key='ik'>
  <assign value='..HL7CX(source.identifier.(ik),target)' property='target.{PatientIdentifierList(ik).IDNumber}' action='set' />
</foreach>
<foreach property='source.name()' key='nk' >
<assign value='source.name.(nk).family' property='target.{PatientName(nk).FamilyName.Surname}' action='set' />
<assign value='source.name.(nk).given.(1)' property='target.{PatientName(nk).GivenName}' action='set' />
<assign value='source.name.(nk).prefix.(1)' property='target.{PatientName(nk).Prefix}' action='set' />
<assign value='source.name.(nk).suffix.(1)' property='target.{PatientName(nk).Suffix}' action='set' />
<assign value='..HL7DateTime(source.name.(nk).period.start)' property='target.{PatientName(nk).EffectiveDate}' action='set' />
<assign value='..HL7DateTime(source.name.(nk).period.end)' property='target.{PatientName(nk).ExpirationDate}' action='set' />
</foreach>
<assign value='..HL7Gender(source.gender)' property='target.{AdministrativeSex}' action='set' />
<assign value='..HL7Date(source.birthDate)' property='target.{DateTimeofBirth}' action='set' />
<assign value='source.deceasedBoolean' property='target.{PatientDeathIndicator}' action='set' />
<assign value='source.deceasedDateTime' property='target.{PatientDeathDateandTime}' action='set' />
<foreach property='source.address()' key='ak' >
<assign value='source.address.(ak).city' property='target.{PatientAddress(ak).City}' action='set' />
<assign value='source.address.(ak).state' property='target.{PatientAddress(ak).StateorProvince}' action='set' />
<assign value='source.address.(ak).postalCode' property='target.{PatientAddress(ak).ZiporPostalCode}' action='set' />
<assign value='..HL7DateTime(source.address.(ak).period.start)' property='target.{PatientAddress(ak).EffectiveDate}' action='set' />
<assign value='..HL7DateTime(source.address.(ak).period.end)' property='target.{PatientAddress(ak).ExpirationDate}' action='set' />
<assign value='source.address.(ak).line.(1)' property='target.{PatientAddress(ak).StreetAddress}' action='set' />
<assign value='source.address.(ak).country' property='target.{PatientAddress(ak).Country}' action='set' />
</foreach>
</transform>
}

}
