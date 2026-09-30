within ICT4CSE.Examples.U02_Modulating_blocks_realisation;

model E05_PID_nonminimum_pos_vs_inc
  "Positional versus incremantal nonminimumPID realisations:
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

  ControlBlocks.Modulating.Digital.PID_1dof_nonminimum PID_pos(CSmax = CSmax, CSmin = CSmin,K = K, N = N, Td = Td, Ti = Ti, Ts = Ts) annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_pos(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP(y = if time < 1 then 0 elseif time < 100 then 0.8
   elseif time < 200 then 1.2 elseif time<300 then 0.2 else 0.8) annotation(
    Placement(visible = true, transformation(origin = {-170, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ControlBlocks.Modulating.Digital.PID_1dof_nonminimum_incremental PID_inc(CSmax = CSmax, CSmin = CSmin,K = K, N = N, Td = Td, Ti = Ti, Ts = Ts) annotation(
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_inc(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SP.y, PID_pos.SP) annotation(
    Line(points = {{-158, 76}, {-102, 76}}, color = {0, 0, 127}));
  connect(PID_pos.CS, P_pos.u) annotation(
    Line(points = {{-78, 70}, {-22, 70}}, color = {0, 0, 127}));
  connect(P_pos.y, PID_pos.PV) annotation(
    Line(points = {{2, 70}, {10, 70}, {10, 50}, {-110, 50}, {-110, 64}, {-102, 64}}, color = {0, 0, 127}));
  connect(SP.y, PID_inc.SP) annotation(
    Line(points = {{-158, 76}, {-140, 76}, {-140, 36}, {-102, 36}}, color = {0, 0, 127}));
  connect(PID_inc.CS, P_inc.u) annotation(
    Line(points = {{-78, 30}, {-22, 30}}, color = {0, 0, 127}));
  connect(P_inc.y, PID_inc.PV) annotation(
    Line(points = {{2, 30}, {10, 30}, {10, 10}, {-110, 10}, {-110, 24}, {-102, 24}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.8),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end E05_PID_nonminimum_pos_vs_inc;