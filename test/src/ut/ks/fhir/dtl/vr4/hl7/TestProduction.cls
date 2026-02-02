Class ut.ks.fhir.dtl.vr4.hl7.TestProduction Extends ks.lib.test.TestProduction [ DependsOn = ut.ks.fhir.dtl.vr4.hl7.Production ]
{

Parameter PRODUCTION = "ut.ks.fhir.dtl.vr4.hl7.Production";

Parameter IGNOREPRODUCTIONERRORS = 1;

Parameter MINRUN = 120;

Method OnBeforeAllTests() As %Status
{
    #dim sc as %Status = $$$OK
    #dim ex as %Exception.AbstractException
    
    try {
    }
    catch (ex) {
      s sc = ex.AsStatus()
    }
    q sc
}

Method TestDummy()
{
}

Method OnBeforeProductionStart() As %Status
{
    #dim sc as %Status
    #dim ex as %Exception.AbstractException
    
    s sc = $$$OK
    try {
      $$$TOE(sc,..CreateMainDirTree())        
      $$$TOE(sc,..ChangeSetting(..#PRODUCTION,"HL7ToFile","FilePath",..HL7OutputDir,1))  
    } catch (ex) {
      s sc = ex.AsStatus()
    }
    return sc
}

Method OnAfterProductionStart() As %Status
{
    #dim sc as %Status
    #dim ex as %Exception.AbstractException
    
    s sc = $$$OK
    try {
    } catch (ex) {
      s sc = ex.AsStatus()
    }
    return sc
}

Method CheckResults(ByRef log As %String, new As %String) As %Status
{
    #dim sc as %Status
    #dim ex as %Exception.AbstractException
    
    s sc = $$$OK
    try {
    } catch (ex) {
      s sc = ex.AsStatus()
    }
    return sc
}

}
