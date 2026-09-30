within ICT4CSE.Examples.U02_Modulating_blocks_realisation;

model E02_PIplusD_ifb_dout_vs_derr
  "Internal feedback PI realisation, error versus output derivative:
   compare SP, PV and CS in the two PIDs"
   extends Icons.ExampleModel;

  parameter Real K=1;
  parameter Real Ti=10;
  parameter Real Td=1;
  parameter Real N=4;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;
  parameter Real Ts=0.05;
  parameter Real Pn[:]={1};
  parameter Real Pd[:]={10,11,1};

  ControlBlocks.Modulating.Digital.PIplusD_ifb_dout PIplusD_ifb_dout(CSmax = CSmax, CSmin = CSmin,K = K, N = N, Td = Td, Ti = Ti, Ts = Ts) annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_dout(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP(y = if time < 1 then 0 elseif time < 100 then 0.8
   elseif time < 200 then 1.2 elseif time<300 then 0.2    elseif time < 400 then 0.8 else 0.5) annotation(
    Placement(visible = true, transformation(origin = {-170, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ControlBlocks.Modulating.Digital.PIplusD_ifb_derr PIplusD_ifb_derr(CSmax = CSmax, CSmin = CSmin,K = K, N = N, Td = Td, Ti = Ti, Ts = Ts) annotation(
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_derr(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SP.y, PIplusD_ifb_dout.SP) annotation(
    Line(points = {{-158, 76}, {-102, 76}}, color = {0, 0, 127}));
  connect(PIplusD_ifb_dout.CS, P_dout.u) annotation(
    Line(points = {{-78, 70}, {-22, 70}}, color = {0, 0, 127}));
  connect(P_dout.y, PIplusD_ifb_dout.PV) annotation(
    Line(points = {{2, 70}, {10, 70}, {10, 50}, {-110, 50}, {-110, 64}, {-102, 64}}, color = {0, 0, 127}));
  connect(SP.y, PIplusD_ifb_derr.SP) annotation(
    Line(points = {{-158, 76}, {-140, 76}, {-140, 36}, {-102, 36}}, color = {0, 0, 127}));
  connect(PIplusD_ifb_derr.CS, P_derr.u) annotation(
    Line(points = {{-78, 30}, {-22, 30}}, color = {0, 0, 127}));
  connect(P_derr.y, PIplusD_ifb_derr.PV) annotation(
    Line(points = {{2, 30}, {10, 30}, {10, 10}, {-110, 10}, {-110, 24}, {-102, 24}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.8),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end E02_PIplusD_ifb_dout_vs_derr;