within ICT4CSE.Examples.U01_Introductory_example;

model Simulation_example_01
  extends Icons.ExampleModel;
  Discrete_time_linear_PI PI(K = 0.7, Ti = 10, Ts = 0.05)  annotation(
    Placement(visible = true, transformation(origin = {-44, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction Process(a = {10, 11, 1}, b = {10})  annotation(
    Placement(visible = true, transformation(origin = {10, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression w(y = if time < 1 then 0 else 1)  annotation(
    Placement(visible = true, transformation(origin = {-116, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(PI.u, Process.u) annotation(
    Line(points = {{-32, 28}, {-2, 28}}, color = {0, 0, 127}));
  connect(Process.y, PI.y) annotation(
    Line(points = {{22, 28}, {32, 28}, {32, 2}, {-68, 2}, {-68, 26}, {-56, 26}, {-56, 24}}, color = {0, 0, 127}));
  connect(w.y, PI.w) annotation(
    Line(points = {{-104, 32}, {-56, 32}}, color = {0, 0, 127}));
annotation(
    experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-6, Interval = 0.04),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end Simulation_example_01;