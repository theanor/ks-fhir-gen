Class ut.ks.fhir.dtl.vr4.hl7.TestPatientToPID Extends ks.lib.test.TestCase
{

Method TestTransform()
{
    #dim sc as %Status
    #dim ex as %Exception.AbstractException

    #dim bundle as HS.FHIR.DTL.vR4.Model.Resource.Bundle
    #dim patient as HS.FHIR.DTL.vR4.Model.Resource.Patient
    #dim pid as EnsLib.HL7.Segment
    
    s sc = $$$OK
    try {
        s bundle = ##class(HS.FHIR.DTL.vR4.Model.Resource.Bundle).FromJSONFile(..ResourceFile("fhir/Alfred550_West559_6872def5-772f-427c-3053-de6e1c71ce0a.json"),"vR4")
        d $$$AssertTrue($isobject(bundle))
        s patient = bundle.entry.GetAt(1).resource
        d $$$AssertTrue($isobject(patient))
        $$$TOE(sc,##class(ks.fhir.dtl.vr4.hl7.PatientToPID).Transform(patient,.pid))
        d $$$AssertTrue($isobject(pid))
        d $$$LogMessage(pid.OutputToString())
    } catch (ex) {
      s sc = ex.AsStatus()
    }
    d $$$AssertStatusOK(sc)
}

}
