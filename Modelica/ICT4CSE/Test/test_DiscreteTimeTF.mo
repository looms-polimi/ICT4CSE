within ICT4CSE.Test;

model test_DiscreteTimeTF
  extends Icons.TestModel;
  ICT4CSE.Blocks.DiscreteTimeTF TF annotation(
    Placement(visible = true, transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression u(y = if time < 1 then 0 else 1)  annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(u.y, TF.u) annotation(
    Line(points = {{-18, 10}, {-2, 10}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-6, Interval = 0.04),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", variableFilter = ".*"));
end test_DiscreteTimeTF;