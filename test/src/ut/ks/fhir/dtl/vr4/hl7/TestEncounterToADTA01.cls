Class ut.ks.fhir.dtl.vr4.hl7.TestEncounterToADTA01 Extends ks.lib.test.TestCase
{

Method TestTransform()
{
    #dim sc as %Status
    #dim ex as %Exception.AbstractException

    #dim bundle as HS.FHIR.DTL.vR4.Model.Resource.Bundle
    #dim encounter as HS.FHIR.DTL.vR4.Model.Resource.Encounter
    #dim reader as ks.fhir.dtl.vr4.ArrayResourceIndexer
    #dim adt as EnsLib.HL7.Message
    
    s sc = $$$OK
    try {
        s reader = ##class(ks.fhir.dtl.vr4.ArrayResourceIndexer).%New()
        $$$TOE(sc,reader.IndexFile(..ResourceFile("fhir/Alfred550_West559_6872def5-772f-427c-3053-de6e1c71ce0a.json")))
        s reference = ##class(HS.FHIR.DTL.vR4.Model.Base.Reference).%New()
        s reference.reference="urn:id:b81dc90d-2b47-0a2b-359b-e488a3151a3c"
        s encounter = reader.ResolveReference(reference)
        d $$$AssertTrue($isobject(encounter))
        $$$TOE(sc,##class(ks.fhir.dtl.vr4.hl7.EncounterToADTA01).Transform(encounter,.adt,reader))
        d $$$AssertTrue($isobject(adt))
        d $$$LogMessage(adt.OutputToString())
    } catch (ex) {
      s sc = ex.AsStatus()
    }
    d $$$AssertStatusOK(sc)
}

}
