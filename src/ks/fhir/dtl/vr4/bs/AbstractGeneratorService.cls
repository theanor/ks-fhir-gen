Class ks.fhir.dtl.vr4.bs.AbstractGeneratorService Extends (Ens.BusinessService, ks.fhir.dtl.vr4.ResourceVisitorInterface)
{

Parameter SETTINGS = "TargetConfigNames,TransformRule:Additional:ruleSelector,RuleLogging:Dev";

/// Generated messages target config name(s)
Property TargetConfigNames As Ens.DataType.ConfigName;

/// Business rule used to select transformation class
Property TransformRule As %Dictionary.Classname [ InitialExpression = "ks.fhir.dtl.vr4.hl7.DefaultTransformRule" ];

/// Rule logging
Property RuleLogging As %String;

/// Set this transient property during rule evaluation to the selected transform class name
Property Transform As %Dictionary.Classname [ Transient ];

/// Current resource, available during rule evaluation
Property Resource As HS.FHIR.DTL.vR4.Model.Base.Resource [ Transient ];

Method VisitResource(resource As %RegisteredObject, referenceResolver As ks.fhir.dtl.vr4.ReferenceResolverInterface) As %Status
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException
  
  s sc = $$$OK
  try {
      $$$TRACE("visiting resource "_resource.id_" ("_resource.resourceType_")")
      s ..Resource = resource
      s ..Transform = ""    
      $$$TOE(sc,##class(Ens.Rule.Definition).EvaluateRules(..TransformRule,..%SessionId,$this,"Generate",.returnValue,.reason,..RuleLogging))    
      if returnValue {
        $$$TRACE("using transform "_..Transform)
        $$$TOE(sc,..SendTransformedMessage(..Transform,resource,referenceResolver))
      } else {
        $$$TRACE("no message from this resource")
      }
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

Method SendTransformedMessage(transform As %Dictionary.Classname, resource As HS.FHIR.DTL.vR4.Model.Base.Resource, ByRef aux As %RegisteredObject) As %Status [ Private ]
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException
  
  s sc = $$$OK
  try {    
    $$$TOE(sc,$classmethod(transform,"Transform",resource,.message,.aux))
    if $isobject(message) {
      $$$TOE(sc,..SendRequestAsync(..TargetConfigNames,message))
    }
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

}
