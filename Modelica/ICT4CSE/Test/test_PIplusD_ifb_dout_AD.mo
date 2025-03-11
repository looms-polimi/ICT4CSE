within ICT4CSE.Test;

model test_PIplusD_ifb_dout_AD
  extends ICT4CSE.Icons.CourseworkModel;
  
  parameter Real K = 4;
  parameter Real Ti = 10;
  parameter Real Td = 1;
  parameter Real N = 4;
  parameter Real CSmax = 1;
  parameter Real CSmin = -1;
  parameter Real Ts = 0.01;
  parameter Real Pn[:] = {1};
  parameter Real Pd[:] = {10, 11, 1};

  ICT4CSE.ControlBlocks.Modulating.Analogue.PIplusD_ifb_dout PplusID_dout_ifb_analogue(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti) annotation(
    Placement(visible = true, transformation(origin = {-110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_dout_analogue(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP(y = if time < 1 then 0 elseif time < 100 then 0.8
   elseif time < 200 then 1.2
   elseif time < 300 then 0.2    elseif time < 400 then 0.8 else 0.5) annotation(
    Placement(visible = true, transformation(origin = {-170, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_dout_digital(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PIplusD_ifb_dout PIplusD_ifb_dout_digital(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti,Ts=Ts) annotation(
    Placement(visible = true, transformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SP.y, PplusID_dout_ifb_analogue.SP) annotation(
    Line(points = {{-159, 76}, {-122, 76}}, color = {0, 0, 127}));
  connect(PplusID_dout_ifb_analogue.CS, P_dout_analogue.u) annotation(
    Line(points = {{-98, 70}, {-62, 70}}, color = {0, 0, 127}));
  connect(P_dout_analogue.y, PplusID_dout_ifb_analogue.PV) annotation(
    Line(points = {{-39, 70}, {-31, 70}, {-31, 50}, {-131, 50}, {-131, 64}, {-122, 64}}, color = {0, 0, 127}));
  connect(P_dout_digital.y, PIplusD_ifb_dout_digital.PV) annotation(
    Line(points = {{-39, 30}, {-33, 30}, {-33, 10}, {-131, 10}, {-131, 24}, {-123, 24}}, color = {0, 0, 127}));
  connect(PIplusD_ifb_dout_digital.CS, P_dout_digital.u) annotation(
    Line(points = {{-98, 30}, {-62, 30}}, color = {0, 0, 127}));
  connect(SP.y, PIplusD_ifb_dout_digital.SP) annotation(
    Line(points = {{-158, 76}, {-140, 76}, {-140, 36}, {-122, 36}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 500, Tolerance = 1e-06, Interval = 0.1),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "rungekutta"));
end test_PIplusD_ifb_dout_AD;
