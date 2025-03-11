within ICT4CSE.Courseware.U03_Modulating_schemes;

model Decoupling_with_bias

  parameter Boolean bOn=true;


  ICT4CSE.ProcessBlocks.TITO_rational_zeroInit Process annotation(
    Placement(visible = true, transformation(origin = {70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.Decoupler_2x2_lead_lag Decoupler(Ts = 0.01, u1_to_bias2_Tp = 3, u1_to_bias2_Tz = 1.2, u1_to_bias2_mu = 0.3 / 1.5, u2_to_bias1_Tp = 2, u2_to_bias1_Tz = 1, u2_to_bias1_mu = 0.5 / 1) annotation(
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_ISA_2dof_bias PID_1(BiasOn = bOn,K = 2, Td = 0, Ti = 1, Ts = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_ISA_2dof_bias PID_2(BiasOn = bOn,K = 1.2, Td = 0, Ti = 1.2, Ts = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP_1(y = if time < 50 then 0.2 else 0.5) annotation(
    Placement(visible = true, transformation(origin = {-110, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP_2(y = if time < 100 then 0.1 else 0.4) annotation(
    Placement(visible = true, transformation(origin = {-110, -4}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
equation
  connect(PID_1.CS, Decoupler.v1) annotation(
    Line(points = {{-38, 30}, {-30, 30}, {-30, 16}, {-22, 16}}, color = {0, 0, 127}));
  connect(PID_2.CS, Decoupler.v2) annotation(
    Line(points = {{-38, -10}, {-30, -10}, {-30, 4}, {-22, 4}}, color = {0, 0, 127}));
  connect(Process.y1, PID_1.PV) annotation(
    Line(points = {{82, 16}, {90, 16}, {90, 50}, {-70, 50}, {-70, 36}, {-62, 36}}, color = {0, 0, 127}));
  connect(Process.y2, PID_2.PV) annotation(
    Line(points = {{82, 4}, {90, 4}, {90, -30}, {-70, -30}, {-70, -16}, {-62, -16}}, color = {0, 0, 127}));
  connect(SP_1.y, PID_1.SP) annotation(
    Line(points = {{-98, 24}, {-62, 24}}, color = {0, 0, 127}));
  connect(SP_2.y, PID_2.SP) annotation(
    Line(points = {{-98, -4}, {-62, -4}}, color = {255, 127, 0}));
  connect(Decoupler.bias1, PID_1.Bias) annotation(
    Line(points = {{-22, 12}, {-50, 12}, {-50, 18}}, color = {0, 0, 127}));
  connect(Decoupler.bias2, PID_2.Bias) annotation(
    Line(points = {{-22, 8}, {-50, 8}, {-50, 2}}, color = {0, 0, 127}));
  connect(Decoupler.u1, Process.u1) annotation(
    Line(points = {{2, 16}, {58, 16}}, color = {0, 0, 127}));
  connect(Decoupler.u2, Process.u2) annotation(
    Line(points = {{2, 4}, {58, 4}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.03),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end Decoupling_with_bias;