within ICT4CSE.Test;

model test_PID_PiplusD_ifb_derr_AD
  extends ICT4CSE.Icons.CourseworkModel;
  
  parameter Real K = 4;
  parameter Real Ti = 10;
  parameter Real Td = 0.1;
  parameter Real N = 4;
  parameter Real CSmax = 1;
  parameter Real CSmin = -1;
  parameter Real Ts = 0.01;
  parameter Real Pn[:] = {1};
  parameter Real Pd[:] = {10, 11, 1};

  ICT4CSE.ControlBlocks.Modulating.Analogue.PID_ifb_derr PID_ifb_derr_analogue(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti) annotation(
    Placement(visible = true, transformation(origin = {-110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_PID_analogue(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP(y = if time < 1 then 0 elseif time < 100 then 0.8
   elseif time < 200 then 1.2
   elseif time < 300 then 0.2    elseif time < 400 then 0.8 else 0.5) annotation(
    Placement(visible = true, transformation(origin = {-170, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_PIplusD_analogue(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Analogue.PIplusD_ifb_derr PIplusD_ifb_derr_analogue(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti) annotation(
    Placement(visible = true, transformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_PID_digital(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_ifb_derr PID_ifb_derr_digital(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti,Ts=Ts) annotation(
    Placement(visible = true, transformation(origin = {-110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_PIplusD_digital(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PIplusD_ifb_derr PIplusD_ifb_derr_digital(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti, Ts = Ts) annotation(
    Placement(visible = true, transformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SP.y, PID_ifb_derr_analogue.SP) annotation(
    Line(points = {{-159, 76}, {-122, 76}}, color = {0, 0, 127}));
  connect(PID_ifb_derr_analogue.CS, P_PID_analogue.u) annotation(
    Line(points = {{-98, 70}, {-62, 70}}, color = {0, 0, 127}));
  connect(P_PID_analogue.y, PID_ifb_derr_analogue.PV) annotation(
    Line(points = {{-39, 70}, {-31, 70}, {-31, 50}, {-131, 50}, {-131, 64}, {-122, 64}}, color = {0, 0, 127}));
  connect(PIplusD_ifb_derr_analogue.CS, P_PIplusD_analogue.u) annotation(
    Line(points = {{-98, 30}, {-62, 30}}, color = {0, 0, 127}));
  connect(P_PIplusD_analogue.y, PIplusD_ifb_derr_analogue.PV) annotation(
    Line(points = {{-39, 30}, {-31, 30}, {-31, 10}, {-131, 10}, {-131, 24}, {-123, 24}}, color = {0, 0, 127}));
  connect(P_PID_digital.y, PID_ifb_derr_digital.PV) annotation(
    Line(points = {{-38, -10}, {-32, -10}, {-32, -30}, {-130, -30}, {-130, -16}, {-122, -16}}, color = {0, 0, 127}));
  connect(PID_ifb_derr_digital.CS, P_PID_digital.u) annotation(
    Line(points = {{-98, -10}, {-62, -10}}, color = {0, 0, 127}));
  connect(SP.y, PIplusD_ifb_derr_analogue.SP) annotation(
    Line(points = {{-158, 76}, {-140, 76}, {-140, 36}, {-122, 36}}, color = {0, 0, 127}));
  connect(SP.y, PID_ifb_derr_digital.SP) annotation(
    Line(points = {{-158, 76}, {-140, 76}, {-140, -4}, {-122, -4}}, color = {0, 0, 127}));
  connect(SP.y, PIplusD_ifb_derr_digital.SP) annotation(
    Line(points = {{-158, 76}, {-140, 76}, {-140, -44}, {-122, -44}}, color = {0, 0, 127}));
  connect(PIplusD_ifb_derr_digital.CS, P_PIplusD_digital.u) annotation(
    Line(points = {{-98, -50}, {-62, -50}}, color = {0, 0, 127}));
  connect(P_PIplusD_digital.y, PIplusD_ifb_derr_digital.PV) annotation(
    Line(points = {{-38, -50}, {-32, -50}, {-32, -70}, {-130, -70}, {-130, -56}, {-122, -56}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 500, Tolerance = 1e-06, Interval = 0.1),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "rungekutta", variableFilter = ".*"));
end test_PID_PiplusD_ifb_derr_AD;