Class ks.fhir.dtl.vr4.ba.SyntheaBundleGeneratorAdapter Extends Ens.InboundAdapter
{

Parameter SETTINGS = "CallInterval,SyntheaHome,SyntheaOutputDirectory,PatientCount,Seed,BatchCount";

/// Synthea home directory
Property SyntheaHome As %String(MAXLEN = 1024) [ InitialExpression = {^RepositoryRoot_"/synthea"} ];

/// Synthea output directory, CAVEAT: will be cleaned up on init
Property SyntheaOutputDirectory As %String(MAXLEN = 1024) [ InitialExpression = {^RepositoryRoot_"/synthea/output/fhir"} ];

/// Number of patients to generate per batch
Property PatientCount As %Integer [ InitialExpression = 1, Required ];

/// Number of batches to generate
Property BatchCount As %Integer [ InitialExpression = 1, Required ];

/// Generator integer seed, if left empty, synthea will use a random seed
Property Seed As %Integer;

/// Transient property set to true after all output from current synthea run has been passed to the business host
Property BatchComplete As %Boolean [ Transient ];

Property CompletedBatchCount As %Integer [ Private, Transient ];

Method OnInit() As %Status
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException
  
  s sc = $$$OK
  try {
    s ..BatchComplete = 0
    s ..CompletedBatchCount = 0
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

Method OnTask() As %Status
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException
  
  s sc = $$$OK
  try {
    if ..CompletedBatchCount < ..BatchCount {
      s ..BatchComplete = 0
      $$$TOE(sc,..CleanOutputDirectory())
      $$$TOE(sc,..RunSynthea())
      $$$TOE(sc,..ProcessSyntheaOutput())
      s ..BatchComplete = 1
      $$$TOE(sc,..BusinessHost.ProcessInput($$$NULLOREF))
      s ..CompletedBatchCount = ..CompletedBatchCount + 1
    }
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

Method RunSynthea() As %Status [ Private ]
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException
  
  s sc = $$$OK
  try {
    s x = $zf(-1,"cd "_..SyntheaHome_" && ./run_synthea -p "_..PatientCount_$select(..Seed="":"",1:" -s "_..Seed))
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

Method ProcessSyntheaOutput() As %Status [ Private ]
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException

  #dim fileName as %String
  #dim resource As HS.FHIR.DTL.vR4.Model.Base.Resource
  
  s sc = $$$OK
  try {
		set fileName = $zsearch(##class(%File).NormalizeFilename("*.json",..SyntheaOutputDirectory))
		while fileName '= "" {
      s resource = ##class(HS.FHIR.DTL.Util.JSON.Adapter).FromJSONFile(fileName,"vR4")
      if $isobject(resource) {
        $$$TOE(sc,..BusinessHost.ProcessInput(resource))      
      }      
			set fileName = $zsearch("")
		}    
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

Method CleanOutputDirectory() As %Status [ Private ]
{
  #dim sc as %Status
  #dim ex as %Exception.AbstractException

  #dim fileName as %String
  
  s sc = $$$OK
  try {
		set fileName = $zsearch(##class(%File).NormalizeFilename("*.json",..SyntheaOutputDirectory))
		while fileName '= "" {
      d ##class(%File).Delete(fileName)									
			set fileName = $zsearch("")
		}    
  } catch (ex) {
    s sc = ex.AsStatus()
  }
  return sc
}

}
