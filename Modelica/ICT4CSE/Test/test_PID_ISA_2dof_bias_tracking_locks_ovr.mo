within ICT4CSE.Test;

model test_PID_ISA_2dof_bias_tracking_locks_ovr
  extends ICT4CSE.Icons.TestModel;
  
  parameter Real K = 4;
  parameter Real Ti = 10;
  parameter Real Td = 1;
  parameter Real N = 4;
  parameter Real CSmax = 1;
  parameter Real CSmin = -1;
  parameter Real Ts = 0.05;
  parameter Real Pn[:] = {1};
  parameter Real Pd[:] = {10, 11, 1};
  Modelica.Blocks.Continuous.TransferFunction P(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP(y = if time < 1 then 0 elseif time < 100 then 0.8
   elseif time < 200 then 1.2
   elseif time < 300 then 0.2    elseif time < 400 then 0.8 else 0.5) annotation(
    Placement(transformation(origin = {-92, 30}, extent = {{-10, -10}, {10, 10}})));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_ISA_2dof_bias_tracking_locks_ovr PID(CSstart = 1,Ts = 0.1)  annotation(
    Placement(transformation(origin = {-12, 14}, extent = {{-10, -20}, {10, 20}})));
equation
  connect(SP.y, PID.SP) annotation(
    Line(points = {{-81, 30}, {-24, 30}}, color = {0, 0, 127}));
  connect(PID.CS, P.u) annotation(
    Line(points = {{0, 30}, {38, 30}}, color = {0, 0, 127}));
  connect(P.y, PID.PV) annotation(
    Line(points = {{62, 30}, {68, 30}, {68, -20}, {-32, -20}, {-32, 24}, {-24, 24}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 500, Tolerance = 1e-06, Interval = 0.1),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "rungekutta"));
end test_PID_ISA_2dof_bias_tracking_locks_ovr;