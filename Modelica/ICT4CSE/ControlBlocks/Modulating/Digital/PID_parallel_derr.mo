within ICT4CSE.ControlBlocks.Modulating.Digital;

model PID_parallel_derr
  "Digital parallel PID with error derivation and AW by integral action recomputation"
  extends BaseClasses.SISO_D_SP_PV_CS_200x200;
  parameter Real K = 1;
  parameter Real Ti = 10;
  parameter Real Td = 1;
  parameter Real N = 4;
  parameter Real CSmax = 1;
  parameter Real CSmin = -1;
  discrete Real e,de, up, ui, ud, e1, ui1, ud1;

algorithm
  when sample(0, Ts) then
       e   := w - y;
       up  := K * e;
       ui  := ui1 + K * Ts / Ti * e;
       de  := e-e1;
       ud  := (Td * ud1 + K * N * Td * de) / (Td + N * Ts);
       u   := max(CSmin, min(CSmax, up + ui + ud));
       e1  := e;
       ui1 := u - up - ud;
       ud1 := ud;
  end when;
initial algorithm
  e1  := 0;
  ui1 := 0;
  ud1 := 0;
  annotation(
    Icon(graphics = {Text(origin = {-1, -1}, extent = {{81, -87}, {-81, 87}}, textString = "PID
parallel
derr")}),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end PID_parallel_derr;