Class ks.fhir.dtl.vr4.AbstractResourceIndexer Extends ReferenceResolverInterface [ Abstract ]
{

Property ResourceCount As %Integer [ ReadOnly ];

Method ResourceCountGet() As %Integer
{
  return 0
}

Method IndexResource(resource As HS.FHIR.DTL.vR4.Model.Base.Resource) As %Status [ Abstract ]
{
}

Method IndexBundle(bundle As HS.FHIR.DTL.vR4.Model.Resource.Bundle) As %Status
{
    #dim sc as %Status
    #dim ex as %Exception.AbstractException

    #dim entry as HS.FHIR.DTL.vR4.Model.Element.Bundle.entry
    #dim resource as HS.FHIR.DTL.vR4.Model.Base.Resource
    
    s sc = $$$OK
    try {
      s entry = bundle.entry.GetNext(.key) 
      while $isobject(entry) {
        $$$TOE(sc,..IndexResource(entry.resource))
        s entry = bundle.entry.GetNext(.key) 
      }

    } catch (ex) {
      s sc = ex.AsStatus()
    }
    return sc
}

Method IndexFile(fileName As %String) As %Status
{
    #dim sc as %Status
    #dim ex as %Exception.AbstractException
    #dim resource As HS.FHIR.DTL.vR4.Model.Base.Resource
    
    s sc = $$$OK
    try {
        s resource = ##class(HS.FHIR.DTL.Util.JSON.Adapter).FromJSONFile(fileName,"vR4")
        if $isobject(resource) {
            $$$TOE(sc,..IndexResource(resource))
        }
    } catch (ex) {
      s sc = ex.AsStatus()
    }
    return sc
}

Method IndexStream(stream As %Stream.Object) As %Status
{
    #dim sc as %Status
    #dim ex as %Exception.AbstractException
    #dim resource As HS.FHIR.DTL.vR4.Model.Base.Resource
    
    s sc = $$$OK
    try {
        s resource = ##class(HS.FHIR.DTL.Util.JSON.Adapter).FromJSON(stream,"vR4")
        if $isobject(resource) {
            $$$TOE(sc,..IndexResource(resource))
        }
    } catch (ex) {
      s sc = ex.AsStatus()
    }
    return sc
}

Method IndexDir(directory As %String) As %Status
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException

  #dim list as %ListOfObjects  
  #dim resource as HS.FHIR.DTL.vR4.Model.Base.Resource
  #dim k as %String
  
  s sc = $$$OK
  try {
    $$$TOE(sc,##class(HS.FHIR.DTL.Util.JSON.Adapter).FromJSONDir(directory,.list,"vR4"))
    s resource = list.GetNext(.k)
    while $isobject(resource) {
      $$$TOE(sc,..IndexResource(resource))
      s resource = list.GetNext(.k)
    }
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

Method VisitResources(visitor As ResourceVisitorInterface) As %Status [ Abstract ]
{
}

Method ResolveReference(reference As HS.FHIR.DTL.vR4.Model.Base.Reference, Output sc As %Status) As HS.FHIR.DTL.vR4.Model.Base.Resource [ Abstract ]
{
}

}
