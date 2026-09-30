within ICT4CSE.Examples.U03_Modulating_schemes;

model E01_PID_Bias_for_transient "Nonminimum antiwindup PID realisation, 1 versus 2 degrees of freedom:
   compare SP, PV and CS in the two PIDs"
  extends Icons.ExampleModel;
  parameter Real K = 1;
  parameter Real Ti = 10;
  parameter Real Td = 1;
  parameter Real N = 4;
  parameter Real b = 1;
  parameter Real c = 0;
  parameter Real CSmax = 1;
  parameter Real CSmin = -1;
  parameter Real Ts = 0.05;
  parameter Real Pn[:] = {1};
  parameter Real Pd[:] = {10, 11, 1};
  Modelica.Blocks.Sources.RealExpression SP(y = if time < 10 then 0 elseif time < 100 then 1 / 90 * (time - 10) else 1) annotation(
    Placement(visible = true, transformation(origin = {-112, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_noBias(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction P_bias(a = Pd, b = Pn) annotation(
    Placement(visible = true, transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_ISA_2dof PID_ISA_2dof(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti, Ts = Ts, b = b, c = c) annotation(
    Placement(visible = true, transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.ControlBlocks.Modulating.Digital.PID_ISA_2dof_bias PID_ISA_2dof_bias(CSmax = CSmax, CSmin = CSmin, K = K, N = N, Td = Td, Ti = Ti, Ts = Ts, b = b, c = c) annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(PID_ISA_2dof_bias.CS, P_bias.u) annotation(
    Line(points = {{-18, 30}, {18, 30}}, color = {0, 0, 127}));
  connect(PID_ISA_2dof.CS, P_noBias.u) annotation(
    Line(points = {{-18, -30}, {18, -30}}, color = {0, 0, 127}));
  connect(P_bias.y, PID_ISA_2dof_bias.PV) annotation(
    Line(points = {{42, 30}, {50, 30}, {50, 8}, {-52, 8}, {-52, 24}, {-42, 24}}, color = {0, 0, 127}));
  connect(P_noBias.y, PID_ISA_2dof.PV) annotation(
    Line(points = {{42, -30}, {48, -30}, {48, -50}, {-50, -50}, {-50, -36}, {-42, -36}}, color = {0, 0, 127}));
  connect(SP.y, PID_ISA_2dof_bias.SP) annotation(
    Line(points = {{-100, 36}, {-42, 36}}, color = {0, 0, 127}));
  connect(SP.y, PID_ISA_2dof.SP) annotation(
    Line(points = {{-100, 36}, {-60, 36}, {-60, -24}, {-42, -24}}, color = {0, 0, 127}));
  connect(SP.y, gain.u) annotation(
    Line(points = {{-100, 36}, {-80, 36}, {-80, 70}, {-62, 70}}, color = {0, 0, 127}));
  connect(gain.y, PID_ISA_2dof_bias.Bias) annotation(
    Line(points = {{-38, 70}, {-30, 70}, {-30, 42}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.4),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end E01_PID_Bias_for_transient;