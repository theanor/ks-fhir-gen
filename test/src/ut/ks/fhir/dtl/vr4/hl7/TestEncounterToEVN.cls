Class ut.ks.fhir.dtl.vr4.hl7.TestEncounterToPV1 Extends ks.lib.test.TestCase
{

Method TestTransform()
{
    #dim sc as %Status
    #dim ex as %Exception.AbstractException

    #dim bundle as HS.FHIR.DTL.vR4.Model.Resource.Bundle
    #dim encounter as HS.FHIR.DTL.vR4.Model.Resource.Encounter
    #dim evn as EnsLib.HL7.Segment
    
    s sc = $$$OK
    try {
        s bundle = ##class(HS.FHIR.DTL.vR4.Model.Resource.Bundle).FromJSONFile(..ResourceFile("fhir/Alfred550_West559_6872def5-772f-427c-3053-de6e1c71ce0a.json"),"vR4")
        d $$$AssertTrue($isobject(bundle))
        s encounter = bundle.entry.GetAt(2).resource
        d $$$AssertTrue($isobject(encounter))
        $$$TOE(sc,##class(ks.fhir.dtl.vr4.hl7.EncounterToEVN).Transform(encounter,.evn))
        d $$$AssertTrue($isobject(evn))
        d $$$LogMessage(evn.OutputToString())
    } catch (ex) {
      s sc = ex.AsStatus()
    }
    d $$$AssertStatusOK(sc)
}

}
