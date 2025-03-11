within ICT4CSE.Test;

model test_DiscreteTimeTF
  extends Icons.TestModel;
  ICT4CSE.Blocks.DiscreteTimeTF TF1(den = {1, 3, 3, 1}, num = {1})  annotation(
    Placement(visible = true, transformation(origin = {10, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression u(y = if time < 1 then 0 else 1)  annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.Blocks.DiscreteTimeTF TF2(Ts = 0.05, den = {1, 0.5, 1}, num = {1})  annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ICT4CSE.Blocks.DiscreteTimeTF TF3(den = {1}, num = {1})  annotation(
    Placement(visible = true, transformation(origin = {10, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(u.y, TF1.u) annotation(
    Line(points = {{-59, 0}, {-20, 0}, {-20, 40}, {-2, 40}}, color = {0, 0, 127}));
  connect(u.y, TF2.u) annotation(
    Line(points = {{-58, 0}, {-2, 0}}, color = {0, 0, 127}));
  connect(u.y, TF3.u) annotation(
    Line(points = {{-58, 0}, {-20, 0}, {-20, -40}, {-2, -40}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-6, Interval = 0.04),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", variableFilter = ".*"));
end test_DiscreteTimeTF;