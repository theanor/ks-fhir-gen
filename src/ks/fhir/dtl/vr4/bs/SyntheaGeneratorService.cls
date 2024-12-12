Class ks.fhir.dtl.vr4.bs.SyntheaGeneratorService Extends ks.fhir.dtl.vr4.bs.AbstractGeneratorService
{

Parameter ADAPTER = "ks.fhir.dtl.vr4.ba.SyntheaBundleGeneratorAdapter";

Property Adapter As ks.fhir.dtl.vr4.ba.SyntheaBundleGeneratorAdapter;

/// resource indexer
Property Indexer As ks.fhir.dtl.vr4.AbstractResourceIndexer [ Private, Transient ];

Method OnInit() As %Status
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException
  
  s sc = $$$OK
  try {
    s ..Indexer = ##class(ks.fhir.dtl.vr4.ArrayResourceIndexer).%New()
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

Method OnProcessInput(input As HS.FHIR.DTL.vR4.Model.Base.Resource) As %Status
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException
  
  s sc = $$$OK
  try {
    if ..Adapter.BatchComplete {
      $$$TRACE("batch complete, visiting generated resources")
      $$$TOE(sc,..Indexer.VisitResources($this))
    } else {
      $$$TRACE("processing resource "_input.id_" ("_input.resourceType_")")
      $$$TOE(sc,..Indexer.IndexResource(input))
    }
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

}
