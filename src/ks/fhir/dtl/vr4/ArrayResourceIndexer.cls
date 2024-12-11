Class ks.fhir.dtl.vr4.ArrayResourceIndexer Extends AbstractResourceIndexer
{

Property Resources As array Of HS.FHIR.DTL.vR4.Model.Base.Resource(CLASSNAME = 1) [ Private ];

Method ResourceCountGet() As %Integer
{
  return ..Resources.Count()
}

Method IndexResource(resource As HS.FHIR.DTL.vR4.Model.Base.Resource) As %Status
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException
  
  s sc = $$$OK
  try {
    if resource.%Extends("HS.FHIR.DTL.vR4.Model.Resource.Bundle") {
      $$$TOE(sc,..IndexBundle(resource))
    } else {
      d ..Resources.SetAt(resource,resource.id)
    }    
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

Method VisitResources(visitor As ResourceVisitorInterface) As %Status
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException
  #dim k as %String
  #dim resource as HS.FHIR.DTL.vR4.Model.Base.Resource
  
  s sc = $$$OK
  try {
    s resource = ..Resources.GetNext(.k)
    while $isobject(resource) {
      $$$TOE(sc,visitor.VisitResource(resource,$this))
      s resource = ..Resources.GetNext(.k)
    }
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

Method ResolveReference(reference As HS.FHIR.DTL.vR4.Model.Base.Reference, Output sc As %Status) As HS.FHIR.DTL.vR4.Model.Base.Resource
{
    #dim ex as %Exception.AbstractException
    #dim result as HS.FHIR.DTL.vR4.Model.Base.Resource
    
    s sc = $$$OK
    s result = $$$NULLOREF
    try {        
        s result = ..Resources.GetAt($piece(reference.reference,":",3)) // assumes reference values are formed as urn:uuid:<id>
    } catch (ex) {
      s sc = ex.AsStatus()
    }
    return result
}

}
