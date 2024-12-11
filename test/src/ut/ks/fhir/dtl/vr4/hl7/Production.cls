Class ut.ks.fhir.dtl.vr4.hl7.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="ut.ks.fhir.dtl.vr4.hl7.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description>Test production for FHIR-HL7 message generator</Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="HL7FromSynthea" Category="" ClassName="ks.fhir.dtl.vr4.bs.SyntheaGeneratorService" PoolSize="1" Enabled="true" Foreground="false" Comment="Run synthea and generate HL7 messages from FHIR output" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">HL7ToFile</Setting>
    <Setting Target="Adapter" Name="CallInterval">30</Setting>
    <Setting Target="Adapter" Name="SyntheaHome">/opt/irisbuild/synthea</Setting>
    <Setting Target="Adapter" Name="SyntheaOutputDirectory">/opt/irisbuild/synthea/output/fhir</Setting>
  </Item>
  <Item Name="HL7ToFile" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="Filename">%f_%Q%!+(_a).hl7</Setting>  
  </Item>
</Production>
}

}
