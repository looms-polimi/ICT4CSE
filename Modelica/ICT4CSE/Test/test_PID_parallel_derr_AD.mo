within ICT4CSE.Test;

model test_PID_parallel_derr_AD
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
  Modelica.Blocks.Continuous.TransferFunction P_analogue(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP(y = if time < 1 then 0 elseif time < 100 then 0.8
   elseif time < 200 then 1.2
   elseif time < 300 then 0.2    elseif time < 400 then 0.8 else 0.5) annotation(
    Placement(visible = true, transformation(origin = {-170, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_digital(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Analogue.PID_parallel_derr PID_analogue_parallel_derr(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti)  annotation(
    Placement(visible = true, transformation(origin = {-110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_parallel_derr PID_digital_parallel_derr(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti, Ts = Ts)  annotation(
    Placement(visible = true, transformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SP.y, PID_analogue_parallel_derr.SP) annotation(
    Line(points = {{-158, 76}, {-122, 76}}, color = {0, 0, 127}));
  connect(PID_analogue_parallel_derr.CS, P_analogue.u) annotation(
    Line(points = {{-98, 70}, {-62, 70}}, color = {0, 0, 127}));
  connect(P_analogue.y, PID_analogue_parallel_derr.PV) annotation(
    Line(points = {{-38, 70}, {-30, 70}, {-30, 50}, {-130, 50}, {-130, 64}, {-122, 64}}, color = {0, 0, 127}));
  connect(SP.y, PID_digital_parallel_derr.SP) annotation(
    Line(points = {{-158, 76}, {-140, 76}, {-140, 36}, {-122, 36}}, color = {0, 0, 127}));
  connect(PID_digital_parallel_derr.CS, P_digital.u) annotation(
    Line(points = {{-98, 30}, {-62, 30}}, color = {0, 0, 127}));
  connect(P_digital.y, PID_digital_parallel_derr.PV) annotation(
    Line(points = {{-38, 30}, {-32, 30}, {-32, 10}, {-130, 10}, {-130, 24}, {-122, 24}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 500, Tolerance = 1e-06, Interval = 0.0625),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "rungekutta", variableFilter = ".*"));
end test_PID_parallel_derr_AD;